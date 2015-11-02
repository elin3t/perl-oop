use strict;
use warnings FATAL => 'all';
use parent 'Repository';

package OrderHashRepository;


our @ISA = qw(Repository);

sub add{
    my $self = shift;
    my $order = shift;

    return $self->SUPER::add($order->number, $order);
}
1;