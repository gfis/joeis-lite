#!perl

# Determine terms to  be skipped and/or prepended after some transform 
# @(#) $Id$
# 2020-09-20: Georg Fischer: copied from posins.pl
#
#:# Usage:
#:#     perl -i.bak deris_shuffle.pl [-d mode] [-l 3] deris.gen
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#:#     -l  limit for number of terms to be skipped and/or prepended (default: 3)
#:# deris.gen is a file with aseqno, callcode, offset1, rseqno, parm2, constr, parm4, parm7=aterms, parm8=rterms.
#:# It is modified in place and parm2=skip and parm4=prepends is set if appropriate, 
#:# and the last 2 letters of the callcode are replaced by "pp".
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
my $limit = 4;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } elsif ($opt   =~ m{\-lim}i) {
        $limit      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $line;
my ($aseqno, $callcode, @parms);
my ($alist, $rlist);
my (@aterms, @rterms);
while (<>) {
    $line = $_;
    next if $line =~ m{\A\#}; # skip comments from previous runs in debugging mode
    $line =~ s/\s+\Z//; # chompr
    ($aseqno, $callcode, @parms) = split(/\t/, $line);
    $parms[2] = "";
    $parms[4] = "";
    my $iparm = 0;
    my $offset = $parms[$iparm ++];
    my $rseqno = $parms[$iparm ++]; # 1
    my $roffset= $parms[$iparm ++]; # 2
    my $dummy3 = $parms[$iparm ++]; # 3
    my $dummy4 = $parms[$iparm ++]; # 4
    my $dummy5 = $parms[$iparm ++]; # 5
    my $dummy6 = $parms[$iparm ++]; # 6
    $alist     = $parms[$iparm ++]; # 7
    $rlist     = $parms[$iparm ++]; # 8

    my $busy = 1;
    my $inda = 0;
    while ($busy && $inda < $limit) {
        my @asplit = split(/\,/, $alist);
        @aterms = splice(@asplit, $inda);
        my $indr = 0;
        while ($busy && $indr < $limit) {
            my @rsplit = split(/\,/, $rlist);
            @rterms = splice(@rsplit, $indr);
            $busy = 1 - &is_match($inda, $indr);
            $indr ++;
        } # while $indr
        $inda ++;
    } # while $inda
    print join("\t", $aseqno, $callcode, @parms) . "\n";
} # while <>
#----
sub is_match {
    my ($inda, $indr) = @_;
    my $match = 0;
    my @bterms; 
    if (0) {
    } elsif ($callcode =~ m{\Adiff}) {
        for (my $ind = 0; $ind < $limit; $ind ++) {
            push(@bterms, $rterms[$ind + 1] - $rterms[$ind]);
        } # for $ind
    } elsif ($callcode =~ m{\Aesse}) {
        for (my $ind = 0; $ind < $limit; $ind ++) {
            push(@bterms, $rterms[$ind]);
        } # for $ind
    } else { # callcode not handled
    }
    if (scalar(@bterms) > 0) {
        my $same = 1;
        for (my $ind = 0; $ind < $limit; $ind ++) {
            if ($bterms[$ind] != $aterms[$ind]) {
                $same = 0;
            }
        } # for $ind
        if ($debug >= 1) {
            print "# $aseqno: inda=$inda, indr=$indr, same=$same" 
                . ", aterms=" . join(",", @aterms) 
                . ", bterms=" . join(",", @bterms) 
                . "\n";
        } 
        if ($same == 1) {
            $match = 1;
            $parms[2] = ($indr > 0) ? "$indr, " : ""; # skip
            my @asplit = split(/\,/, $alist);
            $parms[4] = ($inda > 0) ? ", " . join(",", splice(@asplit, 0, $inda)) : ""; # prepend
            if (length($parms[2]) + length($parms[4]) > 0) {
                $callcode =~ s{..\Z}{pp}; # replace last 2 letters
            }
        } # same
    } 
    return $match;
} # is_match
__DATA__
