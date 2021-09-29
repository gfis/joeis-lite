#!perl

# Distribute the sources in ./manual
# @(#) $Id$
# 2021-09-29, Georg Fischer

use strict;
use integer;
undef $/; # slurp mode

my @names;
my %dirs;
my $tarroot = "../../src/irvine/oeis";
foreach my $name(glob("manual/*.java")) {
    $name =~ m{\/(A\d+)};
    my $aseqno = $1;
    my $tarpath = "$tarroot/" . lc(substr($aseqno, 0, 4));
    if (! defined($dirs{$tarpath}) or ! -d "$tarpath") { # tarpath not yet readable
        $dirs{$tarpath} = 1;
        mkdir($tarpath);
    }
    open(SRC, "<", $name) || die "cannot read $name\n";
    my $buffer = <SRC>;
    close(SRC);
    open(TAR, ">", "$tarpath/$aseqno.java") || die "cannot write $tarpath/$aseqno.java\n";
    print TAR $buffer;
    close(TAR);
    print "$aseqno\n";
    print STDERR "copied manual/$aseqno.java -> $tarpath/$aseqno.java\n";
}
__DATA__
foreach my $name(glob("manual/*.java")) {
    $name =~ m{\/(A\d+)};
    my $aseqno = $1;
    my $tarpath = lc(substr($aseqno, 0, 4));
    if (! defined($dirs{$tarpath})) {
        $dirs{$tarpath} = 1;
        print `mkdir -p $tarroot/$tarpath`;
    }
    print `cp -v manual/$aseqno.java $tarroot/$tarpath`;
}
