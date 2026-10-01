# homebrew-core's mosh formula, built from marcelmiro/mosh's cursor-style branch:
# upstream master (OSC 8 hyperlinks, unreleased since 1.4.0) plus DECSCUSR
# cursor-shape support (upstream issue #352 / PR #1355, unmerged). The VM's
# mosh-server must be built from the same branch, or the cursor shape is lost.
class Mosh < Formula
  desc "Remote terminal application, with cursor-shape support"
  homepage "https://github.com/marcelmiro/mosh/tree/cursor-style"
  license "GPL-3.0-or-later"
  head "https://github.com/marcelmiro/mosh.git", branch: "cursor-style"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkgconf" => :build
  depends_on "protobuf"

  uses_from_macos "ncurses"

  on_macos do
    depends_on "tmux" => :build # for `make check`
  end

  on_linux do
    depends_on "openssl@4" # Uses CommonCrypto on macOS
    depends_on "zlib-ng-compat"
  end

  deny_network_access!

  def install
    # https://github.com/protocolbuffers/protobuf/issues/9947
    ENV.append_to_cflags "-DNDEBUG"
    # Avoid over-linkage to `abseil`.
    ENV.append "LDFLAGS", "-Wl,-dead_strip_dylibs" if OS.mac?

    # teach mosh to locate mosh-client without referring
    # PATH to support launching outside shell e.g. via launcher
    inreplace "scripts/mosh.pl", "'mosh-client", "'#{bin}/mosh-client"

    inreplace "Makefile.am", "--dirty", "--dirty=-Homebrew"
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}", "--enable-completion", "--disable-silent-rules"
    system "make", "install"
  end

  test do
    system bin/"mosh-client", "-c"
    # The cursor-shape emitter's format string; stock mosh has none.
    assert_includes (bin/"mosh-client").binread, "\e[%d q"
  end
end
