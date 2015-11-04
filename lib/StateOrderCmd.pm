#!/user/bin/perl
package StateOrderCmd;
use strict;
use warnings FATAL => 'all';
use parent 'Command';

use OrderService;

sub execute {
    my $self = shift;
    my $order_s = shift || OrderService->new();
    my @parameters = $self->parameters();
    return $order_s->state_order($parameters[0]);
}

1;