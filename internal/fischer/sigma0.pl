#!perl

# Extract parameters for "number of divisors of Annnnn" 
# 2023-02-28, Georg Fischer: copied from prodet.pl
#
#:# Usage:
#:#   perl prodet.pl [-d debug] [-f ofter_file] joeis_names.txt > sigma0.gen
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#:#     -f  file with aseqno, offset1, terms (default $(COMMON)/joeis_ofter.txt)
#:# Reads ofter_file for implemented jOEIS sequences with their offsets and first terms
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $line = "";
my ($aseqno, $callcode, $offset, $superclass, $name, @rest);
$callcode = "sigma0";
my $rseqno;
my $ofter_file = "../../../OEIS-mat/common/joeis_ofter.txt";
my $debug   = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-cc}i) {
        $callcode   = shift(@ARGV);
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
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
my $nok = "";
while (<>) {
    s/\s+\Z//; # chompr
    $line = $_;
    ($aseqno, $superclass, $name, @rest) = split(/\t/, $line);
    next if $superclass !~ m{\Anyi};
    $nok = "";
    $rseqno = "A000000";
    if ($name =~ m{\ANumber of divisors of (.+)}) {
        my $text = $1;
        if ($text =~ m{(A\d+)}) {
            $rseqno = $1;
        } else {
            $nok = "rno";
        }
        &output();
    } # if sigma0 
} # while <>
#================================
sub output { # global $line, @periods, $reason
    my $offset = 0;
    if (defined($ofters{$rseqno})) { # found and implemented in jOEIS {
        $offset = $ofters{$rseqno};
        $offset =~ s{\t.*}{}; # keep offset only
    } elsif ($nok eq "") {
        $nok = "nyi";
    }
    if ($nok eq "") {
        print        join("\t", $aseqno, $callcode, $offset, $rseqno, $name) . "\n";
    } else {
        print STDERR join("\t", $aseqno, $callcode, $offset, $rseqno, $nok, $name) . "\n";
    }
} # output
#--------
__DATA__
A104352 nyi L   Number of divisors of A104350(n).       nonn,synth      2..40   nyi     _Reinhard Zumkeller_, Mar 06 2005
A104361 nyi Ft  Number of divisors of A104357(n) = A104350(n) - 1.      nonn,changed,   2..145  nyi     _Reinhard Zumkeller_, Mar 06 2005
A104369 nyi Ft  Number of divisors of A104365(n) = A104350(n) + 1.      nonn,changed,   1..141  nyi     _Reinhard Zumkeller_, Mar 06 2005
A105191 nyi t   Number of divisors of n100000000001.    nonn,base,synth 0..74   nyi     _Parthasarathy Nambi_, Apr 11 2005
A105192 nyi     Number of divisors of n101.     nonn,base,synth 0..111  nyi     _Parthasarathy Nambi_, Apr 11 2005
A105193 nyi t   Number of divisors of n1001.    nonn,base,synth 0..81   nyi     _Parthasarathy Nambi_, Apr 11 2005