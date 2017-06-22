#!/usr/bin/perl -w
$a = "am";
$p = "pm";
while ($line = <>) {
    if ($line =~ /(\d+:\d+:\d+)/) {
	$time = $1;
	$time =~ /(^\d+)/;
	$hour = $1;
	$time_new = $time;
	if ($hour =~ /00/) {  
	    $time_new =~ s/^00/24/g;
	    $line =~ s/$time/$time_new$a/g;
	} elsif ($hour >= 12) {
	    if ($hour > 12) {
		$hour1 = sprintf "%02d", int($hour) - 12;
	    } else {
		$hour1 = $hour;
	    }
	    $time_new =~ s/^$hour/$hour1/g;
	    $line =~ s/$time/$time_new$p/g;
	} else {
	    $line =~ s/$time/$time$a/g;
	}
    }
    print "$line";
}
