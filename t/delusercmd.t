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
my $output = $delcmnd->execute();
is( $output->get_output(), "Usuario 'test_username' eliminado", 'return correct output, success on deleting user' );
my $delcmnd1 = DelUserCmd->new(@paramenters);
my $error = $delcmnd1->execute();
is( $error->get_output(), "El usuario 'test_username' no fue encontrado", 'return error, unable to delele non existent user' );

done_testing();
