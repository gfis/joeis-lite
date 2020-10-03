#!perl

# Generate the data tables for McKayThompsonSequence.java
# @(#) $Id$
# 2020-10-01, Georg Fischer
 
# Derived from <code>moonshine.py</code> of
# David A. Madore <david.madore@ens.fr> - 2007-07-31 - Public Domain
# Cf. https://web.archive.org/web/20130925003421/http://mathforum.org/kb/thread.jspa?forumID=253&threadID=1602206&messageID=5836094 

use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

# This is the list of the 172 conjugacy classes of cyclic subgroups of
# the Monster, in ATLAS notation:
my @classes = (
    "1A", "2A", "2B", "3A", "3B", "3C",
    "4A", "4B", "4C", "4D", "5A", "5B",
    "6A", "6B", "6C", "6D", "6E", "6F", "7A", "7B",
    "8A", "8B", "8C", "8D", "8E", "8F", "9A", "9B",
    "10A", "10B", "10C", "10D", "10E", "11A",
    "12A", "12B", "12C", "12D", "12E", "12F", "12G", "12H", "12I", "12J",
    "13A", "13B", "14A", "14B", "14C", "15A", "15B", "15C", "15D",
    "16A", "16B", "16C", "17A", "18A", "18B", "18C", "18D", "18E", "19A",
    "20A", "20B", "20C", "20D", "20E", "20F", "21A", "21B", "21C", "21D",
    "22A", "22B", "23AB",
    "24A", "24B", "24C", "24D", "24E", "24F", "24G", "24H", "24I", "24J",
    "25A", "26A", "26B", "27A", "27B", "28A", "28B", "28C", "28D", "29A",
    "30A", "30B", "30C", "30D", "30E", "30F", "30G", "31AB",
    "32A", "32B", "33A", "33B", "34A", "35A", "35B",
    "36A", "36B", "36C", "36D", "38A", "39A", "39B", "39CD",
    "40A", "40B", "40CD", "41A", "42A", "42B", "42C", "42D",
    "44AB", "45A", "46AB", "46CD", "47AB",
    "48A", "50A", "51A", "52A", "52B", "54A", "55A",
    "56A", "56BC", "57A", "59AB",
    "60A", "60B", "60C", "60D", "60E", "60F", "62AB", "66A", "66B",
    "68A", "69AB", "70A", "70B", "71AB", "78A", "78BC",
    "84A", "84B", "84C", "87AB", "88AB",
    "92AB", "93AB", "94AB", "95AB",
    "104AB", "105A", "110A", "119AB"
    , "119C" # // last (not used)
    );

