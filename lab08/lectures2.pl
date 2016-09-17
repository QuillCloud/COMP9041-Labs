#!/usr/bin/perl -w
if ($ARGV[0] eq "-d") {
    $mode = 1;
    $go = 1;
}
elsif ($ARGV[0] eq "-t") {
    $mode = 2;
    $go = 1;
}
else {
    $mode = 0;
    $go = 0;
}
%hash = ();
@htime = (9..20);
@hdate = ("Mon","Tue","Wed","Thu","Fri");
sub timetable {
    my ($hs,$hd,$ht) = @_;
    if (exists $hash{$hs}) {
        $hash{$hs}{$ht}{$hd}++;
    }
    else {
        %{$hash{$hs}} = ();
        foreach $tt (@htime) {
            %{$hash{$hs}{$tt}} = ();
            foreach $dd (@hdate) {
                $hash{$hs}{$tt}{$dd} = 0;
            }
        }
        $hash{$hs}{$ht}{$hd}++;
    }
}
foreach $lecture (@ARGV[$go..$#ARGV]) {
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
					if ($mode == 1) {
					    print("$ss[0] $lecture $date $output\n");
					}
					else {
					    timetable($ss[0], $date, $output);
					}
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
				    if ($mode == 1) {
					print("$ss[0] $lecture $detail[0] $output\n");
				    }
				    else {
					timetable($ss[0], $detail[0], $output);
				    }
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
if ($mode == 2) {   
    foreach $semester (keys %hash) {
	print("$semester       Mon   Tue   Wed   Thu   Fri\n");
	foreach $lec_t (@htime) {
	    if ($lec_t eq 9) {
		print("0");
	    }
	    print("$lec_t:00");
	    foreach $lec_d (@hdate) {
		if ($hash{$semester}{$lec_t}{$lec_d} eq 0) {
		    print("      ");
		}
		else {
		    print("     $hash{$semester}{$lec_t}{$lec_d}");
		}
	    }
	    print("\n");
	}
    }
}
