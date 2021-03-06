#!perl

# Extract parameters for jOEIS
# eulerper.jpat (EulerTransformSequence(new PeriodicSequence(period),0))
# 2020-08-13: treat 111 erroneous?
# 2020-03-07, Georg Fischer
#
#:# Usage:
#:#   perl eulerper.pl $(COMMON)/cat25.txt > eulerper.gen
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $perlen = 0;
my $period = "";
my @periods = ();
my $aseqno = "A000000";
my $line = "";
my @modulos = ();
my $reason = "";
my $lcm = 17; # least common multiple
my $negate = 0; # whether "not modulo ..."

while (<>) {
	s/\s+\Z//; # chompr
    $line = $_;
    if (0) {

    } elsif ($line =~ m{Euler transform of (period|length)[ \-]+(\d+)\s+(sequence\s+)?\[?([\d \,\-\.]+)}) {
        ($perlen, $period) = ($2, $4);
        $period =~ s{\s}{}g;
        $period =~ s{\,?\s*\.\.\.}{};
        $reason = "period: $period";
        if ($period !~ m{\A(\-?\d+)(\,\-?\d+)*\Z}) {
            @periods = ();
        } else {
            @periods = split(/\,/, $period);
        }
        &output();
        
    } elsif ($line =~ m{Number of partitions }) { # big else
    	if (0) {
        #--------
        # A035457 Number of partitions of n into parts of the form 4*k + 2.
        # A035945 1,0,1,1,1,1,1,1,0,1,0
        #   Number of partitions of n into parts not of the form 11k, 11k+2 or 11k-2.
        # A036017 EulerTra Number of partitions of n into parts not of form 4k+2, 12k, 12k+1 or 12k-1. nonn,easy,synth 1
        } elsif ($line =~ m{Number of partitions of \w into parts (not )?(of the form |of form )?(\d+\*?[a-z][\+\-\d]*((\, | or | and )\d+\*?[a-z][\+\-\d]*)*)\.}) {
        	# determine mask a,b,c,d such that it represents a modulo pattern a*(4k+1),b*(4k+2),c*(4k+3),d*(4k+4)
            $negate = length($1 || "") > 0 ? 1 : 0;
            my $form = $3; # rest up to dot
            $reason = "form: " . ($1 || "") . ($2 || "") . "$form";
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
        } elsif ($line =~ m{Number of partitions of n into parts (all )?(not )?(congruent to |\=\= )([^\.]+)\.}) {
            $negate = length($2 || "") > 0 ? 1 : 0;
            my $form = $4; # rest up to dot
            if (($form !~ m{\+\-})) {
                $reason = "congruent: " . ($2 || "") . ($3 || "") . "$form";
                $form =~ s{or|and}{\,}g;
                $form =~ s{mod\s*(\d+)}{};
                $perlen = $1;
                $form =~ s{[^0-9\,]}{}g;
                @modulos = grep { m{\A\d+\Z} } split(/\,/, $form); # numbers only
                @periods = &set_mask($negate, $perlen);
                &output();
            }
        
        #--------
        # %N A109697 Number of partitions of n into parts each equal to 1 mod 5.
        # %N A116377 Number of partitions of n into parts with digital root = 7.
        # %N A147787 Number of partitions of n into parts divisible by 4,6 or 9.
        # etc.
        } elsif ($line =~ m{Number of partitions of \w into parts }) {
            print STDERR "$line\n";
        }   
    } # big else
} # while <>
#================================
sub set_mask {
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
sub output { # global $line, @periods, $reason
    $line =~ m{^\%\w (A\d+)};
    $aseqno = $1;
    $perlen = scalar(@periods);
    if ($perlen > 0) {
        print join("\t", $aseqno, "eulerper", 0, $perlen, join(",", @periods), 0, "$reason") . "\n";
    }
}
#--------
__DATA__

