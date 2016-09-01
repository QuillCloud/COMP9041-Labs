#!/usr/bin/perl -w 
%result = ();
while ($input = <STDIN>) {
    $input = lc $input;
    @number = split / /, $input;
    $input =~ s/^\d+//g;
    $input =~ s/\s+/ /g;
    $input =~ s/^\s//g;
    $input =~ s/\s$//g;
    $input =~ s/s$//g;
    if (exists $result{$input}) {
	$result{$input}[0] += $number[0];
	$result{$input}[1] += 1;
    }
    else {
	$result{$input}[0] = $number[0];
	$result{$input}[1] = 1;
    }
}
foreach $key (sort keys %result) 
{
    $s = $key;
    chomp $s;
    print "$s observations: $result{$key}[1] pods, $result{$key}[0] individuals\n";
}      
