#!/usr/bin/perl -w
if ($#ARGV != 0){
    print("Please give one word!\n");
    exit(0);
}
$word = lc($ARGV[0]);
foreach $file (glob "poems/*.txt") {
    open(F, $file);
    @f = <F>;
    $wcount = 0;
    $tcount = 0;
    foreach $l (@f){
	$l =~ s/'s/ s/g;
	$l =~ s/[^a-zA-Z]/ /g;
	@line = split/\s+/, lc($l);
	foreach $w (@line){
	    if ($w ne "") {
		$tcount++;
	    }
	    if ($w =~ /^$word$/){
		$wcount++;
	    }
	}
    }
    $file =~ s/poems\/|.txt//g;
    $file =~ s/_/ /g;
    printf("%4d/%6d = %.9f %s\n",$wcount,$tcount,$wcount/$tcount,$file);

}
