#!perl

# Run A140901.main(rows, cols)
# @(#) $Id$
# 2022-07-07, Georg Fischer: copied from partcond.pl
#
#:# Usage:
#:#     perl a140901.pl rows cols
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $java = <<'GFis';
java -Ddebug=0 -Xmx2g -Xss1g -Duser.language=en -Dprog.root=./prog -Doeis.verbose=false -Doeis.priority="java,gp" -Doeis.timeout=4 -cp "../../../joeis-lite/dist/joeis-lite.jar;../../../joeis/build.tmp/joeis.jar" irvine.oeis.a140.A140901
GFis
$java =~ s{\s*\Z}{};
my $bfdata = "../../../OEIS-mat/common/asdata.txt";

my $rows = 7;
my $cols = 3;
if (scalar(@ARGV) >= 2) {
   my $iarg = 0;
   my $rows = $ARGV[$iarg ++];
   my $cols = $ARGV[$iarg ++];
   &search($rows, $cols);
} else {
    while (<DATA>) {
        next if m{\#};
        ($rows, $cols) = split(/\s+/);
        &search($rows, $cols);
    } # while DATA
}
# end of main
#----
sub search {
    my ($cols, $rows) = @_;
    my $cmd = "$java $rows $cols";
    my $terms = `$cmd`;
    $terms =~ m{\n((\-?\d+\, *){8})};
    $terms = $1;
    $terms =~ s{\, *\Z}{};
    $terms =~ s{ }{}g;
    my @lines = split(/\r?\n/, `grep \"$terms\" $bfdata`);
    if (scalar(@lines) > 0) {
        my($aseqno, $termno, $data) = split(/\t/, $lines[0]);
        print join("\t", $aseqno, "parmof3", 0, "A140901", $rows, $cols, "", $terms) . "\n";
    } else {
        print "# not found: $rows,$cols: $terms\n";
    }
} # search
__DATA__
# 2 2 A002415, used
2 3
2 4
2 5
2 6
2 7
2 8
2 9
# 2 10
# 2 11
2 12
# 2 13
# 3 12
# 4 12
# 5 12
# 6 12
# 7 12
# 8 12
# 9 12
# 10 12
# 11 12
12 12
3 3
3 4
4 4
5 5
# 6 6
