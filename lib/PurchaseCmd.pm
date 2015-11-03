#!/user/bin/perl
package PurchaseCmd;
use strict;
use warnings FATAL => 'all';
use v5.18;
use parent qw(Command);

use OrderService;

sub execute {
    my $self = shift;
    my @parameters = $self->parameters();
    my $order_service = OrderService->new();
    return $order_service->buy($parameters[0], $parameters[1], $parameters[2], $parameters[3])
}

1;