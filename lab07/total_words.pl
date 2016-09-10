#!/usr/bin/perl -w
$count = 0;
@file = <STDIN>;
foreach $l (@file) {
    $l =~ s/'s/ s/g;
    $l =~ s/[^a-zA-Z]/ /g;
    @line = split/\s+/, $l;
    foreach $w (@line){
	if ($w ne "") {
	    $count++;
	}
    }
}
if ($count > 1) {
    print("$count words\n");
}
else {
    print("$count word\n");
}
