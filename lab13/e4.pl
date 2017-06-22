#!/usr/bin/perl -w
%check = ();
$high = 0;
$output = "";
foreach $e (@ARGV) {
    if (! exists $check{$e}) {
	$check{$e} = 1;
    } 
    else {
	$check{$e} += 1;
    }
    if ($high lt $check{$e}) {
	$high = $check{$e};
	$output = $e;
    }
}

print "$output\n";
