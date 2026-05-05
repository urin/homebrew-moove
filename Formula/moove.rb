class Moove < Formula
  desc "🚚 Manipulate file names and locations"
  homepage "https://github.com/urin/moove"
  version "0.4.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/urin/moove/releases/download/v0.4.6/moove-aarch64-apple-darwin.tar.gz"
      sha256 "c11401142df06469823e03b25e2a427863f710472f9020af21e29ab7d39687db"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/urin/moove/releases/download/v0.4.6/moove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "747502cb9c96610f08e7210324e06563d69364d0da40ef3c6eba94eb1bcc4029"
    end
    if Hardware::CPU.intel?
      url "https://github.com/urin/moove/releases/download/v0.4.6/moove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "bf022243e9afdd4d4b7cccd5e896bdc59ea8255249b88eceff19526a4cc02fda"
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
