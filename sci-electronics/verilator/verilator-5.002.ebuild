# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11} )

inherit autotools python-r1

DESCRIPTION="The fast free Verilog/SystemVerilog simulator"
HOMEPAGE="https://www.veripool.org/wiki/verilator"

SRC_URI="https://github.com/verilator/verilator/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

IUSE="ccache"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

LICENSE="|| ( Artistic-2 LGPL-3 )"
SLOT="0"

# ccache, google-perftools, and numactl aren't strictly required, but the docs
# recommend them for the best performance
DEPEND="
	${PYTHON_DEPS}
	sys-devel/make
	dev-lang/perl
	sys-libs/zlib

	sys-process/numactl
	dev-util/google-perftools
	ccache? ( dev-util/ccache )
"

RDEPEND="
	${DEPEND}
"

# git is required to add version information into the build
BDEPEND="
	sys-devel/bison
	sys-devel/flex
	sys-devel/autoconf
	dev-vcs/git
"

src_prepare() {
	default

	# Only build with ccache if requested by the user
	if ! use ccache; then
		sed -i 's|AC_CHECK_PROG(OBJCACHE,ccache,ccache)|AC_SUBST(OBJCACHE)|g' configure.ac || die
	fi

	eautoconf --force
}
