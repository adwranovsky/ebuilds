# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A C++ library for parsing and evaluating mathematical functions from a string"
HOMEPAGE="http://warp.povusers.org/FunctionParser/"
SRC_URI="http://warp.povusers.org/FunctionParser/${PN}${PV}.zip -> ${P}.zip"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

HTML_DOCS="docs/fparser.html docs/style.css"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_install() {
	local install_path="/usr/share/${PN}"
	dodir "$install_path"
	cp -r -t "${D}/${install_path}" *.cc *.hh extrasrc mpfr examples || die "Install failed!"
	einstalldocs
}