# Now the power maps, also from the ATLAS (via the GAP character table library):
my  %clpowers = 
    ( "1A" => ["1A","1A","1A","1A","1A","1A","1A","1A","1A","1A"]
    , "2A" => ["1A","2A","1A","2A","1A","2A","1A","2A","1A","2A"]
    , "2B" => ["1A","2B","1A","2B","1A","2B","1A","2B","1A","2B"]
    , "3A" => ["1A","3A","3A","1A","3A","3A","1A","3A","3A","1A"]
    , "3B" => ["1A","3B","3B","1A","3B","3B","1A","3B","3B","1A"]
    , "3C" => ["1A","3C","3C","1A","3C","3C","1A","3C","3C","1A"]
    , "4A" => ["1A","4A","2B","4A","1A","4A","2B","4A","1A","4A"]
    , "4B" => ["1A","4B","2A","4B","1A","4B","2A","4B","1A","4B"]
    , "4C" => ["1A","4C","2B","4C","1A","4C","2B","4C","1A","4C"]
    , "4D" => ["1A","4D","2B","4D","1A","4D","2B","4D","1A","4D"]
    , "5A" => ["1A","5A","5A","5A","5A","1A","5A","5A","5A","5A"]
    , "5B" => ["1A","5B","5B","5B","5B","1A","5B","5B","5B","5B"]
    , "6A" => ["1A","6A","3A","2A","3A","6A","1A","6A","3A","2A"]
    , "6B" => ["1A","6B","3B","2B","3B","6B","1A","6B","3B","2B"]
    , "6C" => ["1A","6C","3A","2B","3A","6C","1A","6C","3A","2B"]
    , "6D" => ["1A","6D","3B","2A","3B","6D","1A","6D","3B","2A"]
    , "6E" => ["1A","6E","3B","2B","3B","6E","1A","6E","3B","2B"]
    , "6F" => ["1A","6F","3C","2B","3C","6F","1A","6F","3C","2B"]
    , "7A" => ["1A","7A","7A","7A","7A","7A","7A","1A","7A","7A"]
    , "7B" => ["1A","7B","7B","7B","7B","7B","7B","1A","7B","7B"]
    , "8A" => ["1A","8A","4C","8A","2B","8A","4C","8A","1A","8A"]
    , "8B" => ["1A","8B","4A","8B","2B","8B","4A","8B","1A","8B"]
    , "8C" => ["1A","8C","4B","8C","2A","8C","4B","8C","1A","8C"]
    , "8D" => ["1A","8D","4C","8D","2B","8D","4C","8D","1A","8D"]
    , "8E" => ["1A","8E","4C","8E","2B","8E","4C","8E","1A","8E"]
    , "8F" => ["1A","8F","4D","8F","2B","8F","4D","8F","1A","8F"]
    , "9A" => ["1A","9A","9A","3B","9A","9A","3B","9A","9A","1A"]
    , "9B" => ["1A","9B","9B","3B","9B","9B","3B","9B","9B","1A"]
    , "10A" => ["1A","10A","5A","10A","5A","2A","5A","10A","5A","10A"]
    , "10B" => ["1A","10B","5A","10B","5A","2B","5A","10B","5A","10B"]
    , "10C" => ["1A","10C","5B","10C","5B","2A","5B","10C","5B","10C"]
    , "10D" => ["1A","10D","5B","10D","5B","2B","5B","10D","5B","10D"]
    , "10E" => ["1A","10E","5B","10E","5B","2B","5B","10E","5B","10E"]
    , "11A" => ["1A","11A","11A","11A","11A","11A","11A","11A","11A","11A"]
    , "12A" => ["1A","12A","6C","4A","3A","12A","2B","12A","3A","4A"]
    , "12B" => ["1A","12B","6E","4A","3B","12B","2B","12B","3B","4A"]
    , "12C" => ["1A","12C","6A","4B","3A","12C","2A","12C","3A","4B"]
    , "12D" => ["1A","12D","6F","4A","3C","12D","2B","12D","3C","4A"]
    , "12E" => ["1A","12E","6C","4C","3A","12E","2B","12E","3A","4C"]
    , "12F" => ["1A","12F","6B","4D","3B","12F","2B","12F","3B","4D"]
    , "12G" => ["1A","12G","6D","4B","3B","12G","2A","12G","3B","4B"]
    , "12H" => ["1A","12H","6E","4C","3B","12H","2B","12H","3B","4C"]
    , "12I" => ["1A","12I","6E","4C","3B","12I","2B","12I","3B","4C"]
    , "12J" => ["1A","12J","6F","4D","3C","12J","2B","12J","3C","4D"]
    , "13A" => ["1A","13A","13A","13A","13A","13A","13A","13A","13A","13A"]
    , "13B" => ["1A","13B","13B","13B","13B","13B","13B","13B","13B","13B"]
    , "14A" => ["1A","14A","7A","14A","7A","14A","7A","2A","7A","14A"]
    , "14B" => ["1A","14B","7A","14B","7A","14B","7A","2B","7A","14B"]
    , "14C" => ["1A","14C","7B","14C","7B","14C","7B","2B","7B","14C"]
    , "15A" => ["1A","15A","15A","5A","15A","3A","5A","15A","15A","5A"]
    , "15B" => ["1A","15B","15B","5A","15B","3B","5A","15B","15B","5A"]
    , "15C" => ["1A","15C","15C","5B","15C","3B","5B","15C","15C","5B"]
    , "15D" => ["1A","15D","15D","5B","15D","3C","5B","15D","15D","5B"]
    , "16A" => ["1A","16A","8A","16A","4C","16A","8A","16A","2B","16A"]
    , "16B" => ["1A","16B","8E","16B","4C","16B","8E","16B","2B","16B"]
    , "16C" => ["1A","16C","8E","16C","4C","16C","8E","16C","2B","16C"]
    , "17A" => ["1A","17A","17A","17A","17A","17A","17A","17A","17A","17A"]
    , "18A" => ["1A","18A","9B","6D","9B","18A","3B","18A","9B","2A"]
    , "18B" => ["1A","18B","9A","6D","9A","18B","3B","18B","9A","2A"]
    , "18C" => ["1A","18C","9A","6E","9A","18C","3B","18C","9A","2B"]
    , "18D" => ["1A","18D","9B","6E","9B","18D","3B","18D","9B","2B"]
    , "18E" => ["1A","18E","9B","6E","9B","18E","3B","18E","9B","2B"]
    , "19A" => ["1A","19A","19A","19A","19A","19A","19A","19A","19A","19A"]
    , "20A" => ["1A","20A","10B","20A","5A","4A","10B","20A","5A","20A"]
    , "20B" => ["1A","20B","10A","20B","5A","4B","10A","20B","5A","20B"]
    , "20C" => ["1A","20C","10E","20C","5B","4A","10E","20C","5B","20C"]
    , "20D" => ["1A","20D","10B","20D","5A","4D","10B","20D","5A","20D"]
    , "20E" => ["1A","20E","10D","20E","5B","4D","10D","20E","5B","20E"]
    , "20F" => ["1A","20F","10E","20F","5B","4C","10E","20F","5B","20F"]
    , "21A" => ["1A","21A","21A","7A","21A","21A","7A","3A","21A","7A"]
    , "21B" => ["1A","21B","21B","7B","21B","21B","7B","3A","21B","7B"]
    , "21C" => ["1A","21C","21C","7A","21C","21C","7A","3C","21C","7A"]
    , "21D" => ["1A","21D","21D","7B","21D","21D","7B","3B","21D","7B"]
    , "22A" => ["1A","22A","11A","22A","11A","22A","11A","22A","11A","22A"]
    , "22B" => ["1A","22B","11A","22B","11A","22B","11A","22B","11A","22B"]
    , "23A" => ["1A","23AB","23AB","23AB","23AB","23AB","23AB","23AB","23AB","23AB"]
    , "23B" => ["1A","23AB","23AB","23AB","23AB","23AB","23AB","23AB","23AB","23AB"]
    , "24A" => ["1A","24A","12A","8B","6C","24A","4A","24A","3A","8B"]
    , "24B" => ["1A","24B","12E","8A","6C","24B","4C","24B","3A","8A"]
    , "24C" => ["1A","24C","12I","8A","6E","24C","4C","24C","3B","8A"]
    , "24D" => ["1A","24D","12E","8D","6C","24D","4C","24D","3A","8D"]
    , "24E" => ["1A","24E","12D","8B","6F","24E","4A","24E","3C","8B"]
    , "24F" => ["1A","24F","12F","8F","6B","24F","4D","24F","3B","8F"]
    , "24G" => ["1A","24G","12G","8C","6D","24G","4B","24G","3B","8C"]
    , "24H" => ["1A","24H","12H","8D","6E","24H","4C","24H","3B","8D"]
    , "24I" => ["1A","24I","12I","8E","6E","24I","4C","24I","3B","8E"]
    , "24J" => ["1A","24J","12J","8F","6F","24J","4D","24J","3C","8F"]
    , "25A" => ["1A","25A","25A","25A","25A","5B","25A","25A","25A","25A"]
    , "26A" => ["1A","26A","13A","26A","13A","26A","13A","26A","13A","26A"]
    , "26B" => ["1A","26B","13B","26B","13B","26B","13B","26B","13B","26B"]
    , "27A" => ["1A","27A","27A","9B","27A","27A","9B","27A","27A","3B"]
    , "27B" => ["1A","27B","27B","9B","27B","27B","9B","27B","27B","3B"]
    , "28A" => ["1A","28A","14A","28A","7A","28A","14A","4B","7A","28A"]
    , "28B" => ["1A","28B","14B","28B","7A","28B","14B","4A","7A","28B"]
    , "28C" => ["1A","28C","14B","28C","7A","28C","14B","4C","7A","28C"]
    , "28D" => ["1A","28D","14C","28D","7B","28D","14C","4D","7B","28D"]
    , "29A" => ["1A","29A","29A","29A","29A","29A","29A","29A","29A","29A"]
    , "30A" => ["1A","30A","15C","10D","15C","6B","5B","30A","15C","10D"]
    , "30B" => ["1A","30B","15A","10A","15A","6A","5A","30B","15A","10A"]
    , "30C" => ["1A","30C","15A","10B","15A","6C","5A","30C","15A","10B"]
    , "30D" => ["1A","30D","15B","10B","15B","6B","5A","30D","15B","10B"]
    , "30E" => ["1A","30E","15D","10D","15D","6F","5B","30E","15D","10D"]
    , "30F" => ["1A","30F","15C","10C","15C","6D","5B","30F","15C","10C"]
    , "30G" => ["1A","30G","15C","10E","15C","6E","5B","30G","15C","10E"]
    , "31A" => ["1A","31AB","31AB","31AB","31AB","31AB","31AB","31AB","31AB","31AB"]
    , "31B" => ["1A","31AB","31AB","31AB","31AB","31AB","31AB","31AB","31AB","31AB"]
    , "32A" => ["1A","32A","16B","32A","8E","32A","16B","32A","4C","32A"]
    , "32B" => ["1A","32B","16C","32B","8E","32B","16C","32B","4C","32B"]
    , "33A" => ["1A","33A","33A","11A","33A","33A","11A","33A","33A","11A"]
    , "33B" => ["1A","33B","33B","11A","33B","33B","11A","33B","33B","11A"]
    , "34A" => ["1A","34A","17A","34A","17A","34A","17A","34A","17A","34A"]
    , "35A" => ["1A","35A","35A","35A","35A","7A","35A","5A","35A","35A"]
    , "35B" => ["1A","35B","35B","35B","35B","7B","35B","5B","35B","35B"]
    , "36A" => ["1A","36A","18C","12B","9A","36A","6E","36A","9A","4A"]
    , "36B" => ["1A","36B","18D","12B","9B","36B","6E","36B","9B","4A"]
    , "36C" => ["1A","36C","18B","12G","9A","36C","6D","36C","9A","4B"]
    , "36D" => ["1A","36D","18D","12I","9B","36D","6E","36D","9B","4C"]
    , "38A" => ["1A","38A","19A","38A","19A","38A","19A","38A","19A","38A"]
    , "39A" => ["1A","39A","39A","13A","39A","39A","13A","39A","39A","13A"]
    , "39B" => ["1A","39B","39B","13A","39B","39B","13A","39B","39B","13A"]
    , "39C" => ["1A","39CD","39CD","13B","39CD","39CD","13B","39CD","39CD","13B"]
    , "39D" => ["1A","39CD","39CD","13B","39CD","39CD","13B","39CD","39CD","13B"]
    , "40A" => ["1A","40A","20B","40A","10A","8C","20B","40A","5A","40A"]
    , "40B" => ["1A","40B","20A","40B","10B","8B","20A","40B","5A","40B"]
    , "40C" => ["1A","40CD","20F","40CD","10E","8D","20F","40CD","5B","40CD"]
    , "40D" => ["1A","40CD","20F","40CD","10E","8D","20F","40CD","5B","40CD"]
    , "41A" => ["1A","41A","41A","41A","41A","41A","41A","41A","41A","41A"]
    , "42A" => ["1A","42A","21A","14A","21A","42A","7A","6A","21A","14A"]
    , "42B" => ["1A","42B","21D","14C","21D","42B","7B","6B","21D","14C"]
    , "42C" => ["1A","42C","21C","14B","21C","42C","7A","6F","21C","14B"]
    , "42D" => ["1A","42D","21B","14C","21B","42D","7B","6C","21B","14C"]
    , "44A" => ["1A","44AB","22B","44AB","11A","44AB","22B","44AB","11A","44AB"]
    , "44B" => ["1A","44AB","22B","44AB","11A","44AB","22B","44AB","11A","44AB"]
    , "45A" => ["1A","45A","45A","15B","45A","9A","15B","45A","45A","5A"]
    , "46A" => ["1A","46AB","23AB","46AB","23AB","46AB","23AB","46AB","23AB","46AB"]
    , "46B" => ["1A","46AB","23AB","46AB","23AB","46AB","23AB","46AB","23AB","46AB"]
    , "46C" => ["1A","46CD","23AB","46CD","23AB","46CD","23AB","46CD","23AB","46CD"]
    , "46D" => ["1A","46CD","23AB","46CD","23AB","46CD","23AB","46CD","23AB","46CD"]
    , "47A" => ["1A","47AB","47AB","47AB","47AB","47AB","47AB","47AB","47AB","47AB"]
    , "47B" => ["1A","47AB","47AB","47AB","47AB","47AB","47AB","47AB","47AB","47AB"]
    , "48A" => ["1A","48A","24B","16A","12E","48A","8A","48A","6C","16A"]
    , "50A" => ["1A","50A","25A","50A","25A","10C","25A","50A","25A","50A"]
    , "51A" => ["1A","51A","51A","17A","51A","51A","17A","51A","51A","17A"]
    , "52A" => ["1A","52A","26A","52A","13A","52A","26A","52A","13A","52A"]
    , "52B" => ["1A","52B","26B","52B","13B","52B","26B","52B","13B","52B"]
    , "54A" => ["1A","54A","27A","18A","27A","54A","9B","54A","27A","6D"]
    , "55A" => ["1A","55A","55A","55A","55A","11A","55A","55A","55A","55A"]
    , "56A" => ["1A","56A","28C","56A","14B","56A","28C","8A","7A","56A"]
    , "56B" => ["1A","56BC","28D","56BC","14C","56BC","28D","8F","7B","56BC"]
    , "56C" => ["1A","56BC","28D","56BC","14C","56BC","28D","8F","7B","56BC"]
    , "57A" => ["1A","57A","57A","19A","57A","57A","19A","57A","57A","19A"]
    , "59A" => ["1A","59AB","59AB","59AB","59AB","59AB","59AB","59AB","59AB","59AB"]
    , "59B" => ["1A","59AB","59AB","59AB","59AB","59AB","59AB","59AB","59AB","59AB"]
    , "60A" => ["1A","60A","30B","20B","15A","12C","10A","60A","15A","20B"]
    , "60B" => ["1A","60B","30C","20A","15A","12A","10B","60B","15A","20A"]
    , "60C" => ["1A","60C","30G","20C","15C","12B","10E","60C","15C","20C"]
    , "60D" => ["1A","60D","30G","20F","15C","12H","10E","60D","15C","20F"]
    , "60E" => ["1A","60E","30D","20D","15B","12F","10B","60E","15B","20D"]
    , "60F" => ["1A","60F","30E","20E","15D","12J","10D","60F","15D","20E"]
    , "62A" => ["1A","62AB","31AB","62AB","31AB","62AB","31AB","62AB","31AB","62AB"]
    , "62B" => ["1A","62AB","31AB","62AB","31AB","62AB","31AB","62AB","31AB","62AB"]
    , "66A" => ["1A","66A","33B","22A","33B","66A","11A","66A","33B","22A"]
    , "66B" => ["1A","66B","33A","22B","33A","66B","11A","66B","33A","22B"]
    , "68A" => ["1A","68A","34A","68A","17A","68A","34A","68A","17A","68A"]
    , "69A" => ["1A","69AB","69AB","23AB","69AB","69AB","23AB","69AB","69AB","23AB"]
    , "69B" => ["1A","69AB","69AB","23AB","69AB","69AB","23AB","69AB","69AB","23AB"]
    , "70A" => ["1A","70A","35A","70A","35A","14A","35A","10A","35A","70A"]
    , "70B" => ["1A","70B","35B","70B","35B","14C","35B","10D","35B","70B"]
    , "71A" => ["1A","71AB","71AB","71AB","71AB","71AB","71AB","71AB","71AB","71AB"]
    , "71B" => ["1A","71AB","71AB","71AB","71AB","71AB","71AB","71AB","71AB","71AB"]
    , "78A" => ["1A","78A","39A","26A","39A","78A","13A","78A","39A","26A"]
    , "78B" => ["1A","78BC","39CD","26B","39CD","78BC","13B","78BC","39CD","26B"]
    , "78C" => ["1A","78BC","39CD","26B","39CD","78BC","13B","78BC","39CD","26B"]
    , "84A" => ["1A","84A","42A","28A","21A","84A","14A","12C","21A","28A"]
    , "84B" => ["1A","84B","42B","28D","21D","84B","14C","12F","21D","28D"]
    , "84C" => ["1A","84C","42C","28B","21C","84C","14B","12D","21C","28B"]
    , "87AB" => ["1A","87AB","87AB","29A","87AB","87AB","29A","87AB","87AB","29A"]
    , "87AB" => ["1A","87AB","87AB","29A","87AB","87AB","29A","87AB","87AB","29A"]
    , "88AB" => ["1A","88AB","44AB","88AB","22B","88AB","44AB","88AB","11A","88AB"]
    , "88AB" => ["1A","88AB","44AB","88AB","22B","88AB","44AB","88AB","11A","88AB"]
    , "92AB" => ["1A","92AB","46AB","92AB","23AB","92AB","46AB","92AB","23AB","92AB"]
    , "92AB" => ["1A","92AB","46AB","92AB","23AB","92AB","46AB","92AB","23AB","92AB"]
    , "93AB" => ["1A","93AB","93AB","31AB","93AB","93AB","31AB","93AB","93AB","31AB"]
    , "93AB" => ["1A","93AB","93AB","31AB","93AB","93AB","31AB","93AB","93AB","31AB"]
    , "94AB" => ["1A","94AB","47AB","94AB","47AB","94AB","47AB","94AB","47AB","94AB"]
    , "94AB" => ["1A","94AB","47AB","94AB","47AB","94AB","47AB","94AB","47AB","94AB"]
    , "95AB" => ["1A","95AB","95AB","95AB","95AB","19A","95AB","95AB","95AB","95AB"]
    , "95AB" => ["1A","95AB","95AB","95AB","95AB","19A","95AB","95AB","95AB","95AB"]
    , "104A" => ["1A","104AB","52A","104AB","26A","104AB","52A","104AB","13A","104AB"]
    , "104B" => ["1A","104AB","52A","104AB","26A","104AB","52A","104AB","13A","104AB"]
    , "105A" => ["1A","105A","105A","35A","105A","21A","35A","15A","105A","35A"]
    , "110A" => ["1A","110A","55A","110A","55A","22A","55A","110A","55A","110A"]
    , "119A" => ["1A","119AB","119AB","119AB","119AB","119AB","119AB","17A","119AB","119AB"]
    , "119B" => ["1A","119AB","119AB","119AB","119AB","119AB","119AB","17A","119AB","119AB"]
    , "119C" => ["119C"] # last (not used)
    );

