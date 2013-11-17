use IO::Socket;
####server!

$local = IO::Socket::INET->new(
                Proto     => 'tcp',             
                LocalAddr => 'localhost:12345',  
                Reuse     => 1
                ) or die "$!";


$local->listen();       
$local->autoflush(1);   
print "Waiting...\n";

        my $addr;   
        $addr = $local->accept();             
        print   "cnctd from: ", $addr->peerhost();  
        print   " Port: ", $addr->peerport(), "\n";
        my $result;      
        $off=fork();

if($off)
{    
while (<$addr>){       
last if m/^end/gi;   


if($_ eq "\n")                
{
#print "end reached!";
open(hnd,'>/root/awkspy_dir/knock.txt');
print hnd "1\n";
close(hnd);

#open(FIFO,'>/root/sample') or die "nope";
#print FIFO "hello\n";
#close(FIFO);
}

else
{
my $pth= '/root/awkspy_dir/spydata.txt';
open(my $wf,'>>', $pth);
say $wf "$_\n";
close(wf);
}

# then exit loop
#print "Received: $_";# Print received message
#print $addr $_;# Send received message back 
                                         
$result += $_;# Add val to result

}
print "end while\n";

chomp;                 

if (m/^end/gi) {               
                               
                               
                               
                               
my $send = "result=$result";   
print $addr "$send\n";         
print "Result: $send\n";       
}

print "Closed connection\n";                                  
close $addr; 

kill("TERM",$off);
}


else
{
my $sample="0";
my $send=1;
while(1)
{
#my $fakefile = "1\n";
#open my $fh, "<", \$fakefile
#or die "could not open fake file: $!";
#*STDIN = $fh;
#my @b = <STDIN>;
#print "@b";
#open(fd,'/root/awkspy_dir/msd.txt');

#while(<fd>)
#{
#chomp;
#$sample=$_;
#print "file:$sample\n";
#}
#close(fd);


$send=0;#send flag
$sample = `cat /root/awkspy_dir/msd.txt`; chomp($sample);
my $ln=length($sample);

#print "sample:$sample\n";
#my $wcc= `cat /root/awkspy_dir/msd.txt|wc -c`;
#chomp($wcc);
#my $ans = $wcc + 0;
#print "$ans\n";
#>4 if command line!
#print "$ln";

if($ln > 3)
{$a="$sample";
$send=2;#print "$sample";
}

chomp($sample);

if($sample eq "1")
{$a="ps\n";#print "d1d";
$send=1;}

if($sample eq "2")
{$a="pps\n";#print "d2d";
$send=1;}

if($sample eq "3")
{$a="pes\n";
$send=1;}

if($sample eq "4")
{$a="4\n";
$send=1;}

if($sample eq "5")
{$a="5\n";
$send=1;}



if(defined($a))
{
#send only if clicked
if($send == 1)
{
open(fd,'>/root/awkspy_dir/msd.txt'); print fd "0\n"; close(fd);
print $addr $a;  #print "\nsending...$a\n";
}

if($send==2)
{
open(fd,'>/root/awkspy_dir/msd.txt'); print fd "0\n"; close(fd);
print $addr "$a\n";print "\nsending...$a\n";
}
}

}#eo while
}#eo else

=begin
my $what;

while(1)
{
open(fd,'/root/awkspy_dir/msd.txt');

$what = $_;
print "MSD:$what\n";

#if($what  == "1") 
#{
#$sample = "app";
#print "running apps"; print $addr $sample;
#}

#else {
$sample = "noprocess"; print "rest"; print $addr $sample;
#} 


#if($what != "0")
#{
#open(fd2,'>/root/awkspy_dir/msd.txt'); 
#print fd2 "0"; close(fd2); 
#}

print "ins while";
close(fd);
#sleep(2);
}#eo w1


}#eo else

#print "At your service. Waiting...\n";  
# Wait again for next request
=end comment
