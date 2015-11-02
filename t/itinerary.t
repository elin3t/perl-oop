#!/usr/bin/perl
use strict;
use warnings;
use v5.18;
use Test::More;

use lib '../lib';
use Itinerary;

my $date  = localtime();

my $itinerary = Itinerary->new('12345678','Montevideo',$date,'Dell XPS 9530');

is($itinerary->number,'12345678','check initial value for number');
is($itinerary->location,'Montevideo','check initial value for location');
is($itinerary->date,$date,'check initial value for date');
is($itinerary->description,'Dell XPS 9530','check initial value for description');

done_testing();
