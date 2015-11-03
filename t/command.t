#!/usr/bin/perl
use strict;
use warnings;
use v5.18;

use Test::Exception;
use Test::More;

use lib '../lib';
use Command;

my @parameters = ('a','b','c');
my $command = Command->new(@parameters);
is(scalar $command->parameters, 3, 'Check paramenters initialization');
dies_ok{$command->execute()};

done_testing();
