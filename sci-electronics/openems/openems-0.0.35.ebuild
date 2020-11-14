# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A free and open electromagnetic field solver"
HOMEPAGE="http://openems.de"
SRC_URI="https://github.com/thliebig/openEMS/archive/v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	sci-libs/csxcad
	dev-libs/tinyxml
	sci-libs/hdf5
	sci-libs/vtk
	dev-libs/boost
	sci-mathematics/cgal
	sys-libs/zlib
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/fparser
"

# The upstream package name uses mixed case, so set the source directory to match
S="${WORKDIR}/openEMS-${PV}"

PATCHES=(
	# Upstream uses a fork of fparser with a cmake build system, so we patch
	# the library so that we can use vanilla fparser
	"${FILESDIR}/${P}-cmakeless_fparser.patch"
)

src_configure() {
	local mycmakeargs=(
		-DFPARSER_ROOT_DIR="/usr/share/fparser"
	)
	cmake_src_configure
}