# We bootstrap with a few known coefficients:
my  %bootcoefs = ();
    $bootcoefs{"1A"} = "0, 196884, 21493760L, 864299970L, 20245856256L, 333202640600L";
    $bootcoefs{"2A"} = "0, 4372, 96256, 1240002L, 10698752L, 74428120L";
    $bootcoefs{"2B"} = "0, 276, -2048, 11202, -49152, 184024";
    $bootcoefs{"3A"} = "0, 783, 8672, 65367, 371520, 1741655";
    $bootcoefs{"3B"} = "0, 54, -76, -243, 1188, -1384";
    $bootcoefs{"3C"} = "0, 0, 248, 0, 0, 4124";
    $bootcoefs{"4A"} = "0, 276, 2048, 11202, 49152, 184024";
    $bootcoefs{"4B"} = "0, 52, 0, 834, 0, 4760";
    $bootcoefs{"4C"} = "0, 20, 0, -62, 0, 216"; 
    $bootcoefs{"4D"} = "0, -12, 0, 66, 0, -232";
    $bootcoefs{"5A"} = "0, 134, 760, 3345, 12256, 39350";
    $bootcoefs{"5B"} = "0, 9, 10, -30, 6, -25";
    $bootcoefs{"6A"} = "0, 79, 352, 1431, 4160, 13015";
    $bootcoefs{"6B"} = "0, 78, 364, 1365, 4380, 12520";
    $bootcoefs{"6C"} = "0, 15, -32, 87, -192, 343";
    $bootcoefs{"6D"} = "0, -2, 28, -27, -52, 136";
    $bootcoefs{"6E"} = "0, 6, 4, -3, -12, -8"; 
    $bootcoefs{"6F"} = "0, 0, -8, 0, 0, 28";
    $bootcoefs{"7A"} = "0, 51, 204, 681, 1956, 5135";
    $bootcoefs{"7B"} = "0, 2, 8, -5, -4, -10";
    $bootcoefs{"8A"} = "0, 36, 128, 386, 1024, 2488";
    $bootcoefs{"8B"} = "0, 12, 0, 66, 0, 232"; 
    $bootcoefs{"8C"} = "0, 0, 0, 26, 0, 0";
    $bootcoefs{"8D"} = "0, -4, 0, 2, 0, 8"; 
    $bootcoefs{"8E"} = "0, 4, 0, 2, 0, -8";
    $bootcoefs{"8F"} = "0, 0, 0, -6, 0, 0";
    $bootcoefs{"9A"} = "0, 27, 86, 243, 594, 1370"; 
    $bootcoefs{"9B"} = "0, 0, 5, 0, 0, -7";
    $bootcoefs{"10A"} = "0, 22, 56, 177, 352, 870"; 
    $bootcoefs{"10B"} = "0, 6, -8, 17, -32, 54";
    $bootcoefs{"10C"} = "0, -3, 6, 2, 2, -5"; 
    $bootcoefs{"10D"} = "0, 21, 62, 162, 378, 819";
    $bootcoefs{"10E"} = "0, 1, 2, 2, -2, -1"; 
    $bootcoefs{"11A"} = "0, 17, 46, 116, 252, 533";
    $bootcoefs{"12A"} = "0, 15, 32, 87, 192, 343"; 
    $bootcoefs{"12B"} = "0, 6, -4, -3, 12, -8";
    $bootcoefs{"12C"} = "0, 7, 0, 15, 0, 71"; 
    $bootcoefs{"12D"} = "0, 0, 8, 0, 0, 28";
    $bootcoefs{"12E"} = "0, -1, 0, 7, 0, -9"; 
    $bootcoefs{"12F"} = "0, 6, 0, 21, 0, 56";
    $bootcoefs{"12G"} = "0, -2, 0, -3, 0, 8"; 
    $bootcoefs{"12H"} = "0, 14, 36, 85, 180, 360";
    $bootcoefs{"12I"} = "0, 2, 0, 1, 0, 0"; 
    $bootcoefs{"12J"} = "0, 0, 0, 0, 0, -4";
    $bootcoefs{"13A"} = "0, 12, 28, 66, 132, 258"; 
    $bootcoefs{"13B"} = "0, -1, 2, 1, 2, -2";
    $bootcoefs{"14A"} = "0, 11, 20, 57, 92, 207"; 
    $bootcoefs{"14B"} = "0, 3, -4, 9, -12, 15";
    $bootcoefs{"14C"} = "0, 10, 24, 51, 100, 190";
    $bootcoefs{"15A"} = "0, 8, 22, 42, 70, 155"; 
    $bootcoefs{"15B"} = "0, -1, 4, -3, -2, 11";
    $bootcoefs{"15C"} = "0, 9, 19, 42, 78, 146"; 
    $bootcoefs{"15D"} = "0, 0, -2, 0, 0, -1";
    $bootcoefs{"16A"} = "0, 4, 0, 10, 0, 24"; 
    $bootcoefs{"16B"} = "0, 0, 0, 2, 0, 0";
    $bootcoefs{"16C"} = "0, 8, 16, 34, 64, 112"; 
    $bootcoefs{"17A"} = "0, 7, 14, 29, 50, 92";
    $bootcoefs{"18A"} = "0, -2, 1, 0, 2, 1"; 
    $bootcoefs{"18B"} = "0, 7, 10, 27, 38, 82";
    $bootcoefs{"18C"} = "0, 3, -2, 3, -6, 10"; 
    $bootcoefs{"18D"} = "0, 0, 1, 0, 0, 1";
    $bootcoefs{"18E"} = "0, 6, 13, 24, 42, 73"; 
    $bootcoefs{"19A"} = "0, 6, 10, 21, 36, 61";
    $bootcoefs{"20A"} = "0, 6, 8, 17, 32, 54"; 
    $bootcoefs{"20B"} = "0, 2, 0, 9, 0, 10";
    $bootcoefs{"20C"} = "0, 1, -2, 2, 2, -1"; 
    $bootcoefs{"20D"} = "0, -2, 0, 1, 0, -2";
    $bootcoefs{"20E"} = "0, 3, 0, 6, 0, 13"; 
    $bootcoefs{"20F"} = "0, 5, 10, 18, 30, 51";
    $bootcoefs{"21A"} = "0, 6, 6, 15, 30, 41"; 
    $bootcoefs{"21B"} = "0, -1, -1, 1, 2, -1";
    $bootcoefs{"21C"} = "0, 0, 3, 0, 0, 8"; 
    $bootcoefs{"21D"} = "0, 5, 8, 16, 26, 44";
    $bootcoefs{"22A"} = "0, 5, 6, 16, 20, 41";
    $bootcoefs{"22B"} = "0, 1, -2, 4, -4, 5";
    $bootcoefs{"23A"} = "0, 4, 7, 13, 19, 33";
    $bootcoefs{"23B"} = "0, 4, 7, 13, 19, 33";
    $bootcoefs{"24A"} = "0, 3, 0, 3, 0, 7";
    $bootcoefs{"24B"} = "0, 3, 8, 11, 16, 31";
    $bootcoefs{"24C"} = "0, 0, 2, -1, -2, 4";
    $bootcoefs{"24D"} = "0, -1, 0, -1, 0, -1";
    $bootcoefs{"24E"} = "0, 0, 0, 0, 0, 4";
    $bootcoefs{"24F"} = "0, 0, 0, 3, 0, 0";
    $bootcoefs{"24G"} = "0, 0, 0, -1, 0, 0";
    $bootcoefs{"24H"} = "0, 2, 0, 5, 0, 8";
    $bootcoefs{"24I"} = "0, 4, 6, 11, 18, 28";
    $bootcoefs{"24J"} = "0, 0, 0, 0, 0, 0";
    $bootcoefs{"25A"} = "0, 4, 5, 10, 16, 25";
    $bootcoefs{"26A"} = "0, 4, 4, 10, 12, 26";
    $bootcoefs{"26B"} = "0, 3, 6, 9, 14, 22";
    $bootcoefs{"27A"} = "0, 3, 5, 9, 12, 20";
    $bootcoefs{"27B"} = "0, 3, 5, 9, 12, 20";
    $bootcoefs{"28A"} = "0, 3, 0, 1, 0, 7";
    $bootcoefs{"28B"} = "0, 3, 4, 9, 12, 15";
    $bootcoefs{"28C"} = "0, -1, 0, 1, 0, -1";
    $bootcoefs{"28D"} = "0, 2, 0, 3, 0, 6";
    $bootcoefs{"29A"} = "0, 3, 4, 7, 10, 17";
    $bootcoefs{"30A"} = "0, 3, -1, 0, 0, 0";
    $bootcoefs{"30B"} = "0, 4, 2, 6, 10, 15";
    $bootcoefs{"30C"} = "0, 0, -2, 2, -2, 3";
    $bootcoefs{"30D"} = "0, 3, 4, 5, 10, 15";
    $bootcoefs{"30E"} = "0, 0, 2, 0, 0, 3";
    $bootcoefs{"30F"} = "0, 3, 3, 8, 8, 16";
    $bootcoefs{"30G"} = "0, 1, -1, 2, -2, 2";
    $bootcoefs{"31A"} = "0, 3, 3, 6, 9, 13";
    $bootcoefs{"31B"} = "0, 3, 3, 6, 9, 13";
    $bootcoefs{"32A"} = "0, 2, 4, 6, 8, 12";
    $bootcoefs{"32B"} = "0, 2, 0, 2, 0, 4";
    $bootcoefs{"33A"} = "0, -1, 1, -1, 0, 2";
    $bootcoefs{"33B"} = "0, 2, 4, 5, 6, 14";
    $bootcoefs{"34A"} = "0, 3, 2, 5, 6, 12";
    $bootcoefs{"35A"} = "0, 1, 4, 6, 6, 10";
    $bootcoefs{"35B"} = "0, 2, 3, 5, 6, 10";
    $bootcoefs{"36A"} = "0, 3, 2, 3, 6, 10";
    $bootcoefs{"36B"} = "0, 0, -1, 0, 0, 1";
    $bootcoefs{"36C"} = "0, 1, 0, 3, 0, 2";
    $bootcoefs{"36D"} = "0, 2, 3, 4, 6, 9";
    $bootcoefs{"38A"} = "0, 2, 2, 5, 4, 9";
    $bootcoefs{"39A"} = "0, 3, 1, 3, 6, 6";
    $bootcoefs{"39B"} = "0, 0, 1, 0, 0, 3";
    $bootcoefs{"39C"} = "0, 2, 2, 4, 5, 7";
    $bootcoefs{"39D"} = "0, 2, 2, 4, 5, 7";
    $bootcoefs{"40A"} = "0, 0, 0, 1, 0, 0";
    $bootcoefs{"40B"} = "0, 2, 0, 1, 0, 2";
    $bootcoefs{"40C"} = "0, 1, 0, 2, 0, 3";
    $bootcoefs{"40D"} = "0, 1, 0, 2, 0, 3";
    $bootcoefs{"41A"} = "0, 2, 2, 3, 4, 7";
    $bootcoefs{"42A"} = "0, 2, 2, 3, 2, 9";
    $bootcoefs{"42B"} = "0, 1, 0, 0, -2, 4";
    $bootcoefs{"42C"} = "0, 0, -1, 0, 0, 0";
    $bootcoefs{"42D"} = "0, 1, 3, 3, 4, 7";
    $bootcoefs{"44A"} = "0, 1, 2, 4, 4, 5";
    $bootcoefs{"44B"} = "0, 1, 2, 4, 4, 5";
    $bootcoefs{"45A"} = "0, 2, 1, 3, 4, 5";
    $bootcoefs{"46A"} = "0, 0, -1, 1, -1, 1";
    $bootcoefs{"46B"} = "0, 0, -1, 1, -1, 1";
    $bootcoefs{"46C"} = "0, 2, 1, 3, 3, 5";
    $bootcoefs{"46D"} = "0, 2, 1, 3, 3, 5";
    $bootcoefs{"47A"} = "0, 1, 2, 3, 3, 5";
    $bootcoefs{"47B"} = "0, 1, 2, 3, 3, 5";
    $bootcoefs{"48A"} = "0, 1, 0, 1, 0, 3";
    $bootcoefs{"50A"} = "0, 2, 1, 2, 2, 5";
    $bootcoefs{"51A"} = "0, 1, 2, 2, 2, 5";
    $bootcoefs{"52A"} = "0, 0, 0, 2, 0, 2";
    $bootcoefs{"52B"} = "0, 1, 0, 1, 0, 2";
    $bootcoefs{"54A"} = "0, 1, 1, 3, 2, 4";
    $bootcoefs{"55A"} = "0, 2, 1, 1, 2, 3";
    $bootcoefs{"56A"} = "0, 1, 2, 1, 2, 3";
    $bootcoefs{"56B"} = "0, 0, 0, 1, 0, 0";
    $bootcoefs{"56C"} = "0, 0, 0, 1, 0, 0";
    $bootcoefs{"57A"} = "0, 0, 1, 0, 0, 1";
    $bootcoefs{"59A"} = "0, 1, 1, 2, 2, 3";
    $bootcoefs{"59B"} = "0, 1, 1, 2, 2, 3";
    $bootcoefs{"60A"} = "0, 2, 0, 0, 0, 1";
    $bootcoefs{"60B"} = "0, 0, 2, 2, 2, 3";
    $bootcoefs{"60C"} = "0, 1, 1, 2, 2, 2";
    $bootcoefs{"60D"} = "0, -1, 1, 0, 0, 0";
    $bootcoefs{"60E"} = "0, 1, 0, 1, 0, 1";
    $bootcoefs{"60F"} = "0, 0, 0, 0, 0, 1";
    $bootcoefs{"62A"} = "0, 1, 1, 2, 1, 3";
    $bootcoefs{"62B"} = "0, 1, 1, 2, 1, 3";
    $bootcoefs{"66A"} = "0, 2, 0, 1, 2, 2";
    $bootcoefs{"66B"} = "0, 1, 1, 1, 2, 2";
    $bootcoefs{"68A"} = "0, 1, 0, 1, 0, 0";
    $bootcoefs{"69A"} = "0, 1, 1, 1, 1, 3";
    $bootcoefs{"69B"} = "0, 1, 1, 1, 1, 3";
    $bootcoefs{"70A"} = "0, 1, 0, 2, 2, 2";
    $bootcoefs{"70B"} = "0, 0, -1, 1, 0, 0";
    $bootcoefs{"71A"} = "0, 1, 1, 1, 1, 2";
    $bootcoefs{"71B"} = "0, 1, 1, 1, 1, 2";
    $bootcoefs{"78A"} = "0, 1, 1, 1, 0, 2";
    $bootcoefs{"78B"} = "0, 0, 0, 0, -1, 1";
    $bootcoefs{"78C"} = "0, 0, 0, 0, -1, 1";
    $bootcoefs{"84A"} = "0, 0, 0, 1, 0, 1";
    $bootcoefs{"84B"} = "0, -1, 0, 0, 0, 0";
    $bootcoefs{"84C"} = "0, 0, 1, 0, 0, 0";
    $bootcoefs{"87A"} = "0, 0, 1, 1, 1, 2";
    $bootcoefs{"87B"} = "0, 0, 1, 1, 1, 2";
    $bootcoefs{"88A"} = "0, 1, 0, 0, 0, 1";
    $bootcoefs{"88B"} = "0, 1, 0, 0, 0, 1";
    $bootcoefs{"92A"} = "0, 0, 1, 1, 1, 1";
    $bootcoefs{"92B"} = "0, 0, 1, 1, 1, 1";
    $bootcoefs{"93A"} = "0, 0, 0, 0, 0, 1";
    $bootcoefs{"93B"} = "0, 0, 0, 0, 0, 1";
    $bootcoefs{"94A"} = "0, 1, 0, 1, 1, 1";
    $bootcoefs{"94B"} = "0, 1, 0, 1, 1, 1";
    $bootcoefs{"95A"} = "0, 1, 0, 1, 1, 1";
    $bootcoefs{"95B"} = "0, 1, 0, 1, 1, 1";
    $bootcoefs{"104A"} = "0, 0, 0, 0, 0, 0";
    $bootcoefs{"104B"} = "0, 0, 0, 0, 0, 0";
    $bootcoefs{"105A"} = "0, 1, 1, 0, 0, 1";
    $bootcoefs{"110A"} = "0, 0, 1, 1, 0, 1";
    $bootcoefs{"119A"} = "0, 0, 0, 1, 1, 1";
    $bootcoefs{"119B"} = "0, 0, 0, 1, 1, 1";
    $bootcoefs{"119C"} = "29061947"; # last (not used)
