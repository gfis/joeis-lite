#!perl

# Extract g.f.s with product of (1-x^k)
# 2020-09-18, Georg Fischer
#
#:# Usage:
#:#   grep -iE "prod" $(COMMON)/cat25.txt \
#:#   | perl prod1_xk.pl [-d debug]  [-f ofter_file] > $@.tmp
#:#     -f  file with aseqno, offset1, terms (default $(COMMON)/joeis_ofter.txt)
# Generates the following callcodes:
#   prod1_xk
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $ofter_file = "../../../OEIS-mat/common/joeis_ofter.txt";
my $debug   = 0;
my $VOID = "A000000";
my ($aseqno, $callcode, $offset, $var, $name, @rest);
my $rseqno;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt   =~ m{\-f}  ) {
        $ofter_file = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
#----------------
my $terms;
my %ofters = ();
open (OFT, "<", $ofter_file) || die "cannot read $ofter_file\n";
while (<OFT>) {
    s{\s+\Z}{};
    ($aseqno, $offset, $terms) = split(/\t/);
    $terms = $terms || "";
    if ($offset < -1) { # offsets -2, -3: strange, skip these
    } else {
        $ofters{$aseqno} = "$offset\t$terms";
    }
} # while <OFT>
close(OFT);
print STDERR "# $0: " . scalar(%ofters) . " jOEIS offsets and some terms read from $ofter_file\n";
#----------------
my $form = "";
my $exp = "";
$callcode = "prod1_xk";
my $tcode;
my $start;
my $rest;

while (<>) {
    my $line = $_;
    if ($line =~ m{\A\%(\w)\s+(A\d+)\s+(.*)}) {
        ($tcode, $aseqno, $name) = ($1, $2, $3);
        $rseqno = $VOID;
        $form = "";
        $exp = "";
        if (0) {
        #                     1                              2       3            4
        } elsif ($name =~ m{\A(G\.f\.\s*\:?|Expansion of|)\s*([Pp]rod(uct)?\_? *\{(\w)[\>\=?\d ]+\}\s*[^\.\;]*)}) {
            # %F A160974 G.f.: Product_{j>=1} (1+x^(4*j)/(1-x^j)). - _Emeric Deutsch_, Jun 24 2009
            $exp = $4;
            $form = $2;
            $form =~ s{\b$exp\b}{k}g;
            $rest = "";
            $form =~ s{ *in powers of \w.*}{};
            if ($form =~ s{(\,? *where .*)}{}) {
            	$rest = $1;
            }
            $form =~ s{ }{}g;
            $exp = "k";
            $rseqno = "A000012";
            if ($form =~ m{(A\d\d+)}) {
                $rseqno = $1;
            }
            $form =~ s{\AProd(uct)?\_?}{}i;
            $start = ">=1";
            if ($form =~ s{\A\{k([\d\>\=]+)\}}{}) {
                $start = $1;
            }
            $start =~ s{\A\>0\Z}{\>=1};
            $start =~ s{\A\>1\Z}{\>=2};
            &output();
        } else {
            print STDERR "$line";
        }
    }
} # while <>
#----
sub output {
    if (defined($ofters{$rseqno}) and ! defined($ofters{$aseqno})) {
        print join("\t", $aseqno, $callcode, 0, "k", $form, $start, $rest). "\n";
    }
} # output
#================================
__DATA__
