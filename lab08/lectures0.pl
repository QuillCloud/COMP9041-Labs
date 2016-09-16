#!/usr/bin/perl -w
foreach $lecture (@ARGV) {
    $url = "http://timetable.unsw.edu.au/2016/$lecture.html";
    open F, "wget -q -O- $url|" or die;
    $pr = "";
    while ($line = <F>) {
	$count = 0;
	if ($line =~ /href.*Lecture/) {
	    $s = $line;
	    while ($count < 6) {
		$line = <F>;
		$count ++
	    }
	    $time = $line;
	    $s =~ s/^\s+//g;
	    $s =~ s/<td class="data"><a href="#//g;
	    @ss = split/-/, $s;
	    if ($time =~ /Weeks/) {
		$time =~ s/^\s+//g;
		$time =~ s/<td class="data">|<\/td>//g;
		if ($time ne "") {
		    if ($pr ne $time) {
			print("$lecture: ");
			print("$ss[0] ");
			print("$time");
			$pr = $time;
		    }
		}
	    }
	}
    }
}
