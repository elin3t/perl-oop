package main;
use strict;
use warnings FATAL => 'all';
use lib 'lib';

use Data::Dumper;

use Handler;

sub main{
    my $filetoread = shift @ARGV || die "no file to read!";
    my $filetowrite = shift @ARGV || "output.txt";
    my $filetowriteerrors = shift @ARGV || "error.txt";
    open my $entries, $filetoread or "Could not open the file: $filetoread";
    open(my $output, '>', $filetowrite) or die "Could not open file '$filetowrite' $!";
    open(my $errors, '>', $filetowriteerrors) or die "Could not open file '$filetowriteerrors' $!";

    while(my $line = <$entries>){

    }

    close($filetoread);
}

main();

1;

__END__
