package main;
use strict;
use warnings FATAL => 'all';
use v5.18;
use Data::Dumper;
use lib './';
use Handler;

sub main{
    my $self = shift;
    my $filetoread = "../inputs/orders-input";
    my $filetowrite = "output.txt";
    my $filetowriteerrors = shift @ARGV || "error.txt";

    my $handle = Handler->new();
    my $entries;
    open ($entries, '<:encoding(UTF-8)', $filetoread);
    my @data = <$entries>;
    close($entries);
    foreach my $line (@data){
        chomp $line;
        $handle->command_factory($line);
    }

    open(my $output, '>:encoding(UTF-8)', $filetowrite) or die "Could not open file '$filetowrite' $!";
    my $op = $handle->run_commands();
    print $output $op;
    close($output);

    if(scalar @{$handle->{'errors'}}){
        open(my $errors, '>', $filetowriteerrors) or die "Could not open file '$filetowriteerrors' $!";
        print $errors $handle->print_errors();
        close($errors);
        return 1;
    }

    return 0;
}
main();

1;
__END__
