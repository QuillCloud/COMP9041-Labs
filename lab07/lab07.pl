#!/usr/bin/perl -w
print("$#ARGV\n");
print("$ARGV[1]\n");
#foreach $file (glob "$ARGV[0]") {
#    print "$file\n";
#}
for $file (@ARGV) {
    print("$file\n");
}
