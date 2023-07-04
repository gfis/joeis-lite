#!perl

# Move *.java (from the clipboard) to *.jav
# @(#) $Id$
# 2023-07-04, Georg Fischer
#
#:# Usage:
#:#   perl clipjav.pl
#---------------------------------
use strict;
use integer;
use warnings;

my  $home = "../..";
my  $clip = `powershell -command Get-Clipboard`;
my  @files = map {
        s/^\W+//; s/\s+//;
        $_
    } split(/\r?\n/, $clip);
foreach my $file (@files) {
    my $jav = substr($file, 0, length($file) - 1);
#   print `echo mv -v $home/$file $home/$jav`;
    print `     mv -v $home/$file $home/$jav`;
}
__DATA__
# src/irvine/oeis/triangle/RationalTriangle.java
# src/irvine/oeis/transform/InverseBinomialTransformSequence.java
# src/irvine/oeis/transform/WittTransformSequence.java
# src/irvine/oeis/ExponentialConvolutionSequence.java
# src/irvine/oeis/OrdersFiniteGroupSequence.java
# src/irvine/oeis/GramMatrixRepresentatives.java
# src/irvine/oeis/cons/ContinuedFractionNumeratorSequence.java
# src/irvine/oeis/cons/ContinuedFractionDenominatorSequence.java
# src/irvine/oeis/ZeroSpacedSequence.java
# src/irvine/oeis/NaiveHunterSequence.java
