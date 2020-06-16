#!perl

# Select the "optimal" formula for an A-number
# @(#) $Id$
# 2020-06-16, Georg Fischer
#
#:# Usage:
#:#   perl deriv_select.pl [-d debug] deriv5.tmp > output
#-------------------------------------------------
use strict;
use integer;
use warnings;
use Digest::MD5;

my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $debug = 0;
if (scalar(@ARGV) < 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my ($aseqno, $callcode, $offset, $parm1, @rest);
my $oseqno = "";
my %group = (); # maps formulae to their length
while (<>) {
    my $line = $_;
    next if $line !~ m{\AA\d+};
    $line =~ s/\s+\Z//; # chompr
    ($aseqno, $callcode, $offset, $parm1, @rest) = split(/\t/, $line);
    $parm2 ||= "";
    $parm3 ||= "";
    $parm4 ||= "";
    if ($oseqno ne $aseqno) { # group change
        &output_group();
        $oseqno = $aseqno;
    } # group change
    $group{$parm1} = length($parm1);
} # while <>
&output_group();
#----------------
sub output_group {
    my $gno = scalar(%group);
    my $form = "";
    my $key;
    if ($gno == 0) { # nothing to be output
    } else { # several formulas - take the last formula of the shortest 
        my $len = 61947; # very high
        foreach $key (keys(%group)) {
            my $value= $group{$key};
            if ($value <= $len) { # the last if both length are equal
                $len = $value;
                $form = $key;
            }
        } # foreach
    }
    print join("\t", $oseqno, $callcode, $offset, $form, @rest) . "\n";
    %group = (); # clear for new group
} # output_group
#----------------
__DATA__
A326055	postder	1	~~;n;A008833_1(;n;A008833_1);-		0
A326122	postder	1	~~;10;A000203_1(;n;A000203_1);*		0
A326125	postder	1	~~;n;A000593_1(;n;A000593_1);*		0
A326126	postder	1	~~;A000203_1(;n;A000203_1);A007913_1(;n;A007913_1);-		0
A326127	postder	1	~~;A000203_1(;n;A000203_1);A007913_1(;n;A007913_1);-;n;-		0
A326127	postder	1	~~;A001065_1(;n;A001065_1);A007913_1(;n;A007913_1);-		0
A326128	postder	1	~~;n;A007913_1(;n;A007913_1);-		0
A326142	postder	1	~~;A000203_1(;n;A000203_1);A007947_1(;n;A007947_1);-		0
A326143	postder	1	~~;A001065_1(;n;A001065_1);A007947_1(;n;A007947_1);-		0
A326143	postder	1	~~;A000203_1(;n;A000203_1);A007947_1(;n;A007947_1);-;n;-		0
A326146	postder	1	~~;A000203_1(;n;A000203_1);A020639_1(;n;A020639_1);-;n;-		0
A326146	postder	1	~~;A001065_1(;n;A001065_1);A020639_1(;n;A020639_1);-		0
A326187	postder	1	~~;A000203_1(;n;A000203_1);A003557_1(;n;A003557_1);-		0
