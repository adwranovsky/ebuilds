# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=JONALLEN
DIST_VERSION=0.42
inherit perl-module

DESCRIPTION="Converts Pod to PDF format"

LICENSE="|| ( GPL-2+ Artistic )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-perl/PDF-API2
	virtual/perl-Pod-Escapes
	dev-perl/Getopt-ArgvFile
"
BDEPEND=""
