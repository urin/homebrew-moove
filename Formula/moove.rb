class Moove < Formula
  desc "🚚 Manipulate file names and locations"
  homepage "https://github.com/urin/moove"
  version "0.4.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/urin/moove/releases/download/v0.4.5/moove-aarch64-apple-darwin.tar.gz"
      sha256 "3a3a9f9345f423c5c5d103e157e3da24ea877a47cff47d48b66d40cddd5d52fc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/urin/moove/releases/download/v0.4.5/moove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "be15c2759221817cf718040cb6c158ceebac6e14745dd6f7136095e7e1e78afe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/urin/moove/releases/download/v0.4.5/moove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "209d363d66dbf5ffb5fb2c2703a5998994bac830af536c3e125c5ae9aa3f5642"
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
