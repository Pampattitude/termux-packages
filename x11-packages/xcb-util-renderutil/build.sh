TERMUX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"

TERMUX_PKG_HOMEPAGE=https://xcb.freedesktop.org/
TERMUX_PKG_DESCRIPTION="Utility libraries for XC Binding - Convenience functions for the Render extension"
TERMUX_PKG_VERSION=0.3.9
TERMUX_PKG_REVISION=2
TERMUX_PKG_SRCURL=https://xcb.freedesktop.org/dist/xcb-util-renderutil-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=c6e97e48fb1286d6394dddb1c1732f00227c70bd1bedb7d1acabefdd340bea5b
TERMUX_PKG_DEPENDS="libxcb"
TERMUX_PKG_BUILD_DEPENDS="xorg-util-macros"
