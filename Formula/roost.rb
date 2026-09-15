class Roost < Formula
  desc "A per-project remote workspace in one binary: browser IDE layout over real terminals that survive the tab, built for AI-assisted development"
  homepage "https://github.com/PeterKnego/roost"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/PeterKnego/roost/releases/download/v0.6.0/roost-aarch64-apple-darwin.tar.xz"
      sha256 "d9f57150391751fecf74440602ba278071769e2c0688e5d64c4cbaf43e6c75c8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/PeterKnego/roost/releases/download/v0.6.0/roost-x86_64-apple-darwin.tar.xz"
      sha256 "7f92e4a97df2e51ca599c6c989aaacdd7594cab8aa02f023710bb12c1f6c7b04"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/PeterKnego/roost/releases/download/v0.6.0/roost-aarch64-unknown-linux-musl.tar.xz"
      sha256 "ae7a996109ecb2ce88c218c3acbbc1c41a0001d2df3757b1f5e736a7203a271e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/PeterKnego/roost/releases/download/v0.6.0/roost-x86_64-unknown-linux-musl.tar.xz"
      sha256 "52adf5c5d76d066fd579122d7c411a0fc1ddf1dd513ab37c11d1d9918060db6c"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]
  depends_on "dtach"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "roost"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "roost"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "roost"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "roost"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
