#!/usr/bin/perl -w
while ($line = <STDIN>) {
    while ($line =~ s/<!([^>]+)>/<!>/) {
        $s = `$1`;
        $line =~ s/<!>/$s/;
    }
    while ($line =~ s/<([^>!]+)>/<>/) {
        $s = `cat $1`;
        $line =~ s/<>/$s/;
    }
    print $line;
}
