package ReceptionCmd;
use strict;
use warnings FATAL => 'all';
use parent 'Command';

use OrderService;

sub execute{
    my $self = shift;
    my @parameters = $self->parameters();
    my $order_s = OrderService->new();
    return $order_s->reception_package($parameters[0], $parameters[1], $parameters[2], $parameters[3]);
}

1;