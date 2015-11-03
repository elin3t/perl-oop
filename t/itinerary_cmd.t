#
#===============================================================================
#
#         FILE: itinerary_cmd.t
#
#  DESCRIPTION: 
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 03/11/15 10:45:40
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use lib '../lib';
use ItineraryCmd;
use Test::More;

my @array = (456);
my $itinerary = ItineraryCmd->new(@array);


done_testing();
