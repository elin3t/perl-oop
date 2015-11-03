#!/usr/bin/perl
use strict;
use warnings;
use v5.18;

use Test::More;
use lib '../lib';
use PurchaseCmd;
use UserService;
use OrderService;

#create one user to test
my $us = UserService->new();
my $testuser = $us->add_user('jjlopez', 'jose', 'lopez');

#create one order to test
my @paramenters = ('jjlopez', '50212', 'paquete de prueba', '3');
my $purchase_cmd = PurchaseCmd->new(@paramenters);
is( $purchase_cmd->execute(), 1, 'The order has been added' );

done_testing();