#----------------
# @classes, %clpowers, %bootcoefs
my $class;
my $sep;
my $old_code;
my $nl;
#----
if (1) {
    $sep = "    {";
    print <<'GFis';
package irvine.oeis;

/** 
 * Data tables for {@link McKayThompsonSequence}.
 * @author Georg Fischer
 * Derived from <code>moonshine.py</code> of
 * David A. Madore <david.madore@ens.fr> - 2007-07-31 - Public Domain.
 * Cf. <code>https://web.archive.org/web/20130925003421/http://mathforum.org/kb/thread.jspa?forumID=253&threadID=1602206&messageID=5836094</code>
GFis
    print <<"GFis";
 * This class was generated by https://github.com/gfis/joeis-lite/internal/fischer/mckay_tables.pl on $timestamp
 * DO NOT EDIT HERE !
 */
public class McKayThompsonTables {

GFis
}
#----
if (1) {
    $sep = "    {";
    print <<"GFis";
  /** Valid class codes */
  public static final int[] sValidClasses = new int[] 
GFis
    my $old_hex = "01";
    foreach $class (@classes) {
        foreach my $code (&tohexa($class)) {
            if (substr($code, 2, 2) ne $old_hex) {
                $old_hex = substr($code, 2, 2);
                print "\n    ";
            }
            print "$sep $code /*" . sprintf("%-4s", &tostr($code)) . "*/";
            $sep = ",";
        } # foreach $code
    } # foreach $class
    print <<'GFis';

    }; // sValidClasses
GFis
}
#----
if (1) {
    my %sortpow = ();
    foreach $class (keys(%clpowers)) {
        foreach my $code (&tohexa($class)) {
            $sortpow{$code} = $clpowers{$class};
        }
    } # foreach $class

    print <<"GFis";
    
  /** Class powers */
  public static final int[][] sClassPowers = new int[][] 
GFis
    $sep = "    {";
    $nl = 0; # whether a newline was output
    $old_code = 0;
    foreach my $code (sort(keys(%sortpow))) {
        while (sprintf("%03x", $old_code) lt substr($code, 2)) {
            print "$sep null";
            $sep = ",";
            $old_code ++;
            if ($old_code % 16 == 0) {
                print "\n    ";
                $nl = 1;
            }
        }
        if ($nl == 0) {
            print "\n    ";
        }
        $nl = 0;
        $old_code = hex(substr($code, 2)) + 1;
        print "$sep /* $code */ new int[] { ";
        print join(", ", map {
        	&tohexa($_)
        	} @{ $sortpow{$code} }); 
        print " }";
    } # foreach $code
    print <<'GFis';

    }; // sClassPowers
