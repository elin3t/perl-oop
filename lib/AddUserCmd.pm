package AddUserCmd;

use strict;
use warnings;
use parent 'Command';

use UserService;
use Output;
use Error;

our @ISA = qw(Command);


sub excecute {

    my $self = shift;
    my $user_service = shift || UserService->new();
    my ($username, $first_name, $last_name) = ($self->{'parameters'}[0],
    $self->{'parameters'}[1], $self->{'parameters'}[2]);

    my $to_return;
    if ($user_service->add_user($username, $first_name, $last_name)) {
        $to_return = Output->new("Usuario $username agregado" );
    } else {
        $to_return = Error->new("El usuario $username ya existe");
    }
    return $to_return;
}

1;
