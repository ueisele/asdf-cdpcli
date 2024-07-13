# asdf-cdpcli


[cdpcli](https://github.com/cloudera/cdpcli) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [License](#license)

# Dependencies

- Check the [dependencies](lib/dependencies.txt) file

# Install

Plugin:

```shell
asdf plugin add cdpcli
# or
asdf plugin add cdpcli https://github.com/ueisele/asdf-cdpcli.git
```

cdpcli:

```shell
# Show all installable versions
asdf list-all cdpcli

# Install specific version
asdf install cdpcli stable-0.9.117
asdf install cdpcli beta-0.9.117

# Now cdpcli commands are available
cdp --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# License

See [LICENSE](LICENSE) © [Uwe Eisele](https://github.com/ueisele/)
