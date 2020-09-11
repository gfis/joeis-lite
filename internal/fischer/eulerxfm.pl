#!perl

# Extract parameters for jOEIS eulerxfm.jpat 
# 2020-08-15: copied from eulerper.pl, new class EulerTransform
# 2020-03-07, Georg Fischer
#
#:# Usage:
#:#   perl eulerxfm.pl $(COMMON)/cat25.txt > eulerxfm.gen
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $callcode = "eulerxfm";
my $perlen = 0;
my $period = "";
my @periods = ();
my $aseqno = "A000000";
my $line = "";
my @modulos = ();
my $reason = "";
my $lcm = 17; # least common multiple
my $negate = 0; # whether "not modulo ..."
my $seqtype; # "FiniteSequence" or "PeriodicSequence"

while (<>) {
    s/\s+\Z//; # chompr
    $line = $_;
    $seqtype = 2; # periodic
    if (0) {

    } elsif ($line =~ m{Euler transform of (period|length)[ \-]+(\d+)\s+(sequence\s+)?\[?([\d \,\-\.]+)}) {
        ($seqtype, $perlen, $period) = ($1, $2, $4);
        $period =~ s{\s}{}g;
        $period =~ s{\,?\s*\.\.\.}{};
        $reason = "$seqtype: $period";
        if ($seqtype =~ m{length}) {
            $seqtype = 1;
        } else {
            $seqtype = 2;
        }
        if ($period !~ m{\A(\-?\d+)(\,\-?\d+)*\Z}) {
            @periods = ();
        } else {
            @periods = split(/\,/, $period);
        }
        &output();

    #--------
    # A035667 Number of partitions of n into parts 7k+3 and 7k+5 with at least one part of each type.
    } elsif ($line =~ m{with at least one part of each type}) {
        # ignore
        
    #--------
    # A035457 Number of partitions of n into parts of the form 4*k + 2.
    # A035945 1,0,1,1,1,1,1,1,0,1,0
    #   Number of partitions of n into parts not of the form 11k, 11k+2 or 11k-2.
    # A036017 EulerTra Number of partitions of n into parts not of form 4k+2, 12k, 12k+1 or 12k-1. nonn,easy,synth 1
    # A035944	null	Number of partitions in parts not of the form 11k, 11k+1 or 11k-1. Also number of partitions with no part of size 1 and differences between parts at distance 4 are greater than 1.	nonn,easy,synth	1..51
    } elsif ($line =~ m{Number of partitions (of \w )?int?o? parts (not )?(of the form |of form )?(\d+\*?[a-z][\+\-\d]*((\,\s*| or | and )\d+\*?[a-z][\+\-\d]*)*)\.}) {
        # determine mask a,b,c,d such that it represents a modulo pattern a*(4k+1),b*(4k+2),c*(4k+3),d*(4k+4)
        $negate = length($2 || "") > 0 ? 1 : 0;
        my $form = $4; # rest up to dot
        $reason = "form: " . ($2 || "") . ($3 || "") . "$form";
        $form =~ s{or|and?}{\,}g; # now list of comma separated terms
        if (($form =~ m{[a-z]}) and ($form !~ m{of}) and ($form !~ m{\/})) { # not only digits
            $form =~ s{[^0-9\,a-z\+\-\*]}{}g; # remove spaces etc.
            my @nums = sort { $b <=> $a } ($form =~ m{(\d+)\w}g); 
            if (scalar(@nums) > 0 and $nums[0] > 0 and $nums[0] <= 32) {
                $perlen = $nums[0]; # maximum
                @modulos = ();
                map { my $part = $_;
                    my $add  = 0;
                    my $mult = 1;
                    if ($part !~ m{[\-\+]}) {
                        $part =~ m{(\d+)\*?\w};
                        $mult = $1;
                    } elsif ($part =~ m{(\d+)\*?\w([\+\-])(\d+)}) {
                        ($mult, $add) = ($1, "$2$3");
                        if ($add < 0) {
                            $add += $mult;
                        }
                    } else {
                        print STDERR "# ??? $line";
                    }
                    for (my $k = 0; $k*$mult < $perlen; $k ++) {
                        push(@modulos, ($k * $mult + $add) % $perlen);
                    }
                } split(/\,/, $form);
                @periods = &set_mask($negate, $perlen);
                &output();
            } # $perlen > 0
        } # not only digits
        
    #--------
    # %N A035451 Number of partitions of n into parts congruent to 1 mod 4.
    # %N A096981 Number of partitions of n into parts congruent to {0, 1, 3, 5} mod 6.
    # %N A115671 Number of partitions of n into parts not congruent to 0, 2, 12, 14, 16, 18, 20, 30 (mod 32).
    # %F A105780 Number of partitions of n into parts all not == 0, 6, 8 (mod 14).
    } elsif ($line =~ m{Number of partitions of n into parts (all |that are |which are )?(not )?(congruent to |each equal to |\=\= )([^\.]+)\.}) {
        $negate = length($2 || "") > 0 ? 1 : 0;
        my $form = $4; # rest up to dot
        if (($form !~ m{\+\-})) {
            $reason = "congruent: " . ($2 || "") . ($3 || "") . "$form";
            $form =~ s{or|and?}{\,}g;
            $form =~ s{mod\s*(\d+)}{};
            $perlen = $1;
            $form =~ s{[^0-9\,]}{}g;
            @modulos = grep { m{\A\d+\Z} } split(/\,/, $form); # numbers only
            @periods = &set_mask($negate, $perlen);
            &output();
        }

    #--------
    # %N A116377 Number of partitions of n into parts with digital root = 7.
    # %N A147787 Number of partitions of n into parts divisible by 4,6 or 9.
    # etc.
    } elsif ($line =~ m{Number of partitions of \w into parts }) {
        print STDERR "$line\n";
    }
} # while <>
#================================
sub output { # global $line, @periods, $reason
    $line =~ m{^\%\w (A\d+)};
    $aseqno = $1;
    $perlen = scalar(@periods);
    if ($perlen > 0) {
        print join("\t", $aseqno, $callcode, 0, $seqtype, "expectedTerms", join(",", @periods), 0, "$reason") . "\n";
    }
} # output
#--------
sub set_mask { # leftmost bit is 1 mod k, next is 2 mod k, last is k mod k = 0 mod k
    my ($negate, $lcm) = @_; # negate = 0|1
    my @bits = ();
    for (my $ilcm = 0; $ilcm < $lcm; $ilcm ++) {
        $bits[$ilcm] = $negate;
    } # for $ilcm
    foreach my $mod (@modulos) {
        $bits[$mod] = 1 - $negate;
    }
    my $bit0 = shift(@bits);
    push(@bits, $bit0);
    return (@bits);
} # set_mask
#--------
__DATA__

