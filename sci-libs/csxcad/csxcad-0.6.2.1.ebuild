# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A C++ library to describe geometrical objects and their properties"
HOMEPAGE="http://openems.de/index.php/CSXCAD"

GIT_HASH="dc1c25fe5eeaffba7c784083da608cf19e93e5b2" # Remove this line if not using git

if [[ -n ${GIT_HASH:-} ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/thliebig/CSXCAD.git"
	EGIT_COMMIT="$GIT_HASH"
else
	SRC_URI="https://github.com/thliebig/CSXCAD/archive/v${PV}tar.gz -> ${P}.tar.gz"

	# The upstream package name uses uppercase, so set the source directory to match
	S="${WORKDIR}/${P^^}"
fi

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

PATCHES=(
	# Upstream uses a fork of fparser with a cmake build system, so we patch
	# the library so that we can use vanilla fparser
	"${FILESDIR}/${P}-cmakeless_fparser.patch"
)

src_configure() {
	local mycmakeargs=(
		-DFPARSER_ROOT_DIR="${EPREFIX}/usr/share/fparser"
	)
	cmake_src_configure
}
