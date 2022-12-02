# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

PYTHON_COMPAT=( python3_{4,5,6,7,8,9,10,11} )
inherit python-any-r1

DESCRIPTION="Yosys - Yosys Open SYnthesis Suite"
HOMEPAGE="https://yosyshq.net/yosys/"
LICENSE="ISC"
SRC_URI="
	https://github.com/YosysHQ/yosys/archive/refs/tags/${P}.tar.gz
	abc? ( https://github.com/YosysHQ/yosys/releases/download/${P}/abc.tar.gz )
"

SLOT="0"
KEYWORDS="~amd64"
IUSE="+readline +abc"

RDEPEND="
	readline? ( sys-libs/readline:= )
	dev-libs/libffi
	dev-vcs/git
	dev-lang/tcl:=
"

DEPEND="
	${PYTHON_DEPS}
	sys-devel/bison
	sys-devel/flex
	sys-apps/gawk
	virtual/pkgconfig
	${RDEPEND}
"

S="${WORKDIR}/${PN}-${P}"

src_prepare() {
	# Point to the ABC source if using ABC
	if use abc; then
		local abc_dir="${WORKDIR}/$(tar -zf "${DISTDIR}/abc.tar.gz" --list | head -n 1 || die)"
		ln -s "$abc_dir" abc
	fi
	sed "s/^ABCREV = .*/ABCREV = default/g" -i Makefile || die

	# Don't strip output files
	sed 's|.*$(STRIP).*||g' -i Makefile || die

	# Remove clang config line to avoid QA notices
	sed -E 's|^(CONFIG := clang)$|# \1|g' -i Makefile || die
	sed -E 's|^# *(CONFIG := gcc)$|\1|g' -i Makefile || die

	default
}

src_configure() {
	emake config-gcc
	echo "ENABLE_ABC := $(usex abc 1 0)" >> "${S}/Makefile.conf"
	echo "ENABLE_READLINE := $(usex readline 1 0)" >> "${S}/Makefile.conf"
}

src_compile() {
	emake PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake PREFIX="${ED}/usr" install
}
