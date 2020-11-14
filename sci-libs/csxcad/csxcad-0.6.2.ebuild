# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A C++ library to describe geometrical objects and their properties"
HOMEPAGE="http://openems.de/index.php/CSXCAD"
SRC_URI="https://github.com/thliebig/CSXCAD/archive/v0.6.2.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/tinyxml
	dev-libs/boost
	sci-libs/hdf5
	sci-libs/vtk
	sci-mathematics/cgal
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/fparser
"

# The upstream package name uses uppercase, so set the source directory to match
S="${WORKDIR}/${P^^}"

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
