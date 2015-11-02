#!/usr/bin/perl
use strict;
use warnings;
use v5.18;

use Test::Exception;
use Test::More;

use lib '../lib';
use Command;

my $command = Command->new;
dies_ok{$command->execute()};

done_testing();
