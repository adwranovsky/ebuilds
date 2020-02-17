# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A front-end driver program for Yosys-based formal hardware verification flows."
HOMEPAGE="https://symbiyosys.readthedocs.io/en/latest/index.html"
if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/YosysHQ/SymbiYosys.git"
else
	die "Only git HEAD installs (9999 ebuild version) work at the moment."
fi

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="
	sci-mathematics/z3
	sci-mathematics/yices
	sci-electronics/yosys
	${DEPEND}"
BDEPEND=""

src_install() {
	emake PREFIX="${ED}/usr" install
}
