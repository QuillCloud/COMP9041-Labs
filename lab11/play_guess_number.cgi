#!/usr/bin/perl -w
# Simple CGI script written by andrewt@cse.unsw.edu.au
# Outputs a form which will rerun the script
# An input field of type hidden is used to pass an integer
# to successive invocations
# Two submit buttons are used to produce different actions

use CGI qw/:all/;
use CGI::Carp qw(fatalsToBrowser warningsToBrowser);

print <<eof;
Content-Type: text/html

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Handling Multiple Submit Buttons</title>
</head>
<body>
eof
warningsToBrowser(1);
$hidden_variable = param("x");
$upper = param("upper");
$bottom = param("bottom") || 0;
if (!defined($hidden_variable)) {
    $hidden_variable = 50;
}
if (!defined($upper)) {
    $upper = 100;
}
$flag = 0;
if (defined param("higher")) {
    $bottom = $hidden_variable;
    use integer;
    $hidden_variable = ($hidden_variable + $upper + 1) / 2 ;
} elsif (defined param("lower")) {
    $upper = $hidden_variable;
    use integer;
    $hidden_variable = ($hidden_variable + $bottom) / 2;
} elsif (defined param("correct")) {
    $flag = 1;
}
if ($flag eq 0) {
print <<eof
<form method="post" action="">
My guess is: $hidden_variable
<input type=hidden name="x" value="$hidden_variable">
<input type=hidden name="upper" value="$upper">
<input type=hidden name="bottom" value="$bottom">
<input type="submit" name="higher" value="Higher?">
<input type="submit" name="correct" value="Correct?">
<input type="submit" name="lower" value="Lower?">
</form>
</body>
</html>
eof
} else {
print <<eof
<form method="post" action="">
I win !!!
<input type="submit" name="playeragian" value="Player Again">
</form>
</body>
</html>
eof
}
