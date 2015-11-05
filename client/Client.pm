#
#===============================================================================
#
#         FILE: Handler.pm
#
#  DESCRIPTION: 
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 02/11/15 11:45:08
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use lib '../lib';
use v5.18;
              # Perl core module


package Client;

use LWP::Simple;                # From CPAN
use JSON qw( decode_json );     # From CPAN
use Data::Dumper;

sub new{
    my $class = shift;

    my $self = {
        errors => []
    };

    bless $self, $class;
    return $self;
}

my $parse_line = sub {
    my $self = shift;
    my $line = shift;

    return $line;
};

sub make_url {
    my $self = shift;
    my $line = shift;
    my $myurl = "http://127.0.0.1/cgi-bin/echo.pl?$line";
    return $myurl;
}


sub command_factory {
    my $self = shift;
    my $request;

    my $filetowrite = "output.txt";
    my $filetowriteerrors = "error.txt";
    my $inputfile = "input.txt";
    open(my $input, '<:encoding(UTF-8)', $inputfile) or die "error opening";
    open(my $output, '>:encoding(UTF-8)', $filetowrite) or die "Could not open file '$filetowrite' $!";
    open(my $error, '>:encoding(UTF-8)', $filetowriteerrors) or die "Could not open file '$filetowriteerrors' $!";
    while(my $line = <$input>){

        chomp($line);
        my $url = $self->make_url($line);

        my $json = get( $url );
        die "Could not get $url!" unless defined $json;

        # Decode the entire JSON
        my $decoded_json = decode_json( $json );

        # you'll get this (it'll print out); comment this when done.
        print Dumper $decoded_json->{output};


    }
    close($output);
    close($error);
    close($input);


}

1;

my $client = Client->new();
$client->command_factory;

__END__
