#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use lib '../lib';
use Test::MockModule;
use AddUserCmd;

my $module = Test::MockModule->new('UserService');
$module->mock( add_user => sub  {
    my $self = shift;
    my $username = shift;

    if ($username eq 'no-repeated') {
        return 1
    } else {
        return 0;
    }
} );

my $add_user_cmd = AddUserCmd->new('no-repeated', 'first_name' , 'lastName');

my $result = $add_user_cmd->execute();
is ($result->get_output, "Usuario no-repeated agregado", "User added ok");
is($result->isa('Output'), 1, 'Result must be an instance of output');

my $add_user_cmd2 = AddUserCmd->new('repeated', 'first_name' , 'lastName');
my $result1 = $add_user_cmd2->execute();
is($result1->isa('MyError'), 1, 'Result must be an instance of error if the
username is repeated');
is ($result1->get_output, "El usuario repeated ya existe", "User repetead not
    added");
done_testing();
