#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use lib '../lib';
use AddUserCmd;

my $user_service = UserServiceFake->new();
my $add_user_cmd = AddUserCmd->new('no-repeated', 'first_name' , 'lastName');

my $result = $add_user_cmd->execute($user_service);
is ($result->get_output, "Usuario no-repeated agregado", "User added ok");
is($result->isa('Output'), 1, 'Result must be an instance of output');

my $add_user_cmd = AddUserCmd->new('repeated', 'first_name' , 'lastName');
my $result = $add_user_cmd->execute($user_service);
is($result->isa('Error'), 1, 'Result must be an instance of error if the username is repeated');
is ($result->get_output, "El usuario repeated ya existe", "User repetead not added");
done_testing();


package UserServiceFake;

sub new {
    my $class = shift;
    my $self = {};
    return  bless $self, $class;
}

sub add_user {
    my $self = shift;
    my $username = shift;

    if ($username eq 'no-repeated') {
        return 1
    } else {
        return 0;
    }
}