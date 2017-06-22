#!/usr/bin/perl -w
sub reduce(&@) {
    my ($code,@l) = @_;
    if ($#l < 1) {
	return;
    }
    $a = $l[0];
    foreach $num (1..$#l) {
	$b = $l[$num];
	$a = &$code;
    }
    return $a;
}
$sum = reduce { $a + $b } 1 .. 10;
$min = reduce { $a < $b ? $a : $b } 5..10;
$maxstr = reduce { $a gt $b ? $a : $b } 'aa'..'ee';
$concat = reduce { $a . $b } 'J'..'P';
$sep = '-';
$join = reduce { "$a$sep$b" }  'A'..'E';
print "$sum $min $maxstr $concat $join\n";
