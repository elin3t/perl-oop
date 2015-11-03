#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

use lib '../lib';
use UserService;

my $user_service = UserService->new();

is($user_service->add_user('testname','test_firstname', 'test_lastname'), 1, 'create user successfully' );
is($user_service->add_user('testname','test_fistname', 'test_lastname'), 0, 'return false user already exists' );
is($user_service->delete_user('testname'), 1, 'delete user successfully');
is($user_service->delete_user('testname'), 0, 'return false impossible to delete, user doesnt exist');

done_testing();
