#!/usr/bin/perl

package Itinerary;
use v5.18;
use strict;
use warnings FATAL => 'all';

sub new {
    my $class = shift;
    my ($number,$location, $date, $description) = @_;
    my $self = {
        number => $number,
        location => $location,
        date => $date,
        description => $description
    };
    bless $self, $class;
    
    return $self;    
}

sub number {
    my $self = shift;
    return $self->{'number'};
}
sub location {
    my $self = shift;
    return $self->{'location'};
}
sub date {
    my $self = shift;
    return $self->{'date'};
}
sub description{
    my $self = shift;
    return $self->{'description'};
}
1;
