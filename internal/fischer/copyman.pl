#!perl

# Distribute the sources in ./manual
# @(#) $Id$
# 2021-09-29, Georg Fischer

use strict;
use integer;

undef $/; # slurp mode
my %dirs;
my $tarroot = "../../src/irvine/oeis";
my $count = 0;
foreach my $name(glob("manual/*.java")) {
    $name =~ m{\/(A\d+)};
    my $aseqno  = $1;
    my $tarpack = lc(substr($aseqno, 0, 4));
    my $tarpath = "$tarroot/$tarpack";
    if (! defined($dirs{$tarpath}) or ! -d "$tarpath") { # tarpath not yet readable
        $dirs{$tarpath} = 1;
        mkdir($tarpath);
    }
    open(SRC, "<", $name) || die "cannot read $name\n";
    my $buffer = <SRC>;
    $buffer =~ m{\Apackage irvine.oeis.(a\d+)};
    my $srcpack = $1 || "undef";
    close(SRC);
    open(TAR, ">", "$tarpath/$aseqno.java") || die "cannot write $tarpath/$aseqno.java\n";
    print TAR $buffer;
    close(TAR);
    print "$aseqno\n";
    print STDERR "copied manual/$aseqno.java -> $tarpath/$aseqno.java" . (($srcpack ne $tarpack) ? " ** wrong source package $srcpack **" : "") . "\n";
    $count ++;
} # foreach
print STDERR "# $count files distributed\n";
__DATA__
