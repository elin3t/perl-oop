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
    my $handle = Handler->new();
    while(my $line = <$entries>){
        $handle->command_factory($line);
        $handle->run_command();
        print $output $handle->get_output();
    }
    print $errors $handle->print_errors();
    close($entries);
    close($output);
    close($errors);
}

main();

1;

__END__
