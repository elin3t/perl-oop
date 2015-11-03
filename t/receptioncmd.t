#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

use lib '../lib';
use ReceptionCmd;

my @parameters = ('12345', '54321', 'Cabillito JM Moreno 200', '20151102');
my $recpetioncmd = ReceptionCmd->new(@parameters);

is( $recpetioncmd->execute(), 1, 'Get and return the value of sending the args to reception_package');


done_testing();
