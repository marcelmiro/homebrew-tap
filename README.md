# marcelmiro/homebrew-tap

```sh
brew uninstall mosh   # if homebrew-core's is installed
brew install --HEAD marcelmiro/tap/mosh
brew upgrade --fetch-HEAD mosh   # pick up new commits on the branch
```

`mosh` builds [marcelmiro/mosh@cursor-style](https://github.com/marcelmiro/mosh/tree/cursor-style):
upstream master plus cursor-shape (DECSCUSR) support, so Neovim's insert-mode
bar cursor survives a mosh session. Both ends need it.
