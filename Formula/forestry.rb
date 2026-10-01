class Forestry < Formula
  desc "The forestry application"
  homepage "https://github.com/RichardVanLeeuwen/forestry"
  version "0.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/RichardVanLeeuwen/forestry/releases/download/v0.0.1/forestry-aarch64-apple-darwin.tar.xz"
      sha256 "c73eadbd6c8eb93565faa6b18ac1c82c9a2e7d5a9db83a1ea7119e95356b4c0d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RichardVanLeeuwen/forestry/releases/download/v0.0.1/forestry-x86_64-apple-darwin.tar.xz"
      sha256 "42c45194376078f61573dcd04add7e55a7c19d94bf0681f72765a56636985cac"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/RichardVanLeeuwen/forestry/releases/download/v0.0.1/forestry-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b361033f447216f5e240671276c41bd3a5a1c31de9088041057365ccc781ea64"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RichardVanLeeuwen/forestry/releases/download/v0.0.1/forestry-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7b8f796c636b13be5a6dd0b51e82a7604e4fa9f789c69e2ba31ccbbe572994f5"
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
