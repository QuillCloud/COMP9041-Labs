#!/usr/bin/perl -w
@ARGV = <STDIN>;
$check = ();
$i = 0;
while ($i <= $#ARGV) {
    $j = int(rand($#ARGV + 1));
    if (!$check[$j]) {
	$check[$j] = 1;
	print $ARGV[$j];
	$i++;
    }
}
