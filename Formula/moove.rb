class Moove < Formula
  desc "🚚 Manipulate file names and locations"
  homepage "https://github.com/urin/moove"
  version "0.4.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/urin/moove/releases/download/v0.4.4/moove-aarch64-apple-darwin.tar.gz"
      sha256 "2d170ec88a635fff3a502197bdedb846a9badceed9a8a147809265f41b523d48"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/urin/moove/releases/download/v0.4.4/moove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "067523a81b5cbe5c818acc4e57687319a714bf12a495398e26a3a601b9a4306d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/urin/moove/releases/download/v0.4.4/moove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "cb5a8372671354807e3598b5279dd6b4d54e7d890faaa60ec6716711c3780c0d"
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
