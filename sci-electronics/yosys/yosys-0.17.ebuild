# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{4,5,6,7,8,9,10} )
inherit eutils python-any-r1

# Update this every time the version is bumped
ABC_HASH="09a7e6dac739133a927ae7064d319068ab927f90"

DESCRIPTION="Yosys - Yosys Open SYnthesis Suite"
HOMEPAGE="https://yosyshq.net/yosys/"
LICENSE="ISC"
SRC_URI="
	https://github.com/YosysHQ/${PN}/archive/${P}.tar.gz
	https://github.com/YosysHQ/abc/archive/${ABC_HASH}.zip
"

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
