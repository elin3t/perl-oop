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
use lib '../lib';
use Handler;
use MyError;
use Test::MockModule;

my $module = Test::MockModule->new('UserService');
$module->mock('add_user',sub {
    my $self = shift;
    my $username = shift;
    if ($username eq 'no-repeated') {
         return 1
    }
    else {
         return 0;
    }
});

use Test::More;

my $handler = Handler->new();
my $command = $handler->command_factory("A,no-repeated,Uriarte,Pedro Alberto");
is($command->isa('AddUserCmd'),1,"command_factory addusercmd");

$handler->command_factory("A,not-repeated,Uriarte,Alberto");
#$handler->command_factory("A,bad,Uds,fffto");

is($handler->run_commands(), "Usuario no-repeated agregado\nError\n", "run_command");
is($handler->print_errors(), "El usuario not-repeated ya existe\n", "print_errors");
done_testing();


