class Roost < Formula
  desc "A per-project remote workspace in one binary: browser IDE layout over real terminals that survive the tab, built for AI-assisted development"
  homepage "https://github.com/PeterKnego/roost"
  version "0.9.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/PeterKnego/roost/releases/download/v0.9.1/roost-aarch64-apple-darwin.tar.xz"
      sha256 "fb00641386daf5ac6a3fa902f97610f1f7cf56b19fb181baf5623a8836ce6d8f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/PeterKnego/roost/releases/download/v0.9.1/roost-x86_64-apple-darwin.tar.xz"
      sha256 "0d25b85c7e317e60d591d426677dcd52ac9adca1a6f93b0aa7cf151702f8cf4a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/PeterKnego/roost/releases/download/v0.9.1/roost-aarch64-unknown-linux-musl.tar.xz"
      sha256 "ce8ef4f18da729743ed27b4970edd5defa0b192289d25c0e44798ca618fdd3d5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/PeterKnego/roost/releases/download/v0.9.1/roost-x86_64-unknown-linux-musl.tar.xz"
      sha256 "10cbeea39701dae040929481e1f36ee7aa7579c226205d3fe746ca56ab9f1969"
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
