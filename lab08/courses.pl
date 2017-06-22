#!/usr/bin/perl -w
%hash = ();
$url = "http://timetable.unsw.edu.au/2016/$ARGV[0]KENS.html";
open F, "wget -q -O- $url|" or die;
while ($line = <F>) {
    if ($line =~ /$ARGV[0]/) {
	@words = split /\"/, $line;
	$words[3] =~ s/.html//g;
	$hash{$words[3]} = 1;
    }
}
foreach $x (sort keys %hash) {
    print("$x\n");
}
