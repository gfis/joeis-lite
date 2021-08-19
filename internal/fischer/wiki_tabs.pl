#!perl

# Create wiki text for tables derived from Dbat SQL results
# @(#) $Id$
# 2020-08-07, Georg Fischer: copied from wiki_sql.pl
#
#:# Usage:
#:#   perl wiki_tabs.pl [-d debug] [-e 0|1] [-x symbol] callcode.witab > callcode.wiki.tmp
#:#       -e 1 create external links to "https://oeis.org/" for A-numbers 
#:#            (default or -e 0: automatically linked in the OEIS)
#:#       -x s mark diagonal elements with symbol
#:#   Table seq4 must already be filled by "make CC=callcode select".
#
# The rows for a table are read from a view (sumliv.create.sql) with the following fields:
#   aseqno, callcode, pow,   mult,  mquant, least, dist, ways, name
# The queries all return a result set of the form:
#   aseqno, name, rowval, colval
# The resulting table spans the range of rowval's times the range of colval's,
# sets a suitable table header and row head cells, 
# and links the aseqno's to the OEIS surrounded by> a <span title="name">.
# Missing cells are filled with "&#xa0;".
#--------------------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);
my $debug    = 0;
my $callcode = 0;
my $diagsym  = "";
my $extern   = 0;
my $file_no  = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt =~ m{d}) {
        $debug    = shift(@ARGV);
    } elsif ($opt =~ m{c}) {
        $callcode = 1;
    } elsif ($opt =~ m{e}) {
        $extern   = shift(@ARGV);
    } elsif ($opt =~ m{x}) {
        $diagsym  = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $xmlfile;
my $state   = "init";
my $marker  = "witab";
my $dbat    = "java -jar ../../../dbat/dist/dbat.jar -e UTF-8 -c worddb";
my $oeis    = "https://oeis.org/";
my $sep     = ";";
my $nbsp    = "\&#xa0;";

while (<>) { # read inputfile
    s/\s+\Z//; # chompr
    my $line = $_;
    if (0) {
    } elsif ($state eq "init") {
        if (0) {
        } elsif ($line =~ m{\A\s*\<\!\-\-$marker}) {
            $state = "body";
            $file_no ++;
            $xmlfile = "$0.$file_no.xml";
            open(XML, ">", $xmlfile) or die "cannot write \"$xmlfile\"\n";
            print XML <<GFis;
<dbat   xmlns   ="http://www.teherba.org/2007/dbat"
        xmlns:ht="http://www.w3.org/1999/xhtml"
        headers="false"
        >
GFis
        } elsif ($line =~ m{\A\s*$marker\-\-\>}) {
            $state = "init";
        } else {
            print "$line\n";
        }
    } elsif ($state eq "body") { # read lines with SQL
        if (0) {
        } elsif ($line =~ m{\A\s*$marker\-\-\>}) { # fetch a tab-separated result set and print it in WIki table format
            print XML <<GFis;
</dbat>
GFis
            close(XML);
            &generate_table("$dbat -x -m tsv -f $xmlfile"); # tab separated
            $state = "init";
        } else {
            print XML "$line\n";
        }
    } else {
        print STDERR "invalid state $state, line=$line\n";
    }
} # while <>
#--------
sub generate_table {
    my ($cmd) = @_;
    my ($aseqno, $name, $rowval, $colval);
    my @matrix = ();
    my ($rown, $coln); # numeric values
    my ($minrown, $maxrown) = (2906, 0);
    my ($mincoln, $maxcoln) = (2906, 0);
    my @rowvals = (); # starts usually, at [0]
    my @colvals = (); # indexed by numeric value in heading
    my @wikicols; # starts usually, at [0]
    
    #---- load matrix
    $rown = 0;
    foreach my $row (split(/\r?\n/, `$cmd`)) { # store rows and determine ${min|max}{row|col}n
        if ($row =~ m{\AA\d+}) { # row starts with A-number
            push (@matrix, $row);
            ($aseqno, $name, $rowval, $colval) = split(/\t/, $row);
            $rowvals[$rown] = $rowval; # store them all sequentially
            $colval  =~ m{(\d+)};
            $coln    = $1;
            $colvals[$coln] = $colval; # m=2 would store in [2]
            $minrown = ($rown < $minrown) ? $rown : $minrown;
            $maxrown = ($rown > $maxrown) ? $rown : $maxrown;
            $mincoln = ($coln < $mincoln) ? $coln : $mincoln;
            $maxcoln = ($coln > $maxcoln) ? $coln : $maxcoln;
            $rown ++;
        } # row not empty
    } # foreach row 1
    push (@matrix, join("\t", "A999999", "", "}}}}", "}}}}")); # high values

    #---- print table heading
    @wikicols = (); 
    for ($coln = $mincoln; $coln <= $maxcoln; $coln ++) {
        push (@wikicols, defined($colvals[$coln]) ? $colvals[$coln] : $nbsp);
    } # for coln
    if (1) {
        print "{| class=\"wikitable\" style=\"text-align:left\"\n"
             . "! $nbsp !!" # header of wiki table
             . join("!!", @wikicols) . "\n"
             . "|-\n";
    }
    #---- print table body rows
    @wikicols = (); 
    @colvals  = ();
    my $old_rowval = $rowvals[0] || $nbsp;
    $aseqno   = ""; # to handle the initial group change
    # $rowvals[0] was set above to the rowval of the first row
    foreach my $row (@matrix) { # fetch all rows and print the wiki table rows
        my ($new_aseqno, $new_name, $new_rowval, $new_colval) = split(/\t/, $row);
        if ($new_rowval ne $old_rowval) { # group change in rowval, print old row
            $old_rowval =~ m{(\d+)};
            $rown = $1;
            if ($debug >= 1) {
                print STDERR "----group change from \"$old_rowval\" to \"$new_rowval\"\n";
            }
            if (length($aseqno) > 0) {
                @wikicols = (); # prepare for next row
                for ($coln = $mincoln; $coln <= $maxcoln; $coln ++) {
                    push (@wikicols, defined($colvals[$coln]) 
                        ? $colvals[$coln] 
                        : ($coln == $rown && length($diagsym) > 0 ? "<center>$diagsym</center>" : $nbsp)
                        );
                } # for coln
                print "| $old_rowval ||" # one wiki table row
                . join("||", @wikicols) . "\n"
                . "|-\n";
            }
            $old_rowval = $new_rowval;
            @colvals = ();
        } # print old row
        $aseqno = $new_aseqno;
        $name   = $new_name;
        $colval = $new_colval || "";
        $colval =~ m{(\d+)};
        if ($colval  =~ m{(\d+)}) {
            $coln   = $1;
            my $encname = $name;
            $encname =~ s{\&}{\&amp\;}g;
            $encname =~ s{\>}{\&gt\;}g;
            $encname =~ s{\<}{\&lt\;}g;
            $colvals[$coln] = "<span title=\"$encname\">"
                 . (($extern == 1) ? "[$oeis$aseqno $aseqno]" : $aseqno)
                 . "</span>";
            if ($debug >= 1) {
                print STDERR "rowval=$new_rowval, colval=$colval, colvals[$coln]=\"$colvals[$coln]\"\n";
            }
        } else {
            # $coln   = $1;
            # $colvals[$coln] = $nbsp;
        } 
    } # foreach row 2
    #---- print table end
    print "|}\n"; 
} # generate_table
#---------------------------------------
__DATA__
{| class="wikitable" style="text-align:left"
!Column j || Branch !! Operation                                !! Form of i   !! Formula              !! First elements   !! Covered residues!! Remaining residues
|-                                                                                                                         
|'''1''' ||(LS) ||                                              ||             ||6*i - 2               
| j      ||  || ||i = q<sub>j</sub>*k + r<sub>j</sub> || s<sub>j</sub>*(i - r<sub>j</sub>)/q<sub>j</sub> + t<sub>j</sub>   || t<sub>j</sub>, ... || t<sub>j</sub> mod s<sub>j</sub>  ||
|-
|}


<dbat   xmlns   ="http://www.teherba.org/2007/dbat"
        xmlns:ht="http://www.w3.org/1999/xhtml"
        encoding="UTF-8"
        lang="en" 
        conn="worddb" 
        headers="false"
        title="aggr01"
        >
    <comment lang="en">Column Aggregation with linked values</comment>
    <comment lang="de">Aggregierte Spalte mit Verweisen auf den Werten</comment>

    <ht:h3>Column aggregation test - with linked values</ht:h3>
    
    <select headers="yes" aggregate="sp2" with=", ">        
        <col label="Application"  name="sp1" href="servlet?spec=test/selec01&amp;name=">sp1</col>
        <col label="Aggr. Column" name="sp2" link="test/selec01&amp;alpha=&amp;beta=&amp;gamma=" width="20">
            concat(sp1, concat('=', concat(sp2, concat('=', sp3))))
        </col>
        <from>pivot</from>
    </select>

</dbat>