#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use lib '../lib';
use DelUserCmd;
use UserService;

#create one user to test
my $us = UserService->new();
my $testuser = $us->add_user('test_username', 'test_name', 'test_lastn');

is( DelUserCmd->execute('test_username'), 1, 'return true, success on deleting user' );
is( DelUserCmd->execute('test_username'), 0, 'return false, unable to delele non existent user' );

done_testing();
