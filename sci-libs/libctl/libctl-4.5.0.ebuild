# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Guile-based library for scientific simulations"
HOMEPAGE="https://github.com/NanoComp/libctl"
SRC_URI="https://github.com/NanoComp/libctl/releases/download/v${PV}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND="
	dev-scheme/guile"
RDEPEND="${DEPEND}"

src_configure() {
	# Compiled as a shared library by default
	local myeconfargs=(
		--enable-shared
	)
	econf "${myeconfargs[@]}"
}
