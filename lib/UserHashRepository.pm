use strict;
use warnings FATAL => 'all';
use parent 'Repository';

package UserHashRepository;


our @ISA = qw(Repository);

sub add{
    my $self = shift;
    my $user = shift;

    if ($self->SUPER::find($user->username)) {
       return 0
    } else {
        $self->SUPER::add($user->username, $user);
        return 1;
    }
}

1;
