#!/usr/bin/perl -w
if ($ARGV[0] eq "-r") {
    @l=$ARGV[1];
}
else {
    exit 1;
}
while (@l) {
    $a = pop(@l);
    @get = ();
    $url = "http://www.handbook.unsw.edu.au/postgraduate/courses/2015/$a.html";
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
	    push @l,$r;
	    $result{$r} = 1;
	}
    }
    @get = ();
    $url = "http://www.handbook.unsw.edu.au/undergraduate/courses/2015/$a.html";
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
	    push @l,$r;
	    $result{$r} = 1;
	}
    }
}
foreach $r (sort keys %result) {
    print "$r\n";
}
