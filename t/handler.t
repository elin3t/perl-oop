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
use Error;
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

#package TestCmd;

#sub new {
# my $class = shift;
# my $name = $_[0];
# my $self = {
#    name => $name
# };

 #bless $self, $class;
 #return $self;
#}

#sub execute {
 #   my $self = shift;
  #  my $name = $self->{'name'};
   # $name.= " comando prueba";
   # my $output;
   # if ($self->{'name'} == 0){
   #     $output = Error->new($name);
   # }
   # else{
    #    $output = Output->new($name);
    #}
    #return $output;
#}

#1;

use Test::More;

my $handler = Handler->new();
#my $test_cmd = TestCmd->new(1);
#my $test_cmd1 = TestCmd->new(2);
#my $test_cmd2 = TestCmd->new(0);

#my $command = $handler->command_factory('T', $test_cmd);
#is($command->isa('TestCmd'),1,"command_factory");

#$handler->command_factory('T', $test_cmd1);
#$handler->command_factory('T', $test_cmd2);

#is($handler->run_commands(), "1 comando prueba\n2 comando prueba\n", "run_command");

#is($handler->print_errors(), "0 comando prueba\n", "print_errors");

my $command = $handler->command_factory("A,no-repeated,Uriarte,Pedro Alberto");
is($command->isa('AddUserCmd'),1,"command_factory addusercmd");

is($handler->run_commands(), "Usuario no-repeated agregado\n", "run_command");



#$command = $handler->command_factory("E");
#is($command->isa('DelUserCmd'),1,"command_factory delusercmd");

#$command = $handler->command_factory("P");
#is($command->isa('PostaPkgCmd'),1,"command_factory postapkgcmd");

#$command = $handler->command_factory("R");
#is($command->isa('ReceptionCmd'),1,"command_factory receptioncmd");

#$command = $handler->command_factory("Z");
#is($command->isa('ItineraryCmd'),1,"command_factory itinerarycmd");

#$command = $handler->command_factory("C");
#is($command->isa('PurchaseCmd'),1,"command_factory purchasecmd");

#$command = $handler->command_factory("D");
#is($command->isa('DispatchCmd'),1,"command_factory dispatchcmd");

#my $command = $handler->command_factory("Y");
#is($command->isa('StateOrderCmd'),1,"command_factory stateordercmd");




done_testing();


