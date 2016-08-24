#!/usr/bin/perl -w
@files = ();
$i=10;
if (@ARGV eq 0) {
    @ARGV = <STDIN>;
    if ($i > $#ARGV) {
        $j=0;
    }
    else {
        $j = $#ARGV - $i + 1;
    }
    while ($j <= $#ARGV) {
	print $ARGV[$j];
	$j++
    }
    exit(0);
}
foreach $arg (@ARGV) {
    if ($arg eq "--version") {
        print "$0: version 0.1\n";
        exit(0);
    }
    elsif ($arg =~ m/^[-]\d*$/) {
	$i = $arg;
	$i =~ s/-//g;
    }
    # handle other options
    # ...
    else {
        push @files, $arg;
    }
}
foreach $f (@files) {
    open(F,"<$f") or die "$0: can't open $f\n"; 
    # process F
    #...
    @array = <F>;
    if ($i > $#array) {
	$j=0;
    }
    else {
	$j = $#array - $i + 1;
    }
    if ($#files > 0) {
	print "==> $f <==\n";
    }
    while ($j <= $#array) {
	print $array[$j];
	$j++;
    }
    close(F);
}
