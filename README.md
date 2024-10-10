<div align="center">

# asdf-kubeswitch [![Build](https://github.com/PetteriVaarala/asdf-kubeswitch/actions/workflows/build.yml/badge.svg)](https://github.com/PetteriVaarala/asdf-kubeswitch/actions/workflows/build.yml) [![Lint](https://github.com/PetteriVaarala/asdf-kubeswitch/actions/workflows/lint.yml/badge.svg)](https://github.com/PetteriVaarala/asdf-kubeswitch/actions/workflows/lint.yml)

[kubeswitch](https://github.com/danielfoehrKn/kubeswitch) plugin for the [Mise](https://mise.jdx.de) / [asdf](https://asdf-vm.com) version manager.

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).

# Install

## Mise
Plugin:

```shell
mise plugin install kubeswitch
# or
mise plugin install kubeswitch https://github.com/PetteriVaarala/asdf-kubeswitch.git
```

kubeswitch:

```shell
# Show all installable versions
mise ls-remote kubeswitch

# Install specific version
mise install kubeswitch latest

# Set a version globally (on your ~/.config/mise/config.toml file)
mise use --global kubeswitch

# REQUIRED! Source the shell function
# https://github.com/danielfoehrKn/kubeswitch/blob/master/docs/installation.md#required-source-the-shell-function
echo 'source <(switcher init bash)' >> ~/.bashrc
echo 'source <(switcher init zsh)' >> ~/.zshrc

# Now kubeswitch commands are available
switch --version
```

## asdf
Plugin:

```shell
asdf plugin add kubeswitch
# or
asdf plugin add kubeswitch https://github.com/PetteriVaarala/asdf-kubeswitch.git
```

kubeswitch:

```shell
# Show all installable versions
asdf list-all kubeswitch

# Install specific version
asdf install kubeswitch latest

# Set a version globally (on your ~/.tool-versions file)
asdf global kubeswitch latest

# REQUIRED! Source the shell function
# https://github.com/danielfoehrKn/kubeswitch/blob/master/docs/installation.md#required-source-the-shell-function
echo 'source <(switcher init bash)' >> ~/.bashrc
echo 'source <(switcher init zsh)' >> ~/.zshrc

# Now kubeswitch commands are available
switch --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/PetteriVaarala/asdf-kubeswitch/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Petteri Vaarala](https://github.com/PetteriVaarala/)
