use strict;
use warnings FATAL => 'all';
use parent 'Repository';

package UserHashRepository;


our @ISA = qw(Repository);

sub add{
    my $self = shift;
    my $user = shift;

    return $self->SUPER::add($user->username, $user);
}

1;
