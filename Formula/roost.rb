class Roost < Formula
  desc "A per-project remote workspace in one binary: browser IDE layout over real terminals that survive the tab, built for AI-assisted development"
  homepage "https://github.com/PeterKnego/roost"
  version "0.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/PeterKnego/roost/releases/download/v0.5.2/roost-aarch64-apple-darwin.tar.xz"
      sha256 "5907ee9e129831103e3b7a26592f1299f3b544c1cef744618dd8f4e03e5c9c6b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/PeterKnego/roost/releases/download/v0.5.2/roost-x86_64-apple-darwin.tar.xz"
      sha256 "0067964f1b225886c72bb6d4b081cd056567811043551e587bc5fa601147e72d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/PeterKnego/roost/releases/download/v0.5.2/roost-aarch64-unknown-linux-musl.tar.xz"
      sha256 "b2a577c2e5139f0e5031f6308c242a46a8bb9298562b30b2529cc7170c188e6e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/PeterKnego/roost/releases/download/v0.5.2/roost-x86_64-unknown-linux-musl.tar.xz"
      sha256 "be26724422d0bec7281cbb7599ea53fb3e99c65e70f9984bd8f657d7bb12e194"
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
