#
#===============================================================================
#
#         FILE: handler.t
#
#  DESCRIPTION: 
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 02/11/15 14:28:25
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

use Test::More;#tests => 1;                      # last test to print
use lib '../lib';
use Handler;

my $handler = Handler->new();

my $command = $handler->command_factory("A");
is($command->isa('AddUserCmd'),1,"command_factory addusercmd");

$handler->run_command();


$command = $handler->command_factory("E");
is($command->isa('DelUserCmd'),1,"command_factory delusercmd");

$command = $handler->command_factory("P");
is($command->isa('PostaPkgCmd'),1,"command_factory postapkgcmd");

$command = $handler->command_factory("R");
is($command->isa('ReceptionCmd'),1,"command_factory receptioncmd");

$command = $handler->command_factory("Z");
is($command->isa('ItineraryCmd'),1,"command_factory itinerarycmd");

my $command = $handler->command_factory("C");
is($command->isa('PurchaseCmd'),1,"command_factory purchasecmd");

my $command = $handler->command_factory("D");
is($command->isa('DispatchCmd'),1,"command_factory dispatchcmd");

#my $command = $handler->command_factory("Y");
#is($command->isa('StateOrderCmd'),1,"command_factory stateordercmd");




done_testing();


