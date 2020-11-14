# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Minimal application using the QCSXCAD library"
HOMEPAGE=""
SRC_URI="https://github.com/thliebig/AppCSXCAD/archive/v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sci-libs/qcsxcad"
RDEPEND="${DEPEND}"
BDEPEND=""

# The upstream package name uses mixed case, so set the source directory to match
S="${WORKDIR}/AppCSXCAD-${PV}"

src_configure() {
	local mycmakeargs=(
		-DCSXCAD_ROOT_DIR="${EPREFIX}/usr"
		-DQCSXCAD_ROOT_DIR="${EPREFIX}/usr"
	)
	cmake_src_configure
}
