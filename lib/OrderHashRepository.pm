use strict;
use warnings FATAL => 'all';
use parent 'Repository';

package OrderHashRepository;


our @ISA = qw(Repository);
my $singlenton;

sub new {
    my $class = shift;
    my $self = {
        items=> {}
    };
    $singlenton ||= bless $self, $class;
    return $singlenton;
}

sub add{
    my $self = shift;
    my $order = shift;

    if ($self->SUPER::find($order->number)) {
        return 0
    } else {
        $self->SUPER::add($order->number, $order);
        return 1;
    }
}
1;