#!/usr/bin/perl -w
%hash = ();
@time = (9..20);
foreach $tt (@time) {
    print("$tt\n");
}
@week = ("Mon","Tue","Wed","Thu","Fri");
sub stack {
    my ($s,$d,$t) = @_;
    if (exists $hash{$s}) {
	$hash{$s}{$t}{$d}++;
    }
    else {
	%{$hash{$s}} = ();
	foreach $tt (@time) {
	    %{$hash{$s}{$tt}} = ();
	    foreach $ww (@week) {
		$hash{$s}{$tt}{$ww} = 0;
	    }
	}
	$hash{$s}{$t}{$d}++;
    }
}

stack("S1", "Mon", 18);
print($hash{"S1"}{18}{"Mon"});
