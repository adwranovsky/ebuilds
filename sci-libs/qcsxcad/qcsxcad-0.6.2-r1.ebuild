# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Qt-GUI for CSXCAD"
HOMEPAGE="http://openems.de"
SRC_URI="https://github.com/thliebig/QCSXCAD/archive/v${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=dev-qt/qtwidgets-5.15.1
	>=dev-qt/qtxml-5.15.1
	<sci-libs/vtk-9.0.1[qt5,rendering]
	sci-libs/csxcad
"
RDEPEND="${DEPEND}"
BDEPEND=""

# The upstream package name uses uppercase, so set the source directory to match
S="${WORKDIR}/${P^^}"

src_configure() {
	local mycmakeargs=(
		-DCSXCAD_ROOT_DIR="${EPREFIX}/usr"
	)
	cmake_src_configure
}
