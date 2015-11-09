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

package ItineraryRepository;
use Repository;
our @ISA = qw(Repository);


sub add {
	my $self = shift;
	my $itinerary = shift;
	my $dbh = $self->{'dbh'};
	#print Dumper \$itinerary;
	my $insert = $dbh->prepare(q{INSERT INTO itinerary (package_number,
    itinerary_location, itinerary_date, itinerary_description)
    VALUES
    (?, ?, ?, ?)});

	$insert->execute($itinerary->number, $itinerary->location, $itinerary->date,
	$itinerary->description);
}

1; 

