#!/usr/bin/perl -w
# validate a credit card number by calculating its
# checksum using Luhn's formula (https://en.wikipedia.org/wiki/Luhn_algorithm)
use CGI qw/:all/;
use CGI::Carp qw/fatalsToBrowser warningsToBrowser/;
print header, start_html("Credit Card Validation"), "\n";
warningsToBrowser(1);
print h2("Credit Card Validation");
$flag = 1;
$close = param("Close");
if (defined $close) {
    $flag = 0;
    print "Thank you for using the Credit Card Validator.\n";
}
if ($flag ne 0) {
    print p("This page checks whether a potential credit card number satisfies the Luhn Formula.");
    print start_form. "\n";
    $credit_card = param("credit_card");
    if (defined $credit_card) {
	$outcome = &validate($credit_card);
	if ($flag == 2) {
	    print b($outcome);
	} elsif ($flag == 3) {
	    print b(span ({style => 'color : red'}), $outcome);
	}
	print p;
    }
    if ($flag == 1) {
	print "Enter credit card number:\n", textfield('credit_card'), "\n";
    } elsif ($flag == 2) {
	print "Another credit card number:\n", textfield('credit_card'), "\n";
    } elsif ($flag == 3) {
	print "Try again:\n", textfield('credit_card'), "\n";
    }
    print submit('Validate'), "\n";
    print reset(reset => Reset), "\n";
    print submit('Close'), "\n";
    print end_form, "\n";
}
print end_html;
exit 0;
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
sub validate {
    my ($num) = @_;
    if ($num =~ /^\d{16}$/ || $num =~ /^(\d{4}-){3}\d{4}/) {
	$cre = $num; 
	$cre =~ s/-//g;
	if (&luhn_checksum($cre) % 10 == 0) {
	    $flag = 2;
	    return "$num is valid\n";
	} else {
	    $flag = 3;
	    return "$num is invalid\n";
	}
    } else {
	$flag = 3;
	$num =~ s/\<|\,|\>|\,|\&|\?//g;
	return "$num is invalid - does not contain exactly 16 digits\n";
    }
}
