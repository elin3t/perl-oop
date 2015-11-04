package Main;
use strict;
use warnings FATAL => 'all';
use lib 'lib';

use Data::Dumper;

use Handler;

sub process_entry{
    my $self = shift;
    my $filetoread = shift;
    my $handle = shift;
    open (my $entries, '<:encoding(UTF-8)' ,$filetoread) or "Could not open the file: $filetoread";
    while(my $line = <$entries>){
        $handle->command_factory($line);
    }
    close($entries);
}

sub process_output{
    my $self = shift;
    my $filetowrite = shift;
    my $handle = shift;
    open(my $output, '>:encoding(UTF-8)', $filetowrite) or die "Could not open file '$filetowrite' $!";
    print $output $handle->run_command();
    close($output);
}

sub process_errors{
    my $self = shift;
    my $filetowriteerrors = shift;
    my $handle = shift;
    open(my $errors, '>', $filetowriteerrors) or die "Could not open file '$filetowriteerrors' $!";
    print $errors $handle->print_errors();
    close($errors);
}

sub main{
    my $self = shift;
    my $filetoread = shift @ARGV || "inputs/orders-input" || die "no file to read!";
    my $filetowrite = shift @ARGV || "output.txt";
    my $filetowriteerrors = shift @ARGV || "error.txt";

    my $handle = Handler->new();
    $self->process_entry($filetoread, $handle);
    $self->process_output($filetowrite, $handle);

    if($handle->has_errors()){
        $self->process_errors($filetowriteerrors, $handle);
        return 1;
    }

    return 0;
}

main();

1;

__END__
