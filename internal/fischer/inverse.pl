#!perl

# Extract parameters for InVerseSequence
# 2022-05-26, Georg Fischer
#
#:# Usage:
#:#   grep ... $(COMMON)/joeis_names.txt \
#:#   | perl inverse.pl [-d debug] [-f ofter_file] > output
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#:#     -f  file with aseqno, offset1, terms (default $(COMMON)/joeis_ofter.txt)
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $line = "";
my ($aseqno, $superclass, $callcode, @rest, $name);
my $debug   = 0;
my $offset = 0;
my $rseqno = "";
my $ofter_file = "../../../OEIS-mat/common/joeis_ofter.txt";
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
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
my (@terms, $termlist, $ofsa);
while (<DATA>) { # from https://oeis.org/wiki/Index_to_OEIS:_Section_Per#IntegerPermutation
    s/\s+\Z//; # chompr
    $line = $_;
    foreach my $pair ($line =~ m{(A\d\d\d+\-A\d\d\d+)}g) {
        $pair =~ m{\A(A\d\d\d+)\-(A\d\d\d+)};
        my ($aseqno, $bseqno) = ($1, $2);
        $ofsa = "";
        @terms = (0);
        my  $ofta = $ofters{$aseqno};
        my  $oftb = $ofters{$bseqno};
        if (! defined($ofta)) { # exchange
            my $temp = $aseqno; 
            $aseqno = $bseqno; 
            $bseqno = $temp;
            $ofta = $ofters{$aseqno};
            $oftb = $ofters{$bseqno};
        }
        if (0) {
        } elsif (! defined($ofta)) { # none defined
            $callcode = "invnone";
        } elsif (  defined($oftb)) { # both defined
            $callcode = "invboth";
        } else { # a defined, b not
            $callcode = "inverse";
            ($ofsa, $termlist) = split(/\t/, $ofta);
            @terms = split(/\,/, $termlist);
        }
        if ($callcode =~ m{\Ainverse}) {
            print        join("\t", $bseqno, $callcode, 0, "new $aseqno()", $ofsa
            , $ofsa # , $terms[0]
            ) . "\n";
        } else {
            print STDERR join("\t", $bseqno, $callcode, 0, "new $aseqno()", $ofsa, $terms[0]) . "\n";
        }
    }
} # while <>
__DATA__
A003100-A174025, A003188-A006068, A064706-A064707 (Gray code related), A006368-A006369 (amusical permutation)
A004484-A064206, A004485-A064207, A004486-A064208, A004487-A064211 (Sprague-Grundy values for Wyt Queens)
A029654-A064360, A064413-A064664, A032447-A064275, A035312-A035358, A035506-A064357, A035513-A064274, A047708-A048850
A048672-A246353, A048673-A064216, A048679-A048680 (binary encoding related), A052330-A064358, A059900-A059884
A052331-A064359, A054238-A054239, A054424-A054426, A054427-A054428, A057114-A057115
A054084-A064786, A053212-A064787, A060736-A064788, A054068-A054069, A057028-A064789, A060734-A064790, A064537-A064791
A034175-A064928, A064929-A064930, A057027-A064578, A054082-A064579, A036552-A065037
A065164-A065168, A065165-A065169, A065166-A065170, A065171-A065172, A065174-A065175 (perm. of Z folded to N, site swap pattern)
A065181-A065182, A065183-A065184, A065186-A065187, A065188-A065189 (Greedy Queens), A064736-A064745, A065249-A065250
A065259-A065260, A065263-A065264, A065265-A065266, A065269-A065270, A065271-A065272, A065275-A065276, A065277-A065278
A065281-A065282, A065283-A065284, A065287-A065288, A065289-A065290 (site swap), A065253-A065254
A065306-A065307 (Goldbach), A004515-A065256, A065257-A065258 (Quintal Queens)
A064417-A064956, A064418-A064958, A064419-A064959 (GCD(a(n),a(n-1))>k), A065561-A065578, A065562-A065579
A065627-A065628, A065629-A065630, A065631-A065632, A065633-A065634, A065635-A065636, A065637-A065638, A065639-A065640
A065660-A065661, A065662-A065663, A065664-A065665, A065666-A065667, A065668-A065669, A065670-A065671, A065672-A065673
A065649-A065650, A065934-A065935, A066248-A066249, A066250-A066251, A067587-A066884, A068225-A068226, A072061-A072062
A072732-A072733, A072734-A072735, A072793-A072794, A074305-A074306, A074307-A074308, A051261-A077226, A081344-A194280, A083412, A084469-A084470
A084453-A084454, A084455-A084466, A084459-A084460, A084461-A084462, A084489-A084490, A084491-A084492, A084493-A084494
A084495-A084496, A084497-A084498, A084499-A084530, A092401-A203602, A094608, A098003-A098485, A098488-A226134, A105529-A105530 (Gray code related), A108644, A108918-A118319, A118757-A118758, A134564, A139706-A139708
A147995-A163544, A153141-A153142, A153151-A153152, A154435-A154436, A154447-A154448
A163233-A163234, A163235-A163236, A163237-A163238, A163239-A163240 (Gray codes 2-D)
A163328-A163329, A163330-A163331, A163334-A163335, A163336-A163337, A163338-A163339, A163340-A163341 (Peano curve)
A163355-A163356, A163357-A163358, A163359-A163360, A163361-A163362, A163363-A163364, A163905-A163906, A163907-A163908, A163915-A163916 (Hilbert curve)
A163511-A243071, A166041-A166042, A166043-A166044 (Peano to Hilbert), A175500-A272570, A185180-A209293, A185725, A191450-A254047, A194030-A194031, A194988-A194989, A210770-A210771, A213928, A214226, A217013-A217294, A217296, A219159, A219360, A220516, A220952, A231550-A231551, A244153-A244154, A254103-A254104, A257470-A257271, A268717-A268718, A268823-A268824
A307485-A307613 (positive integers grouped by parity: one odd, two even, four odd, eight even, etc.)
A334619, A334998-A334999, A337822, A337838, A337909, A338840, A338841, A338843, A338844, A338846, A339723, A339853
permutations of the integers, induced by Catalan rerankings, each paired with its inverse:
(1) A071651-A071652, A071653-A071654, A072634-A072635, A072636-A072637, A072656-A072657, A072658-A072659
(2) A072646-A072647, A072787-A072788, A072764-A072765, A072766-A072767, A075161-A075162, A075168-A075169