#!/usr/bin/perl -w
if ($ARGV[0] eq "-d") {
    $mode = 1;
}
else {
    $mode = 0;
}
foreach $lecture (@ARGV[$mode..$#ARGV]) {
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
			$pr = $time;
			if ($mode == 0) {
			    print("$lecture: $ss[0] $time");
			}
			else {
			    my %result = ();
			    my @stack;
			    @t = split ", ", $time;
			    foreach $ss (@t) {
				@detail = split / /, $ss;
				if ($#detail eq 0) {
				    push(@stack, $detail[0]);
				    next
				}
				@start = split ":", $detail[1];
				@end = split ":", $detail[3];
				$during =  ($end[0]*60 + $end[1] -  $start[0]*60 - $start[1]) / 60;
				$x = 0;
				while ($#stack ne -1) {
				    $date = pop(@stack);
				    while ($x < $during) {
					$output = $start[0] + $x;
					if (exists($result{"$ss[0] $lecture $date $output\n"})) {
					    last;
					}
					$result{"$ss[0] $lecture $date $output\n"} = 1;
					print("$ss[0] $lecture $date $output\n");
					$x++;
						 
				    }
				    $x = 0;
				}
				while ($x < $during) {
				    $output = $start[0] + $x;
				    if (exists($result{"$ss[0] $lecture $detail[0] $output\n"})) {
					last;
				    }
				    $result{"$ss[0] $lecture $detail[0] $output\n"} = 1;
				    print("$ss[0] $lecture $detail[0] $output\n");
				    $x++;
				}
			    }
			}
		    }
		}
	    }
	}
    }
}
