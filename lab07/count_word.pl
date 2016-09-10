#!/usr/bin/perl -w
if ($#ARGV != 0){
    print("Please give one word!\n");
    exit(0);
}
$count = 0;
$word = lc($ARGV[0]);
@txt = <STDIN>;
foreach $l (@txt){
    $l =~ s/'s/ s/g;
    $l =~ s/[^a-zA-Z]/ /g;
    @line = split/\s+/, lc($l);
    foreach $w (@line){
	if ($w =~ /^$word$/){
	    $count++;
	}
    }
}
if ($count > 1) {
    print "$word occurred $count times\n";
}
else {
    print "$word occurred $count time\n";
}
