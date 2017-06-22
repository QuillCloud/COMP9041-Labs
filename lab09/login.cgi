#!/usr/bin/perl -w

use CGI qw/:all/;
use CGI::Carp qw/fatalsToBrowser warningsToBrowser/;

print header, start_html('Login');
warningsToBrowser(1);

$username = param('username') || '';
$password = param('password') || '';
$flag = 0;
if ($username && $password) {
    $file = "accounts/$username/password";
    $fileExists = -e "$file";
    if ($fileExists) {
	open(F, "<$file") or die "Can't open < input.txt: $!";
	$line = <F>;
	chomp $line;
	if ($password eq $line) {
	    print "$username authenticated.\n";
	    $flag = 1;
	}
	else {
	    print "Wrong password.\n";
	}
    }
    else {
	print "$username not exists.\n";
    }
}
elsif ($username) {
    print "Password required.\n";
}
elsif ($password) {
    print "Username required.\n";
}
if ($flag == 0) {
    print start_form, "\n";
    print "Username:\n", textfield('username'), "\n";
    print "Password:\n", textfield('password'), "\n";
    print submit(value => Login), "\n";
    print end_form, "\n";
}
print end_html;
exit(0);
