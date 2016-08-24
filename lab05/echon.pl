#!/usr/bin/perl -w
if (@ARGV!=2) {
    print  "Usage: $0 <number of lines> <string> at ./$0 line 3.\n";
    exit
}

for ($i = 0; $i < $ARGV[0]; $i++) {
    print "$ARGV[1]\n";
}
