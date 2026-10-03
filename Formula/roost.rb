class Roost < Formula
  desc "A per-project remote workspace in one binary: browser IDE layout over real terminals that survive the tab, built for AI-assisted development"
  homepage "https://github.com/PeterKnego/roost"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/PeterKnego/roost/releases/download/v0.7.0/roost-aarch64-apple-darwin.tar.xz"
      sha256 "c870f9daad602d34020490286763448cb6e1766216c315647b19eff33cc8fb2b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/PeterKnego/roost/releases/download/v0.7.0/roost-x86_64-apple-darwin.tar.xz"
      sha256 "054b796216c2d9185da7fe81113c57cae353ef317b28189ad4819f6a1a1365b6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/PeterKnego/roost/releases/download/v0.7.0/roost-aarch64-unknown-linux-musl.tar.xz"
      sha256 "de690d75a8151815cae2a49667de19e93dee15d1f739cec75dbcd98dd9e7bf26"
    end
    if Hardware::CPU.intel?
      url "https://github.com/PeterKnego/roost/releases/download/v0.7.0/roost-x86_64-unknown-linux-musl.tar.xz"
      sha256 "8b0326809d7a8b25beafbd667ed0b019e0d624e348c55eecd8af7d79707ae9dd"
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
