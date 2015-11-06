#
#===============================================================================
#
#         FILE: itinerary_repository.t
#
#  DESCRIPTION: 
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 06/11/15 16:51:20
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use lib '../lib';
use Test::More; #tests => 1;                      # last test to print
use Itinerary_Repository;
use Itinerary;

my $itinerary_repository = Itinerary_Repository->new;
my $itinerary = Itinerary->new('12345678','Montevideo','2015-11-05', 'Dell XPS 9530');

$itinerary_repository->add($itinerary);

#done_testing();
1;



