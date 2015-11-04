#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

use lib '../lib';
use UserService;
use Test::MockModule;

my $module = Test::MockModule->new('UserService');
$module->mock( add_user => sub  {
    my $self = shift;
    my $username = shift;

    if ($username eq 'no-repeated') {
        return 1;
    } else {
        return 0;
    }
},
    delete_user => sub{
        my $self = shift;
        my $username = shift;

        if ($username eq 'exists') {
            return 1;
        } else {
            return 0;
        }
    }

);

my $user_service = UserService->new();

is($user_service->add_user('no-repeated','test_firstname', 'test_lastname'), 1, 'create user successfully' );
is($user_service->add_user('repeated','test_fistname', 'test_lastname'), 0, 'return false user already exists' );
is($user_service->delete_user('exists'), 1, 'delete user successfully');
is($user_service->delete_user('nonexits'), 0, 'return false impossible to delete, user doesnt exist');

done_testing();
