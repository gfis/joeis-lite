#!perl

# Polish sequences to be guessed by an EulerInvTransform
# 2020-08-20, Georg Fischer
#
#:# Usage:
#:#   perl padding_prep.pl [-d mode] [-l limit] input > output
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $debug = 0;
my $limit = 64;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{l}) {
        $limit     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $line = "";
my $aseqno;
my $callcode;
my $offset;
my ($parm1, $parm2);
my ($left, $right, $lilen, $rilen);
my ($bfno, $termlist, @rest); # in the record
my @terms;

while (<>) {
    next if ! m{\AA\d+}; # if not starting with A-number
    s/\s+\Z//; # chompr
    $line = $_;
    if ($debug >= 1) {
        print "line=$line\n";
    }
    ($aseqno, $callcode, $offset, $parm1, $bfno, $termlist, @rest) = split(/\t/, $line);
    if (0) {
    #--------
    } elsif ($callcode =~ m{pad1for}) {
        # A065068   pad1for 0   =0 for >= 143   53  Number of fixed polyominoes 
        if ($parm1 =~ m{\A *\= *(\-?\d+) *for *(\>\=?) *(\-?\d+)}) {
            $right = $1;
            my $op = $2;
            $lilen = $3;
            $callcode = "padding";
            if ($op =~ m{\=}) {
                $lilen --; # now only ">"
            }
            # we need the true offset1 and the terms here!
            &get_terms($offset);
            $right .= (length($right) < 11) ? "" : "L";
        }
    #--------
    } elsif ($callcode =~ m{pad1mma}) {
        # A118837   pad1mma 0   Right,{1,5,9,13},70,{55,59,99,103,35,57,79,101,15}  67  Start with 1 and repeatedly
        if ($parm1 =~ m{\A[^\{]*\{([^\}]*)\},\d*\,([^\{]*\{[^\}]*\}|\-?\d+)}) {
            $left  = $1;
            $right = $2;
            $callcode = "padding";
            $right =~ s{[\{\}]}{}g;
        }
    #--------
    } elsif ($callcode =~ m{pad1par}) {
        # A001148 pad1par 0       1,3,9,7
        if ($parm1 =~ m{\A([\d\-\,]+)}) {
            $left  = "";
            $right = $1;
            $callcode = "padding";
            @terms = split(/\,/, $right);
            my $term1 = shift(@terms);
            $right = join(",", @terms, $term1);
        }
    #--------
    } elsif ($callcode =~ m{pad1sam}) {
        # A146099   pad1sam 0   n+39=n  10001   Bell numbers (A000110) read mod 9.
        if ($parm1 =~ m{\A *n *\+ *(\d+) *\= *n *\Z}) {
            $lilen = $1;
            $callcode = "padding";
            # we need the terms here!
            &get_terms(1); # do not manipulate $lilen
            $right = $left;
            $left  = "";
        }
    #--------
    }
    if ($callcode eq "padding") {
        print join("\t", $aseqno, $callcode, $offset, $left, $right, $lilen, $parm1, substr($termlist, 0, 64)) . "\n";
    }
} # while <>
#----
sub get_terms { # split them from the list, and adjust them corresponding to the offset1
    my ($ofs) = @_;
    @terms = map { # 10123457689
        (length($_) < 11) ? $_ : $_ . "L" # make it long
        } split(/\, */, $termlist);
    if ($ofs < 0) {
        print STDERR "# $aseqno padding_prep.pl cannot handle negative offset $ofs\n";
        $callcode = "negofs";
    } 
    while ($ofs > 1) {
        $lilen --;
        $ofs --;
    }
    while ($ofs < 1) {
        $lilen ++;
        $ofs ++;
    }
    if ($lilen <= scalar(@terms) && $lilen <= $limit) {
        $left = join(",", splice(@terms, 0, $lilen));
    } else {
        print STDERR "# $aseqno padding_prep.pl found length $lilen too big\n";
    	$callcode = "toobig";
    }
} # get_terms
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

