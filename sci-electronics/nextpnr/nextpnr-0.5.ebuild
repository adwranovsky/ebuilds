# Copyright 2023 Alex Wranovsky
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{5..11} )
inherit cmake python-any-r1

DESCRIPTION="A vendor neutral, timing driven, FOSS FPGA place and route tool"
HOMEPAGE="https://github.com/YosysHQ/nextpnr"
SRC_URI="https://github.com/YosysHQ/nextpnr/archive/refs/tags/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64"
IUSE="+openmp +analytic-placer gui +ice40"
REQUIRED_USE="
	|| ( ice40 )
"

S="${WORKDIR}/${PN}-${P}"

RDEPEND="
	dev-libs/boost
	gui? ( dev-qt/qtcore dev-qt/qtwidgets dev-qt/qtopengl )
	ice40? ( sci-electronics/icestorm )
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/cmake
	${PYTHON_DEPS}
	analytic-placer? ( dev-cpp/eigen )
	openmp? ( >=sys-devel/gcc-4.2[openmp] )
"

src_configure() {
	# Make a semicolon-separated list of architectures to compile for
	local arches=(
		$(usev ice40)
	)
	arches=$(sed 's/ /;/g' <<<${arches[@]})

	local mycmakeargs=(
		-DARCH="$arches"
		-DBUILD_GUI=$(usex gui ON OFF)
		-DBUILD_HEAP=$(usex analytic-placer ON OFF)
		-DUSE_OPENMP=$(usex openmp ON OFF)
	)
	cmake_src_configure
}
