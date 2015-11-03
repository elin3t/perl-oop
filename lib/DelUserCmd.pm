package DelUserCmd;
use strict;
use warnings FATAL => 'all';
use v5.18;
use parent qw(Command);

use UserService;

sub execute {
    my $self = shift;
    my $username = shift;
    my $user_service = UserService->new();
    if ($self->validate($username)){
        return $user_service->delete_user($username);
    }
    return 0;
}

sub validate {
    my $self = shift;
    my $username = shift;
    return $username =~ /\w{1,20}/;
}

1;