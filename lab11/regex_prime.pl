#!/usr/bin/perl -w
foreach $n (1..20) {
    $unary = 1 x $n;
    print "$n = $unary unary - ";
    if ($unary =~ /^1?$|^(11+?)\1+$/) {
        print "composite\n"
    } else {
        print "prime\n";
}
}
