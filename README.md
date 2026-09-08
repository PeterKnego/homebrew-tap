# peterknego/homebrew-tap

Homebrew formulae for [roost](https://github.com/PeterKnego/roost) — a
per-project remote workspace in one binary: a browser IDE layout over real
terminals that survive the tab.

```sh
brew install peterknego/tap/roost
```

Case does not matter — Homebrew downcases a tap name, so `PeterKnego/tap` and
`peterknego/tap` are the same thing.

The formulae here are generated and pushed by
[dist](https://github.com/axodotdev/cargo-dist) on each tagged release of
roost. Edit them upstream, not here. This tap is not roost-only: anything else
from this account that ships a binary lands here too, so tapping once is enough.

## Two things to know before you install

**roost binds `127.0.0.1` and has no authentication of its own.** The loopback
bind *is* the security boundary — the websocket spawns a shell. Reach it from
another machine over SSH forwarding or a private tunnel. Do not put it on a
public interface.

**The binary is called `roost`, and it is not the only one.** An unrelated
project, `navbytes/roost`, ships a binary of the same name through its own tap.
If you have both, you get whichever comes first on your `PATH`. Install by the
fully-qualified name to be sure which formula you are getting.
