#!perl

# Polish sequences to be guessed by an EulerInvTransform
# 2020-08-20, Georg Fischer
#
#:# Usage:
#:#   perl padding_prep.pl input > output
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $debug = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $line = "";
my ($aseqno, $callcode, $offset, @parms); # in the record

while (<>) {
    next if ! m{\AA\d+}; # if not starting with A-number
    s/\s+\Z//; # chompr
    $line = $_;
    if ($debug >= 1) {
        print "line=$line\n";
    }
    ($aseqno, $callcode, $offset, @parms) = split(/\t/, $line);
    my $parm1 = $parms[0];
    if (0) {
    } elsif ($callcode =~ m{pad1mma}) {
        $parm1 =~ m{\A[^\{]*\{([^\}]*)\},\d*\,([^\{]*\{[^\}]*\}|\-?\d+)};
        $parms[0] = $1;
        my $right = $2;
        $right =~ s{[\{\}]}{}g;
        $parms[1] = $right;
        $callcode = "padding";
    }
    if ($callcode eq "padding") {
        print join("\t", $aseqno, $callcode, $offset, @parms) . "\n";
    }
} # while <>
#================================
__DATA__
aseqno	callcode	offset	parm1	b.bfimax - b.bfimin + 1	name
A051161	pad1for	0	=0 for > 20	98	a(n) is the exponent of n-th prime in order (A003131) of Monster simple group.
A065068	pad1for	0	=0 for >= 143	53	Number of fixed polyominoes with n cells of which no four are equally spaced on a straight line.
A057446	pad1mma	0	Right,{},80,{73,19,31,101}	60	To get next term, multiply by 13, add 1 and discard any prime factors < 13.
A118837	pad1mma	0	Right,{1,5,9,13},70,{55,59,99,103,35,57,79,101,15}	67	Start with 1 and repeatedly place the first digit at the end of the number and add 4.
A146099	pad1sam	0	n+39=n	10001	Bell numbers (A000110) read mod 9.
A146102	pad1sam	0	n+156=n	10001	Bell numbers (A000110) read mod 12.
A146103	pad1sam	0	n+25239592216021=n	10001	Bell numbers (A000110) read mod 13.