GFis
}
#----
if (1) {
    my %sortboot = ();
    foreach $class (keys(%bootcoefs)) {
        foreach my $code (&tohexa($class)) {
            $sortboot{$code} = $bootcoefs{$class};
        }
    } # foreach $class

    print <<"GFis";
    
  /** Boot coefficients */
  public static final long[][] sBootCoeffs = new long[][] 
GFis
    $sep = "    {";
    $nl = 0; # whether a newline was output
    $old_code = 0;
    foreach my $code (sort(keys(%sortboot))) {
        while (sprintf("%03x", $old_code) lt substr($code, 2)) {
            print "$sep null";
            $sep = ",";
            $old_code ++;
            if ($old_code % 16 == 0) {
                print "\n    ";
                $nl = 1;
            }
        }
        if ($nl == 0) {
            print "\n    ";
        }
        $nl = 0;
        $old_code = hex(substr($code, 2)) + 1;
        print "$sep /* $code */ new long[] { " . $sortboot{$code} . " }";
    } # foreach $code
    print <<'GFis';

    }; // sBootCoeffs
GFis
}
#----
print <<'GFis';

  /**
   * Test method
   */
  public static void main(String[] args) {
    System.out.println("last valid class code: " + String.format("0x%03x", sValidClasses[sValidClasses.length - 1]));
    final int[] lastPow = sClassPowers[sClassPowers.length - 1];
    System.out.println("last class power:      " + String.format("%d", lastPow[0] ) + " @" + String.format("0x%x", sClassPowers.length - 1));
    final long[] lastBoot = sBootCoeffs[sBootCoeffs.length - 1];
    System.out.println("last boot coefficent:  " + String.format("%d", lastBoot[0]) + " @" + String.format("0x%x", sBootCoeffs .length - 1));
  } // main
  
} // McKayThompsonTables
GFis
#--------
sub tohexa { # convert a class name with uppercase letters into a list of int hex constants
    my ($class) = @_;
    my @result = ();
    $class =~ m{(\d+)([A-Z]+)};
    my $classno = $1;
    my $alpha   = $2;
    if (! defined($alpha)) {
    	print STDERR "# class $class has  no letters\n";
    	$alpha = 'A';
    }
    my @letters = split(//, $2);
    foreach my $letter (@letters) {
        my $code = ord($letter) - ord('A');
        push(@result, sprintf("0x%1x%1d%1x", $classno / 10, $classno % 10, $code));
    } # foreach $letter
    return @result;
} # tohexa
#--------
sub tostr { # convert a hex constant into a class name with uppercase letter
    my ($code) = @_;
    return hex(substr($code, 2, 1)) . substr($code, 3, 1) . chr(ord('A') + hex(substr($code, 4, 1)));
} # tostr
__DATA__

print <<"GFis";

GFis
