# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib toolchain-funcs

DESCRIPTION="A modular PCB layout editor"
HOMEPAGE="http://repo.hu/projects/pcb-rnd/"
SRC_URI="http://repo.hu/projects/pcb-rnd/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# TODO: Figure out how to get their version of autotools to find fungw, then add it to the dependencies
DEPEND="x11-libs/motif"
RDEPEND="${DEPEND}"
BDEPEND=""

# Do a dumb configuration that enables all working plugins
src_configure() {
	./configure \
		--all=plugin \
		--prefix="${EPREFIX}/usr" \
		--man1dir="${EPREFIX}/share/man" \
		--libarchdir="$(get_libdir)" \
		--confdir="${EPREFIX}/etc" \
		--CC="$(tc-getCC)" \
		--CFLAGS="${CFLAGS}" \
		--LDFLAGS="${LDFLAGS}" \
		$([[ -n $CTARGET ]] && echo -n "--target=${CTARGET}") \
	|| die

	# Install docs to a better location. This could probably done more cleanly
	# if I understood better how their autotools replacement worked.
	sed -i -e "s:DOCDIR=\\(.*\\)$:DOCDIR=\1-${PV}:g" ./Makefile.conf
}

src_install() {
	dodir "/usr/share/doc/${P}"
	emake DESTDIR="${D}" install
}
