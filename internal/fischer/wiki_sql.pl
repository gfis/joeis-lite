#!perl

# Create wiki text for tables derived from SQL results
# @(#) $Id$
# 2020-08-04, Georg Fischer: copied from callcode_wiki.pl
#
#:# Usage:
#:#   perl wiki_sql.pl [-d debug] [-e] callcode.wisq > callcode.wiki.tmp
#:#       -e create external links to A-numbers
#:#   (Table seq4 must already be filled by make CC=callcode select.)
#--------------------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);
my $debug    = 0;
my $callcode = 0;
my $extern   = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{c}) {
        $callcode  = 1;
    } elsif ($opt  =~ m{e}) {
        $extern    = 1;
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $xmlfile = "$0.tmp.xml";
my $state = "init";
my $marker = "wisq";
my $dbat = "java -jar ../../../dbat/dist/dbat.jar -e UTF-8 -c worddb";
while (<>) { # read inputfile
    s/\s+\Z//; # chompr
    my $line = $_;
    if (0) {
    } elsif ($state eq "init") {
        if (0) {
        } elsif ($line =~ m{\A\s*\<\!\-\-$marker}) {
            $state = "head";
        } elsif ($line =~ m{\A\s*$marker\-\-\>}) {
            $state = "init";
        } else {
            print "$line\n";
        }
    } elsif ($state eq "head") { # read 1 line with tab-separated column headings, and print the table start
        my @cols  = split(/\t/, $line);
        print "{| class=\"wikitable\" style=\"text-align:left\"\n!" # header of wiki table
            . join("!!", @cols)
            . "\n|-\n";
        $state = "body";
        open(XML, ">", $xmlfile) or die "cannot write \"$xmlfile\"\n";
        print XML <<GFis;
<dbat	xmlns   ="http://www.teherba.org/2007/dbat"
		xmlns:ht="http://www.w3.org/1999/xhtml"
		headers="false"
		>
GFis
    } elsif ($state eq "body") { # read lines with SQL
        if (0) {
        } elsif ($line =~ m{\A\s*$marker\-\-\>}) { # fetch a tab-separated result set and print it in WIki table format
            print XML <<GFis;
</dbat>
GFis
            close(XML);
            my $cmd = "$dbat -x -m tsv -f $xmlfile";
            foreach my $result(split(/\r?\n/, `$cmd`)) {
                my @fields = split(/\t/, $result);
                print "|" # one wiki table row
                    . join("||", map { m{A99\d{4}} ? "\&\#xa\;" : $_ } @fields)
            		. "\n|-\n"; 
            } # foreach result
            print "|}\n"; # end of wiki table 
            $state = "init";
        } else {
            print XML "$line\n";
        }
    } else {
        print STDERR "invalid state $state, line=$line\n";
    }
} # while <>
#---------------------------------------
__DATA__
{| class="wikitable" style="text-align:left"
!Column j || Branch !! Operation                                !! Form of i   !! Formula              !! First elements   !! Covered residues!! Remaining residues
|-                                                                                                                         
|'''1''' ||(LS) ||                                              ||             ||6*i - 2               
| j      ||  || ||i = q<sub>j</sub>*k + r<sub>j</sub> || s<sub>j</sub>*(i - r<sub>j</sub>)/q<sub>j</sub> + t<sub>j</sub>   || t<sub>j</sub>, ... || t<sub>j</sub> mod s<sub>j</sub>  ||
|-
|}


<dbat	xmlns   ="http://www.teherba.org/2007/dbat"
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