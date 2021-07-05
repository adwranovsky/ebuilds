# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Qt-GUI for CSXCAD"
HOMEPAGE="http://openems.de"

GIT_HASH="0dabbaf2bc1190adec300871cf309791af842c8e" # Remove this line if not using git

if [[ -n ${GIT_HASH:-} ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/thliebig/QCSXCAD.git"
	EGIT_COMMIT="$GIT_HASH"
else
	SRC_URI="https://github.com/thliebig/QCSXCAD/archive/v${PV}.tar.gz"

	# The upstream package name uses uppercase, so set the source directory to match
	S="${WORKDIR}/${P^^}"
fi

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=dev-qt/qtwidgets-5.15.1
	>=dev-qt/qtxml-5.15.1
	<sci-libs/vtk-9.0.1[qt5,rendering]
	sci-libs/csxcad
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DCSXCAD_ROOT_DIR="${EPREFIX}/usr"
	)
	cmake_src_configure
}
