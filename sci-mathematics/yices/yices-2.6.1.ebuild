# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Yices 2 is an SMT solver that decides the satisfiability of
formulas containing uninterpreted function symbols with equality, real and
integer arithmetic, bitvectors, scalar types, and tuples."
HOMEPAGE="https://yices.csl.sri.com/"
SRC_URI="https://yices.csl.sri.com/releases/${PV}/${PF}-src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-util/gperf"
RDEPEND="
	dev-libs/gmp
	${DEPEND}"
