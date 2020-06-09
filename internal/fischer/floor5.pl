#!perl

# Assemble the lines with converted CR expressions
# @(#) $Id$
# 2020-06-09, Georg Fischer
#
#:# Usage:
#:#    perl infix_dex.pl ... \
#:#    | perl floor5.pl [-d debug] > output
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $debug = 0;
if (scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $ignore = 1;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

# infix_dex.pl has: print join("\t", $aseqno, "$callcode$callext", $offset, $result, $keep0, $base, $name) . "\n";
my $sep = "~~";
my $separator = "$sep;  private final CR ";
my $buffer2 = $separator;
my $oseqno = "";
my $varcount = 0;
my $var;
my ($aseqno, $callcode, $offset, $expr, $keep, $base, $name, @rest);
my %varhash = ();
while (<>) {
    my $line = $_;
    next if $line !~ m{\AA\d+};
    $line =~ s/\s+\Z//; # chompr
    ($aseqno, $callcode, $offset, $expr, $keep, $base, $name, @rest) = split(/\t/, $line);
    $callcode =~ m{\Adex(\w)};
    $var = $1;
    if ($var !~ m{\d}) { # letter - variable name
        if (0) {
        } elsif ($oseqno eq "") {
            $oseqno = $aseqno;
            $varcount = 0;
        } elsif ($oseqno ne $aseqno) {
            print "# $aseqno assertion 1: $callcode oseqno=$oseqno <> aseqno=$aseqno\n";
            $oseqno = $aseqno;
            $buffer2 = $separator;
            %varhash = ();
            $varcount = 0;
        }
        $varhash{$var} = 1;
        $buffer2 .= "$sep$var = $expr";
        $varcount ++;
    } else { # digit - end of block
        $varhash{"n"} = 1; # always present
        if (0) {
        } elsif ($var != $varcount) {
            print "# $aseqno assertion 2: $callcode var=$var <> varcount=$varcount\n";
        } else { # = 
            if ($debug >= 1) {
               print "# callcode=$callcode, var=$var, varcount=$varcount\n";
            }
            $callcode =~ s{\Adex\w}{floor3};
            if ($buffer2 eq $separator) {
                $buffer2 = "";
            }
            my $ok = 1;
            map { if (! defined($varhash{$_})) { $ok = 0; } } grep { m{\A[a-z]\Z} } split(/\b/, $expr);
            if ($ok == 1) {
                if ((($expr =~ m{REALS}) or ($buffer2 =~ m{REALS})) and ($callcode !~ m{cr\Z})) {
                    $callcode .= "cr";
                }
                print join("\t", $aseqno, $callcode, 0, $expr, $buffer2, $name) . "\n";
            } else {
                print "# $aseqno missing variable in $expr, vars=" . join(",", keys(%varhash)) . "\n";
            }
        }
        $buffer2 = $separator;
        $oseqno = "";
        %varhash = ();
    } # digit
} # while
#----------------
__DATA__
A188041	dexr	0	CR.SQRT2	true	10	sqrt(2)
A188041	dexk	0	(CR.THREE)	true	10	3
A188041	dex2	0	n.multiply(r).floor().subtract(k.multiply(r).floor()).subtract(n.multiply(r).subtract(k.multiply(r)).floor())	true	10	floor(n*r)-floor(k*r)-floor(n*r-k*r)
A188044	dexr	0	CR.SQRT2	true	10	sqrt(2)
A188044	dexk	0	(CR.FOUR)	true	10	4
A188044	dex2	0	n.multiply(r).floor().subtract(k.multiply(r).floor()).subtract(n.multiply(r).subtract(k.multiply(r)).floor())	true	10	floor(n*r)-floor(k*r)-floor(n*r-k*r)

