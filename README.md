# marcelmiro/homebrew-tap

```sh
brew uninstall mosh   # if homebrew-core's is installed
brew install --HEAD marcelmiro/tap/mosh
brew upgrade --fetch-HEAD mosh   # pick up new commits on the branch
```

`mosh` builds [marcelmiro/mosh@cursor-style](https://github.com/marcelmiro/mosh/tree/cursor-style):
upstream master plus cursor-shape (DECSCUSR) support, so Neovim's insert-mode
bar cursor survives a mosh session. Both ends need it.

The full setup (why it's patched, the Linux `.deb`, taking upstream updates,
failure modes) is documented in the mosh section of `~/.dotfiles/README.md`,
installed by `~/.dotfiles/bin/install-mosh`.
