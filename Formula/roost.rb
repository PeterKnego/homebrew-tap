class Roost < Formula
  desc "A per-project remote workspace in one binary: browser IDE layout over real terminals that survive the tab, built for AI-assisted development"
  homepage "https://github.com/PeterKnego/roost"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/PeterKnego/roost/releases/download/v0.8.0/roost-aarch64-apple-darwin.tar.xz"
      sha256 "e4d264cb4302656fac93c8435401811be8d4b7e4bed87338eda02b2001f2ff47"
    end
    if Hardware::CPU.intel?
      url "https://github.com/PeterKnego/roost/releases/download/v0.8.0/roost-x86_64-apple-darwin.tar.xz"
      sha256 "2cf9e16c95e59a2da2bcc0116e65037b72a7552b47fe73f983edf83bf2166669"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/PeterKnego/roost/releases/download/v0.8.0/roost-aarch64-unknown-linux-musl.tar.xz"
      sha256 "0356c6c1368c856a8493f970da8b5767b9d3f58e7f97b09eb612300581abcc57"
    end
    if Hardware::CPU.intel?
      url "https://github.com/PeterKnego/roost/releases/download/v0.8.0/roost-x86_64-unknown-linux-musl.tar.xz"
      sha256 "be4743d4a572df9ea6535481f1dfecbc8533e8c59038dc36540e725e94330a78"
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
