# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8,9} )
inherit python-single-r1

DESCRIPTION="A package for performing electromagnetics simulation via the FDTD method"
HOMEPAGE="https://github.com/NanoComp/meep"
SRC_URI="https://github.com/NanoComp/meep/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+scripting mpi openmp" # TODO: resolve mpi/openmp issues -- paraview requires hdf5 without MPI support
REQUIRED_USE="scripting? ( ${PYTHON_REQUIRED_USE} )"


DEPEND="
	mpi? ( sys-cluster/openmpi )
	sci-libs/hdf5[mpi?]
	scripting? ( sci-libs/libctl ${PYTHON_DEPS} )
	sci-libs/mpb[-mpi]
"
RDEPEND="
	${DEPEND}"
BDEPEND=""

pkg_setup() {
	use scripting && python-single-r1_pkg_setup
}

src_configure() {
	local myeconfargs=(
		$(use_with scripting libctl)
		$(use_with openmp)
		$(use_with mpi)
	)
	econf "${myeconfargs[@]}"
}
