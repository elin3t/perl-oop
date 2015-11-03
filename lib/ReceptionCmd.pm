package ReceptionCmd;
use strict;
use warnings FATAL => 'all';
use parent 'Command';

use OrderService;

sub execute{
    my $self = shift;
    my $order_s = shift || OrderService->new();
    my @parameters = $self->parameters();
    return $order_s->reception_package($parameters[0], $parameters[1], $parameters[2], $parameters[3]);
}

1;