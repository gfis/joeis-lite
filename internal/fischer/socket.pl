#!perl
# 2023-04-19, Georg Fischer: HTTP/1.0 and data=args[0]
# to be called with: "perl socket.pl [data]"
use IO::Socket;
my $data = shift(@ARGV) || 'f0124589'; # user data
my $sock = new IO::Socket::INET (
    PeerAddr => '88.198.74.119',
    PeerPort => '80', Proto => 'tcp'); 
# create the socket:
die "Could not create socket: $!\n" unless $sock;
# send the GET request followed by an empty line:
print $sock "GET /cgi-bin/sense2.php?&id=F123\&data=$data HTTP/1.0\r\n";
print $sock "\r\n\r\n";
# optionally print any server response lines
print while <$sock>;
close($sock);
