# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{4,5,6,7,8,9} )
inherit eutils python-any-r1

# Be sure to keep this up to date with the Makefile
ABC_HASH="ae6716b064c842f45109a88e84dca71fe4cc311f"

DESCRIPTION="Yosys - Yosys Open SYnthesis Suite"
HOMEPAGE="http://www.clifford.at/icestorm/"
LICENSE="ISC"
SRC_URI="https://github.com/cliffordwolf/${PN}/archive/${P}.tar.gz https://github.com/berkeley-abc/abc/archive/${ABC_HASH}.tar.gz -> berkeley-abc-${ABC_HASH}.tar.gz"

SLOT="0"
KEYWORDS="~amd64"
IUSE="+abc"

RDEPEND="
	sys-libs/readline:=
	virtual/libffi
	dev-vcs/git
	dev-lang/tcl:=
	dev-vcs/mercurial"

DEPEND="
	${PYTHON_DEPS}
	sys-devel/bison
	sys-devel/flex
	sys-apps/gawk
	virtual/pkgconfig
	${RDEPEND}"

S="${WORKDIR}/${PN}-${P}"

src_prepare() {
	ln -s ${WORKDIR}/abc-${ABC_HASH} abc
	sed "s/^ABCREV = .*/ABCREV = default/g" -i Makefile
	default
}

src_configure() {
	emake config-gcc
	echo "ENABLE_ABC := $(usex abc 1 0)" >> "${S}/Makefile.conf"
}

src_compile() {
	emake PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake PREFIX="${ED}/usr" install
}
