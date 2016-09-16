#!/usr/bin/perl -w
%totalhash = ();
foreach $file (glob "poems/*.txt") {
    open(F, $file);
    $file =~ s/poems\/|.txt//g;
    $file =~ s/_/ /g;
    %{$totalhash{$file}} = ();
    @f = <F>;
    $tcount = 0;
    foreach $line (@f) {
	$line = lc($line);
	$line =~ s/[^a-z]/ /g;
	@words = split/\s+/, $line;
	foreach $w (@words) {
	    if ($w ne "") {
		$tcount++;
		if (exists $totalhash{$file}{$w}){
		    $totalhash{$file}{$w}++;
		}
		else {
		    $totalhash{$file}{$w} = 1;
		}
	    }
	}
    }
    foreach $w2 (keys %{$totalhash{$file}}) {
	$totalhash{$file}{$w2} = log($totalhash{$file}{$w2} + 1) -  log($tcount);
    }
    $totalhash{$file}{0} = log(1) - log($tcount);
}

for $txt (@ARGV) {
    open(F, $txt);
    %hash = ();
    @f = <F>;
    foreach $line (@f) {
        $line = lc($line);
        $line =~ s/[^a-z]/ /g;
        @words = split/\s+/, $line;
        foreach $w (@words) {
            if ($w ne "") {
                if (exists $hash{$w}){
                    $hash{$w}++;
                }
                else {
                    $hash{$w} = 1;
                }
            }
        }
    }
    $hname = "";
    $hnumber = "";
    foreach $filename (keys %totalhash) {
	$c = 0;
	foreach $singleword (keys %hash) {
	    if (exists $totalhash{$filename}{$singleword}) {
		$c = $c +  $totalhash{$filename}{$singleword}*$hash{$singleword};
	    }
	    else {
		$c = $c + $totalhash{$filename}{0}*$hash{$singleword};
	    }
	}
	if ($hnumber eq '' or $hnumber < $c) {
	    $hname = $filename;
	    $hnumber = $c;
	}
    }
    printf("%s most resembles the work of %s (log-probability=%.1f)\n", $txt,$hname,$hnumber);
}
