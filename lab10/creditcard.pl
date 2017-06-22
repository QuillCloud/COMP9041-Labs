#!/usr/bin/perl -w
# validate a credit card number by calculating its
# checksum using Luhn's formula (https://en.wikipedia.org/wiki/Luhn_algorithm)
sub luhn_checksum {
    my ($number) = @_;
    my $checksum = 0;
    @digit = split(//, $number);
    $check = 1;
    for $d (reverse @digit) {
	if ($check % 2 == 0) {
	    $single = $d * 2;
	    @digit2 = split(//, $single);
	    for $d2 (@digit2) {
		$checksum += $d2;
	    }
	} else {
	    $checksum += $d;
	}
	$check++;
    }
    return $checksum;
}
for $num (@ARGV) {
    if ($num =~ /^\d{16}$/ || $num =~ /^(\d{4}-){3}\d{4}/) {
	$cre = $num; 
	$cre =~ s/-//g;
	if (&luhn_checksum($cre) % 10 == 0) {
	    print "$num is valid\n";
	} else {
	    print "$num is invalid\n";
	}
    } else {
	print "$num is invalid - does not contain exactly 16 digits\n";
    }
}
