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
use utf8;
package Client;

use LWP::Simple;                # From CPAN
use JSON qw( decode_json from_json );     # From CPAN
use Data::Dumper;
use URL::Encode qw( url_encode_utf8);


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
    my $line = url_encode_utf8 shift;
    my $myurl = "http://127.0.0.1/cgi-bin/Server.pm?command=$line";
    return $myurl;
}


sub command_factory {
    my $self = shift;
    my $filetowrite = "output.txt";
    my $filetowriteerrors = "error.txt";
    my $inputfile = "input.txt";
    open(my $input, '<:encoding(UTF-8)', $inputfile) or die "error opening";
    open(my $output, '>:encoding(UTF-8)', $filetowrite) or die "Could not open file '$filetowrite' $!";
    open(my $error, '>:encoding(UTF-8)', $filetowriteerrors) or die "Could not open file '$filetowriteerrors' $!";
    while(my $line = <$input>){

        chomp($line);
        my $url = $self->make_url($line);
        #print $url."\n";
        my $json = get( $url);
        die "Could not get $url!" unless defined $json;

        # Decode the entire JSON
        my $decoded_json = JSON->new->utf8->decode( $json);
        my $outpututf8 = $decoded_json->{output};
        utf8::encode($outpututf8);

        # you'll get this (it'll print out); comment this when done.
        print $output $outpututf8;
        if($decoded_json->{error} ne ""){
            my $errorutf8 = $decoded_json->{error};
            utf8::decode($errorutf8);
            print $error $errorutf8;
        }

    }
    close($output);
    close($error);
    close($input);


}

1;

my $client = Client->new();
$client->command_factory;

__END__
