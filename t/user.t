#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 2;
use lib '../lib';
use User;

ok( User->testOne() == 1 );
ok( User->testOne() == 1 );
#done_testing();

