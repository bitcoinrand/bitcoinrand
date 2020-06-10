#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

BITCOINRANDD=${BITCOINRANDD:-$BINDIR/bitcoinrandd}
BITCOINRANDCLI=${BITCOINRANDCLI:-$BINDIR/bitcoinrand-cli}
BITCOINRANDTX=${BITCOINRANDTX:-$BINDIR/bitcoinrand-tx}
BITCOINRANDQT=${BITCOINRANDQT:-$BINDIR/qt/bitcoinrand-qt}

[ ! -x $BITCOINRANDD ] && echo "$BITCOINRANDD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
BZARVER=($($BITCOINRANDCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for bitcoinrandd if --version-string is not set,
# but has different outcomes for bitcoinrand-qt and bitcoinrand-cli.
echo "[COPYRIGHT]" > footer.h2m
$BITCOINRANDD --version | sed -n '1!p' >> footer.h2m

for cmd in $BITCOINRANDD $BITCOINRANDCLI $BITCOINRANDTX $BITCOINRANDQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${BZARVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${BZARVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
