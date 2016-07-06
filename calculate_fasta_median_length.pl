# !/usr/local/bin/perl -w
# calculate_fasta_median_length.pl

use strict;
use warnings;

# Set files to scalar variables
my $usage = "Usage: perl $0 <INFILE>";
my $infile = shift or die $usage;
open( my $IN, '<', "$infile" ) || die "Unable to open $infile: $!";

my @lengths      = ();
my $array_length = 0;

while ( defined( my $line = <$IN> ) ) {

    next if substr( $line, 0, 1 ) eq '>';   # Skip the sequence identifier lines

    chomp $line;
    my $line_length = length $line;
    $lengths[$line_length]++;

    $array_length++;
}
close $IN;

my @median     = ();
my $accumulate = 0;
while ( my ( $key, $value ) = each @lengths ) {
    $accumulate += $value // 0;
    next if $accumulate < $array_length / 2;
    push @median, $key;
    last if $accumulate > $array_length / 2;
}

my $result = ( $median[0] + $median[-1] ) / 2;
printf $result. "\t" . $infile . "\n";
