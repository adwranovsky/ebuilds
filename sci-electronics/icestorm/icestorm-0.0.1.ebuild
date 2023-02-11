# Copyright 2023 Alex Wranovsky
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{5..11} )
inherit python-single-r1

# Upstream doesn't version, so just update the package from git from time to time
GIT_HASH="8649e3e0bd0e09429898d2569ef65cc9fd3eafd7"

DESCRIPTION="Tools for analyzing and creating Lattice iCE40 bitstream files"
HOMEPAGE="https://github.com/YosysHQ/icestorm"
SRC_URI="https://github.com/YosysHQ/icestorm/archive/${GIT_HASH}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64"
IUSE=""
REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
"

S="${WORKDIR}/${PN}-${GIT_HASH}"

RDEPEND="
	${PYTHON_DEPS}
"
DEPEND="
	${RDEPEND}
"

src_prepare() {
	sed -i -e 's/-O[$][(]OPT_LEVEL[)]//g' config.mk || die "sed failed!"
	eapply_user
}

src_configure() {
	true
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
