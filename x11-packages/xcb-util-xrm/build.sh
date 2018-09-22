TERMUX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"

TERMUX_PKG_HOMEPAGE=https://github.com/Airblader/xcb-util-xrm/
TERMUX_PKG_DESCRIPTION="XCB utility functions for the X resource manager"
TERMUX_PKG_VERSION=1.3
TERMUX_PKG_REVISION=2
TERMUX_PKG_SRCURL=https://github.com/Airblader/xcb-util-xrm/releases/download/v${TERMUX_PKG_VERSION}/xcb-util-xrm-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=0129f74c327ae65e2f4ad4002f300b4f02c9aff78c00997f1f1c5a430f922f34
TERMUX_PKG_DEPENDS="libx11, xcb-util"
TERMUX_PKG_BUILD_DEPENDS="xorg-util-macros"
