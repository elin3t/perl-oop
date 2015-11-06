#
#===============================================================================
#
#         FILE: ItineraryRepository.pm
#
#  DESCRIPTION: 
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 06/11/15 16:41:32
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

package Itinerary_Repository;
use Repository;
our @ISA = qw(Repository);
use Data::Dumper;
my $singleton;

sub new {
	my $class = shift;
	return $class->SUPER::new("itinerary","itinerary_id");
}

sub add {
	my $self = shift;
	my $itinerary = shift;
	print Dumper \$itinerary;
	return $self->SUPER::add(-1, $itinerary->{number},  $itinerary->{location},$itinerary->{date},  $itinerary->{description}, 0);
}

1; 

