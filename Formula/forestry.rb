class Forestry < Formula
  desc "The forestry application"
  homepage "https://github.com/RichardVanLeeuwen/forestry"
  version "0.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/RichardVanLeeuwen/forestry/releases/download/v0.0.2/forestry-aarch64-apple-darwin.tar.xz"
      sha256 "9f7d6a10ca0766ea658aad24be9515ef3f468bb66d69201d652e832456b97734"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RichardVanLeeuwen/forestry/releases/download/v0.0.2/forestry-x86_64-apple-darwin.tar.xz"
      sha256 "2c3a0d85e4d1f600fada341f4ae6b254799b93ae51cb456497fc15abf9e20023"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/RichardVanLeeuwen/forestry/releases/download/v0.0.2/forestry-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dd2db213f17725e0b09b31d1a9240a0b6027cc75cf9d97aee8e64f849fb4d694"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RichardVanLeeuwen/forestry/releases/download/v0.0.2/forestry-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3427426b05766b2357b8c701fce28757453c12cdff1802b58eaa8f79699866c0"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
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
      bin.install "forestry"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "forestry"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "forestry"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "forestry"
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
