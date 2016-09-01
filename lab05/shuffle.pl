#!/usr/bin/perl -w
@lines = <STDIN>;
$check = ();
$i = 0;
while ($i <= $#lines) {
    $j = int(rand($#lines + 1));
    if (!$check[$j]) {
	$check[$j] = 1;
	print $lines[$j];
	$i++;
    }
}
