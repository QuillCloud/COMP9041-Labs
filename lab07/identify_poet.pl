#!/usr/bin/perl -w
if ($ARGV[0] eq "-d") {
    %arrayd = ();
    %hashd = ();
    open(F, $ARGV[1]);
    @sf = <F>;
    foreach $sl (@sf) {
	$sl =~ s/'s/ s/g;
	$sl =~ s/[^a-zA-Z]/ /g;
	@sline = split/\s+/, lc($sl);
	foreach $sw (@sline) {
	    if ($sw ne "") {
		if (exists $arrayd{$sw}) {
		    $arrayd{$sw} = $arrayd{$sw} + 1;
		}
		else {
		    $arrayd{$sw} = 1;
		}
	    }
	}
    }
    foreach $swords (keys %arrayd) {
	foreach $file (glob "poems/*.txt") {
	    open(F, $file);
	    @f = <F>;
	    $wcount = 0;
	    $tcount = 0;
	    foreach $l (@f){
		$l =~ s/'s/ s/g;
		$l =~ s/[^a-zA-Z]/ /g;
		@line = split/\s+/, lc($l);
		foreach $w (@line){
		    if ($w ne "") {
			$tcount++;
		    }
		    if ($w =~ /^$swords$/){
			$wcount++;
		    }
		}
	    }
	    $file =~ s/poems\/|.txt//g;
	    $file =~ s/_/ /g;
	    if (exists $hashd{$file}) {
		$hashd{$file} = $hashd{$file} + (log($wcount+1) - log($tcount)) * $arrayd{$swords};
	    }
	    else {
		$hashd{$file} = (log($wcount+1) - log($tcount)) * $arrayd{$swords};
	    }
	}
    }
    foreach $keyd (reverse sort {$hashd{$a} <=> $hashd{$b}} keys %hashd) {
	printf("$ARGV[1]: log_probability of %.1f for %s\n", $hashd{$keyd}, $keyd);
    }
    foreach $keyd (reverse sort {$hashd{$a} <=> $hashd{$b}} keys %hashd) {
        printf("$ARGV[1] most resembles the work of %s (log-probability=%.1f)\n", $keyd, $hashd{$keyd});
	last;
    }
}
else {
    foreach $poem (@ARGV) {
	%array = ();
	%hashd = ();
	open(F, $poem);
	@sf = <F>;
	foreach $sl (@sf) {
	    $sl =~ s/'s/ s/g;
	    $sl =~ s/[^a-zA-Z]/ /g;
	    @sline = split/\s+/, lc($sl);
	    foreach $sw (@sline) {
		if ($sw ne "") {
		    if (exists $array{$sw}) {
			$array{$sw} = $array{$sw} + 1;
		    }
		    else {
			$array{$sw} = 1;
		    }
		}
	    }
	}
	foreach $swords (keys %array) {
	    foreach $file (glob "poems/*.txt") {
		open(F, $file);
		@f = <F>;
		$wcount = 0;
		$tcount = 0;
		foreach $l (@f){
		    $l =~ s/'s/ s/g;
		    $l =~ s/[^a-zA-Z]/ /g;
		    @line = split/\s+/, lc($l);
		    foreach $w (@line){
			if ($w ne "") {
			    $tcount++;
			}
			if ($w =~ /^$swords$/){
			    $wcount++;
			}
		    }
		}
		$file =~ s/poems\/|.txt//g;
		$file =~ s/_/ /g;
		if (exists $hashd{$file}) {
		    $hashd{$file} = $hashd{$file} + (log($wcount+1) - log($tcount)) * $array{$swords};
		}
		else {
		    $hashd{$file} = (log($wcount+1) - log($tcount)) * $array{$swords};
		}
	    }
	}
	foreach $keyd (reverse sort {$hashd{$a} <=> $hashd{$b}} keys %hashd) {
	    printf("$poem most resembles the work of %s (log-probability=%.1f)\n", $keyd, $hashd{$keyd});
	    last;
	}   
    }
}
