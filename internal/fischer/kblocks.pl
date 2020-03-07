#!perl

# Extract parameters for jOEIS
# eulerper.jpat (EulerTransformSequence(new PeriodicSequence(period),0))
# 2020-03-07, Georg Fischer
#
#:# Usage:
#:#   perl eulerper.pl $(COMMON)/cat25.txt > eulerper.gen
#--------------------------------------------------------
use strict;
use integer;
use warnings;

while (<DATA>) {
    my $line = $_;
    if ($line =~ m{\A(A\d+)\s+(\d+)\s+(\S+)\s+(\S+)}) {
        my $aseqno = $1;
        my $count  = $2;
        my $dir    = $3;
        my $op     = $4;
        my $oper   = ($dir x $count) . $op;
        if ($op eq "-") {
           $oper  .= ($dir x $count) . "+";
        }
        print join("\t", $aseqno, "kblocks", 1, $count, $oper, 0) . "\n";
    }
} # while <DATA>
__DATA__
# Cf. A093361, (k=1) A000217, (k=2) this sequence, (k=3) A319014, (k=4) A319205, (k=5) A319206, (k=6) A319207, (k=7) A319208, (k=8) A319209, (k=9) A319211, (k=10) A319212.
# a(n) = 1*2 + 3*4 + 5*6 + 7*8 + 9*10 + 11*12 + 13*14 +   
A228958 2   <   +
A319014 3   <   + 
A319205 4   <   + 
A319206 5   <   + 
A319207 6   <   + 
A319208 7   <   + 
A319209 8   <   + 
A319211 9   <   + 
A319212 10  <   + 
# For similar sequences, see: A001057 (k=1), this sequence (k=2), A319543 (k=3), A319544 (k=4), A319545 (k=5), A319546 (k=6), A319547 (k=7), A319549 (k=8), A319550 (k=9), A319551 (k=10).
# a(n) = 1*2 - 3*4 + 5*6 - 7*8 + 9*10 - 11*12 + 13*14
A319373 2   <   -
A319543 3   <   -
A319544 4   <   -
A319545 5   <   -
A319546 6   <   -
A319547 7   <   -
A319549 8   <   -
A319550 9   <   -
A319551 10  <   -
# For similar sequences, see: A000217 (k=1), this sequence (k=2), A319867 (k=3), A319868 (k=4), A319869 (k=5), A319870 (k=6), A319871 (k=7), A319872 (k=8), A319873 (k=9), A319874 (k=10)
# a(n) = 2*1 + 4*3 + 6*5 + 8*7 + 10*9 + 12*11 +
A319866 2   >   +
A319867 3   >   +
A319868 4   >   +
A319869 5   >   +
A319870 6   >   +
A319871 7   >   +
A319872 8   >   +
A319873 9   >   +
A319874 10  >   +
# For similar sequences, see: A001057 (k=1), this sequence (k=2), A319886 (k=3), A319887 (k=4), A319888 (k=5), A319889 (k=6), A319890 (k=7), A319891 (k=8), A319892 (k=9), A319893 (k=10).
# a(n) = 2*1 - 4*3 + 6*5 - 8*7 + 10*9 - 12*11 + 14*13 - 16*15
A319885 2   >   -
A319886 3   >   -
A319887 4   >   -
A319888 5   >   -
A319889 6   >   -
A319890 7   >   -
A319891 8   >   -
A319892 9   >   -
A319893 10  >   -
