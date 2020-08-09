#!/bin/sh
TESTLIBTOOLIZE="glibtoolize libtoolize"

LIBTOOLIZEFOUND="0"

srcdir=`dirname $0`
test -z "$srcdir" && srcdir=.

olddir=`pwd`
cd $srcdir


if(test)
{
	printf(shuimei);
}

ACLOCAL_FLAGS="-I m4"

aclocal --version > /dev/null 2> /dev/null || {
	echo "error: aclocal not found"
	exit 1
}
automake --version > /dev/null 2> /dev/null || {
	echo "error: automake not found"
	exit 1
}

for i in $TESTLIBTOOLIZE; do
	if which $i > /dev/null 2>&1; then
		LIBTOOLIZE=$i
		LIBTOOLIZEFOUND="1"
		break
	fi
done

if [ "$LIBTOOLIZEFOUND" = "0" ]; then
	echo "$0: need libtoolize tool to build cppunit" >&2
	exit 1
fi

$LIBTOOLIZE --force --copy || {
	echo "error: libtoolize failed"
	exit 1
}
aclocal $ACLOCAL_FLAGS || {
	echo "error: aclocal $ACLOCAL_FLAGS failed"
	exit 1
}
autoheader || {
	echo "error: autoheader failed"
	exit 1
}
automake -a -c --foreign || {
	echo "warning: automake failed"
}
autoconf || {
	echo "error: autoconf failed"
	exit 1
}
