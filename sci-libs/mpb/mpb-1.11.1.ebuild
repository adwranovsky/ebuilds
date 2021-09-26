# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A package for computing the properties of periodic electromagnetic structures"
HOMEPAGE="https://github.com/NanoComp/libctl"
SRC_URI="https://github.com/NanoComp/mpb/releases/download/v${PV}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="+scripting mpi doc examples"

DEPEND="
	mpi? ( sys-cluster/openmpi )
	scripting? ( sci-libs/libctl )
	sci-libs/hdf5[mpi?]
	sci-libs/fftw[mpi?]
	sys-libs/readline
	virtual/blas
	virtual/lapack
	"
RDEPEND="${DEPEND}"

src_configure() {
	# Compiled as a shared library by default
	local myeconfargs=(
		--enable-shared
		$(use_with mpi)
	)
	econf "${myeconfargs[@]}"
}
