#!perl
# Evaluate the output of make kpytha_diff
# 2020-10-20, Georg Fischer
#
#:# Usage:
#:#   perl kpytha_diff.pl input > output
#----------------
use strict;
use integer;
use warnings;

my $debug  = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt =     shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug  = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

if (0) {
#----------------
} else {
    my $state = 0;
    my $prev = "";
    while (<>) {
        my $line = $_;
        if (0) {
        } elsif ($line =~ m{\A\#\-}) {
        	$state = 0;
        	print "\n";
        } elsif ($line =~ m{\A\# [^O]}) {
            print $line;
            $state = 0;
        } elsif ($state == 0 && ($line !~ m{\A\#}) && ($line =~ m{\|})) {
            print $prev;
            print $line;
            $state = 1;
        } else {
            $prev = $line;
        }
    } # while <>
}
__DATA__
  58:      15     280     335  |    58:      15     132     183
#----------------------------     #----------------------------
# OEIS/MMA (Clark Kimberling)  |  # jOEIS/Java (Georg Fischer)
# non-primitive 9-Pythagorean     # non-primitive 9-Pythagorean
#     A196183 A196184 A196185     #     A196183 A196184 A196185
   1:       1      15      19        1:       1      15      19
   2:       2      30      38        2:       2      30      38
   3:       3       5      13        3:       3       5      13
   4:       3       8      17        4:       3       8      17
   5:       3      13      23        5:       3      13      23
   6:       3      45      57        6:       3      45      57
   7:       3     160     173        7:       3     160     173
   8:       4      60      76        8:       4      60      76
   9:       5      24      41        9:       5      24      41
  10:       5      48      67       10:       5      48      67
  11:       5      75      95       11:       5      75      95
  12:       5     459     481       12:       5     459     481
  13:       6      10      26       13:       6      10      26
  14:       6      16      34       14:       6      16      34
  15:       6      26      46       15:       6      26      46
  16:       6      90     114       16:       6      90     114
  17:       6     320     346       17:       6     320     346
  18:       7      57      83       18:       7      57      83
  19:       7     105     133       19:       7     105     133
  20:       8      15      37  |    20:       7     912     943
  21:       8      45      73  |    21:       8      15      37