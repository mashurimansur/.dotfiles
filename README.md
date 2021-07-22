Usage
-----

1. Install (using [yadm], which is effectively just a dope wrapper around git):

```sh
case "${OSTYPE:?}" in
  linux*)   sudo apt install -y yadm ;;
  darwin*)  brew install yadm ;;
esac
```

2. Clone:

```sh
yadm clone --bootstrap 'git@github.com:mashurimansur/dotfiles.git'
```