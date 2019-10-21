# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit versionator

DESCRIPTION="Three dimensional capacitance extraction program, Whiteley Research version"
HOMEPAGE="http://www.wrcad.com/freestuff.html"
SRC_URI="http://www.wrcad.com/ftp/pub/fastcap-2.0wr-011517.tar.gz"

LICENSE="all-rights-reserved"
RESTRICT="mirror bindist"

SLOT="0"
KEYWORDS="amd64"

DEPEND=""
RDEPEND=""

S=${WORKDIR}/fastcap-2.0wr

src_compile() {
	emake all
}

src_install() {
	dobin bin/busgen
	dobin bin/capgen
	dobin bin/cubegen
	dobin bin/fastcap
	dobin bin/pipedgen
	dobin bin/pyragen
	dodoc -r doc/*
	dodoc -r examples
}
