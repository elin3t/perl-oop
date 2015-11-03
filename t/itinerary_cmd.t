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
use Error;

my @array = (456);
my @array1 = (0);
my $itinerary = ItineraryCmd->new(@array);
my $itinerary1 = ItineraryCmd->new(@array1);

package TestService;

sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;

    return $self;
}

sub read_itinerary {
    my $self = shift;
    my $order_number = shift;
    if($order_number == 0) {
        return Output->new("Invalid Order.");
    }
    else {
        return Error->new("Order $order_number ok");
    }
}

1;


use Test::More;

my $test_serv = TestService->new();


is($itinerary->execute($test_serv)->get_output(),"Order 456 ok" ,"testing execute id=456");
is($itinerary1->execute($test_serv)->get_output(),"Invalid Order." ,"testing execute id =0");



done_testing();
