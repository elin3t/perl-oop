package Package;

use strict;
use warnings FATAL => 'all';

sub new {
    my $class = shift;
    
    my ($number,$state,$location,$contents) = @_;
    my $self = {
        number => $number,
        state => $state,
        location => $location,
        contents => $contents,
        itineraries => []
    };
    bless $self, $class;
    return $self;
}

sub number {
    return shift->{"number"};
}

sub state{
    return  shift->{"state"};
}

sub set_state {
    my $self = shift;
    $self->{"state"} = shift;
}    

sub location {
    return shift->{"location"};
}

sub contents {
    return shift->{"contents"};
}

sub itineraries {
    my $self = shift;
    return @{$self->{"itineraries"}};
}

sub add_itinerary {
    my $self = shift;
    my $itinerary = shift;
    push @{$self->{"itineraries"}}, $itinerary;
}

1;
