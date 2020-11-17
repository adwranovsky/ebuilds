# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A utility to convert HyperLynx and QucsStudio PCB files to Matlab or PDF"
HOMEPAGE="https://github.com/koendv/hyp2mat"
SRC_URI="https://github.com/koendv/hyp2mat/archive/v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	media-libs/libharu
	media-libs/libpng
	sys-libs/zlib
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/gengetopt
"

src_configure() {
	sh ./bootstrap.sh
	default_src_configure
}
