#!/usr/bin/perl -w
$i = 0;
$c = 0;
	
while ($input = <STDIN>) {
    if ($input =~ /$ARGV[0]/) {
       @ch = split / /, $input;
       $c = $c + $ch[0];
       $i++;
    }
}
print "$ARGV[0] observations: $i pods, $c individuals\n";
