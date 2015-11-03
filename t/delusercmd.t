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

my @paramenters = ('test_username', );
my $delcmnd = DelUserCmd->new(@paramenters);
is( $delcmnd->execute(), 1, 'return true, success on deleting user' );
my $delcmnd1 = DelUserCmd->new(@paramenters);
is( $delcmnd1->execute(), 0, 'return false, unable to delele non existent user' );

done_testing();
