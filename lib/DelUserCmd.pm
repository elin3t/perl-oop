package DelUserCmd;
use strict;
use warnings FATAL => 'all';
use v5.18;
use parent qw(Command);

use UserService;
use Error;

sub execute {
    my $self = shift;
    my @username = $self->parameters();
    my $user_service = UserService->new();
    if($user_service->delete_user($username[0])){
        return Output->new("Usuario '$username[0]' eliminado");
    }
    return Error->new("El usuario '$username[0]' no fue encontrado");
}

1;
