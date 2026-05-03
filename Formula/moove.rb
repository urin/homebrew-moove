class Moove < Formula
  desc "🚚 Manipulate file names and locations"
  homepage "https://github.com/urin/moove"
  version "0.4.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/urin/moove/releases/download/v0.4.4/moove-aarch64-apple-darwin.tar.gz"
      sha256 "446b9c6dc3d33e85fc31acbf5089b16b3792a62dea1a05a2dc515e301f3eab29"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/urin/moove/releases/download/v0.4.4/moove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "af7a48ac35873f79940d64d48e85ff410859356b49726ea5dcc26e48d8c33d44"
    end
    if Hardware::CPU.intel?
      url "https://github.com/urin/moove/releases/download/v0.4.4/moove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b793be5536c745e198f3d8df106a5ec09f1b3558c2ff0771f3e841d6b9b7e87f"
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
