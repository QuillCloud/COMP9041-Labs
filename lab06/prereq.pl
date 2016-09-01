#!/usr/bin/perl -w
%result = ();
$url = "http://www.handbook.unsw.edu.au/postgraduate/courses/2015/$ARGV[0].html";
open F, "wget -q -O- $url|" or die;
while ($line = <F>) {
    if ($line =~ 'Prerequisite') {
	@x = split /<p>/, $line;
	$x[1] =~ s/Prerequisite: //g;
	$x[1] =~ s/<.+?>//g;
	$x[1] =~ s/[\.\[\]]//g;
	@get = split / /,$x[1];
    }
}
foreach $r (@get) {
    if ($r =~ '^\w{4}\d{4}$') {
	$result{$r} = 1;
    }
}

$url = "http://www.handbook.unsw.edu.au/undergraduate/courses/2015/$ARGV[0].html\
";
open F, "wget -q -O- $url|" or die;
while ($line = <F>) {
    if ($line =~ 'Prerequisite') {
        @x = split /<p>/, $line;
        $x[1] =~ s/Prerequisite: //g;
        $x[1] =~ s/<.+?>//g;
        $x[1] =~ s/[\.\[\]]//g;
        @get = split / /,$x[1];
    }
}
foreach $r (@get) {
    if ($r =~ '^\w{4}\d{4}$') {
	$result{$r} = 1;
    }
}

foreach $r (sort keys %result) {
    print "$r\n";
}
