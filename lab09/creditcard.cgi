#!/usr/bin/perl -w
use CGI qw/:all/;
use CGI::Carp qw/fatalsToBrowser warningsToBrowser/;

print header, start_html("Credit Card Validation"), "\n";
warningsToBrowser(1);
$credit_card = param("credit_card");
if (defined $credit_card) {
    print validate($credit_card);
}
print end_html;
exit 0;
