class Vifm < Formula
  desc "Ncurses based file manager with vi like keybindings"
  homepage "https://vifm.info/"
  url "https://github.com/vifm/vifm/releases/download/v0.11/vifm-osx-0.11.tar.bz2"
  sha256 "d6f829ed0228a8f534d63479fc988c2b4b95e6bc49d5db5e4fabff337fba3c4c"

  bottle do
    sha256 "0495acdf812f89f23c7fafcccef47589249477c5c38dd0e47049c3421edc712a" => :mojave
    sha256 "8371dea589590796e0f1c6b7b5ce263e18b9a1619551d5967deefd5035e512e0" => :high_sierra
    sha256 "ded145b46f48c79712b12e7f8d14ab8b219778fcd6d0b436d0c156dd0b15129d" => :sierra
  end

  uses_from_macos "groff" => :build
  uses_from_macos "ncurses"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--without-gtk",
                          "--without-libmagic",
                          "--without-X11"
    system "make"
    system "make", "check"

    ENV.deparallelize { system "make", "install" }
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/vifm --version")
  end
end
