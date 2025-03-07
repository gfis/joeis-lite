#!perl

# Extract parameters for of the form a(n) = Qseqno(n) oper Rseqno(n)
# @(#) $Id$
# 2022-12-08, Georg Fischer: copied from dersimple.pl
#
#:# Usage:
#:#     grep -Pi "a\(n\) *\= *A\d+\([^\)]+\) *([\+\-\*\/\^]|and|or|xor|xand|mod) *A\d+\([^\)]+\) *\." $(COMMON)/jcat25.txt \
#:#     | grep -E "^\%" \
#:#     | cut -b 4- | sed -e "s/ /\t/" \
#:#     | perl anopan.pl [-d debug] [-f ofter_file] > $@.tmp 2> $@.rest.tmp
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#:#     -f  file with aseqno, offset1, terms (default $(COMMON)/joeis_ofter.txt)
#:# Reads ofter_file for implemented jOEIS sequences with their offsets and first terms
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $debug = 0;
if (0 and scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $COMMON = "../../../OEIS-mat/common";
#----------------
my $aseqno;
my $offset = 1;
my $terms;
my $line;
my $name;
while (<>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    if (0) {
    } elsif ($line =~ m{\-a (A\d{6})}) {
        $aseqno = $1;
    #                    12      23        3 1
    } elsif ($line =~ m{^((\-?\d+)(\,\-?\d+)*)}) {
        $terms = $1;
        print "# $aseqno: $terms\n";
        my @block = map { 
            m{^(A\d{6})}; $1
            } split(/\n/, `grep \"$terms\" $COMMON/stripped`);
        foreach my $rseqno (@block) {
            print join("\t", $aseqno, $rseqno) . "\n";
        }
    }
} # while <>
#----------------
__DATA__
java -Ddebug=0 -Xmx2800m -Xss800m -Duser.language=en -Dprog.root=./prog -Doeis.verbose=false -Doeis.
is.jar" irvine.oeis.triangle.RowIndexSequence -d 0 -n 12 -o 1 -a A191442
1,1,1,2,1,3,2,4,1,3,5,2
make[1]: Leaving directory '/cygdrive/c/Users/User/work/gits/joeis-lite/internal/fischer'
make[1]: Entering directory '/cygdrive/c/Users/User/work/gits/joeis-lite/internal/fischer'
java -Ddebug=0 -Xmx2800m -Xss800m -Duser.language=en -Dprog.root=./prog -Doeis.verbose=false -Doeis.
is.jar" irvine.oeis.triangle.RowIndexSequence -d 0 -n 12 -o 1 -a A191443
1,1,2,1,3,2,1,4,3,5,2,6
make[1]: Leaving directory '/cygdrive/c/Users/User/work/gits/joeis-lite/internal/fischer'
make[1]: Entering directory '/cygdrive/c/Users/User/work/gits/joeis-lite/internal/fischer'
java -Ddebug=0 -Xmx2800m -Xss800m -Duser.language=en -Dprog.root=./prog -Doeis.verbose=false -Doeis.
is.jar" irvine.oeis.triangle.RowIndexSequence -d 0 -n 12 -o 1 -a A191444
1,2,1,2,3,1,4,2,5,3,1,6
make[1]: Leaving directory '/cygdrive/c/Users/User/work/gits/joeis-lite/internal/fischer'
make[1]: Entering directory '/cygdrive/c/Users/User/work/gits/joeis-lite/internal/fischer'
java -Ddebug=0 -Xmx2800m -Xss800m -Duser.language=en -Dprog.root=./prog -Doeis.verbose=false -Doeis.
is.jar" irvine.oeis.triangle.RowIndexSequence -d 0 -n 12 -o 1 -a A191445
1,2,1,3,2,1,4,3,5,2,6,1
make[1]: Leaving directory '/cygdrive/c/Users/User/work/gits/joeis-lite/internal/fischer'