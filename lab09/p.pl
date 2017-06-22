#!/usr/bin/perl -w
$a = "andrewt";
$b = "correct horse battery staple";
$file = "accounts/$a/password";
$file_exists = -e "$file";
if($file_exists) {
    open(F, "<$file") or die "Can't open < input.txt: $!";
    $password = <F>;
    chomp $password;
    if ($password eq $b){
	print("match\n");
    }
    else {
	print("not match\n");
    }
}
else {
    print "NO\n";
}
