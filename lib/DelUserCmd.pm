package DelUserCmd;
use strict;
use warnings FATAL => 'all';
use UserService;


sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
    return $self;
}


sub execute {
    my $self = shift;
    my $username = shift;

    if ($self->validate($username)){
        return UserService::delete_user($username);
    }
    return 0;
}

sub validate {
    my $self = shift;
    my $username = shift;
    return $username =~ /\w{1,20}/;
}

1;