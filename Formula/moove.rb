class Moove < Formula
  desc "🚚 Manipulate file names and locations"
  homepage "https://github.com/urin/moove"
  version "0.4.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/urin/moove/releases/download/v0.4.5/moove-aarch64-apple-darwin.tar.gz"
      sha256 "266361c8f9c6c3e96f2a3272da82556fe1dd3cdde28b6314519de7c15ce96aab"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/urin/moove/releases/download/v0.4.5/moove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "50301ecdce23dc3e02ef15e65a51d11d588a4970992bb6262ecf23a75c7def6d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/urin/moove/releases/download/v0.4.5/moove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "18e8c178289ee344218ccdb9c18933a5d18880e25395a70e801409481d3ea4fb"
    end
  end
  license "MIT/Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

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
      bin.install "moove"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "moove"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "moove"
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
