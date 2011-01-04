#!/bin/sh
#
# (c) 2004-2011 Denora Team
# Contact us at info@denorastats.org
#
# Please read COPYING and README for further details.
#
# Based on the original code of Anope by Anope Team.
# Based on the original code of Thales by Lucas.
#
# $Id$
#

# Grab version information from the version control file.
CTRL="../version.in"
if [ -f $CTRL ] ; then
	. $CTRL
else
	echo "Error: Unable to find control file: $CTRL"
	exit 0
fi

VERSION="${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}.${VERSION_BUILD}"
if [ ${VERSION_EXTRA} ] ; then
	VERSION="${VERSION} (${VERSION_EXTRA})"
fi
VERSIONDOTTED="${VERSION}"

if [ -f version.h ] ; then
	BUILD=`fgrep '#define BUILD' version.h | sed 's/^#define BUILD.*\([0-9]*\).*$/\1/'`
	BUILD=`expr $BUILD + 1 2>/dev/null`
else
	BUILD=1
fi
if [ ! "$BUILD" ] ; then
	BUILD=1
fi
cat >version.h <<EOF
/* Version information for Stats.
 *
 * (c) 2004-2011 Denora Team
 * Contact us at info@denorastats.org
 *
 * Please read COPYING and CREDITS for furhter details.
 *
 * Based on the original code of Anope by Anope Dev.
 * Based on the original code of Thales by Lucas.
 * 
 * This file is auto-generated by version.sh
 *
 * $Id$
 *
 */

#ifndef VERSION_H
#define VERSION_H
 
#define VERSION_MAJOR	$VERSION_MAJOR
#define VERSION_MINOR	$VERSION_MINOR
#define VERSION_PATCH	$VERSION_PATCH
#define VERSION_EXTRA	$VERSION_EXTRA
#define VERSION_BUILD	$VERSION_BUILD

#define BUILD	"$BUILD"
#define VERSION_STRING "$VERSION"
#define VERSION_STRING_DOTTED "$VERSIONDOTTED"

#if defined(USE_MYSQL)
# define VER_SQL "Q"
#else
# define VER_SQL ""
#endif

#if defined(USE_MODULES)
# define VER_MODULE "M"
#else
# define VER_MODULE ""
#endif

#endif

EOF

