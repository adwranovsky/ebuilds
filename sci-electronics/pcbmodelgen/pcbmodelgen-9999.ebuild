# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Convert KiCAD PCB files to models for import in openEMS"
HOMEPAGE="https://github.com/jcyrax/pcbmodelgen"
if [[ ${PV} == 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jcyrax/pcbmodelgen.git"
else
	SRC_URI="https://github.com/jcyrax/pcbmodelgen/archive/v${PV}.tar.gz"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-libs/tinyxml2
	dev-cpp/tclap
"
RDEPEND="${DEPEND}"
BDEPEND=""
