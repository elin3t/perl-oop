#
#===============================================================================
#
#         FILE: ItineraryCmd.pm
#
#  DESCRIPTION: 
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 02/11/15 17:14:20
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use Command;
use OrderService;

package ItineraryCmd;

our @ISA = qw(Command);  

sub execute {
    my $self = shift;
    my @parameters = $self->parameters;
    my $order_number = $parameters[0];
    my $order_service = OrderService->new();
    my $output = $order_service->read_itinerary($order_number);

    return $output;
}

1;


