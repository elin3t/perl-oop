#!/user/bin/perl
use strict;
use warnings;
use v5.18;

package Itinerary_Test;

sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
    return $self;
}

sub to_test {
    return "ok!";
}

use Test::More;
use lib '../lib';
use Package;

my $package = Package->new('12345678','Enviado','Montevideo','Libro de Perl');

is($package->number,'12345678','initial value for number');
is($package->state,'Enviado', 'initial value for state');
is($package->location,'Montevideo', 'initial value for location');
is(scalar $package->itineraries, 0,'initial value for itineraries');

my $itinerary = Itinerary_Test->new;
$package->add_itinerary($itinerary);

is(scalar $package->itineraries, 1,'check value of itineraries after add a new itinerary');
my @itineraries = $package->itineraries;

is($itineraries[0]->to_test,'ok!','check instance of itinerary in itineraries');

done_testing();
