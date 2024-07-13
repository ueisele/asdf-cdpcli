#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/cloudera/cdpcli"
TOOL_STABLE_NAME="cdpcli"
TOOL_BETA_NAME="cdpcli-beta"
TOOL_TEST="cdp --help"

curl_opts=(-fsSL)

fail() {
  echo -e "asdf-$TOOL_STABLE_NAME: $*"
  exit 1
}

print_file() {
  while read -r l || [ -n "${l}" ]; do
    echo "$l"
  done <${1}
}

_sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

_list_all_versions_stable() {
  curl ${curl_opts[@]} https://pypi.org/pypi/${TOOL_STABLE_NAME}/json |
    jq -r '.releases | to_entries[] | .key' | awk '{print "stable-"$0}' |
    _sort_versions
}

_list_all_versions_beta() {
  curl ${curl_opts[@]} https://pypi.org/pypi/${TOOL_BETA_NAME}/json |
    jq -r '.releases | to_entries[] | .key' | awk '{print "beta-"$0}' |
    _sort_versions
}

list_all_versions() {
  _list_all_versions_stable
  _list_all_versions_beta
}

install() {
  local type=$1
  local version=$2
  local path=$3

  # check install type
  if [ "$type" != "version" ]; then
    fail "only version installs are supported"
  fi

  if command -v pip3 >/dev/null; then
    if [[ "${version}" =~ ^beta- ]]; then
      local tool_name="${TOOL_BETA_NAME}"
      local version="${version#"beta-"}"
    elif [[ "${version}" =~ ^stable- ]]; then
      local tool_name="${TOOL_STABLE_NAME}"
      local version="${version#"stable-"}"
    else 
      fail "unknown version ${version}"
    fi
    echo "Installing ${tool_name} with pip3"
    pip3 install --target="${path}" ${tool_name}==${version}
  else
    fail "depdencies aren't met and the installation won't proceed"
  fi
}