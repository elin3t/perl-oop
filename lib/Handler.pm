#
#===============================================================================
#
#         FILE: Handler.pm
#
#  DESCRIPTION: 
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 02/11/15 11:45:08
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use AddUserCmd;
use DelUserCmd;
use PurchaseCmd;
use PostaPkgCmd;
use DispatchCmd;
use ReceptionCmd;
use StateOrderCmd;
use ItineraryCmd;
use MyError;
use v5.18;

package Handler;

sub new{
    my $class = shift;

    my $self = {
        commands => [],
        errors => []
    };

    bless $self, $class;
    return $self;
}

my $parse_line = sub {
    my $self = shift;
    my $line = shift;
    my @command_parameters = split(/,/,$line);

    return @command_parameters;
};

sub command_factory {
    my $self = shift;
    my $line = shift;
    my @parameters = $self->$parse_line($line);
    my $command;
    
    given(shift @parameters){
        when (/A/){
            $command = AddUserCmd->new(@parameters);
        }
        when (/E/){
            $command = DelUserCmd->new(@parameters);         
        }
        when (/C/){
           $command = PurchaseCmd->new(@parameters); 
        }
        when (/D/){
            $command = DispatchCmd->new(@parameters);
        }
        when (/P/){
            $command = PostaPkgCmd->new(@parameters);
        }
        when (/R/){
            $command = ReceptionCmd->new(@parameters);    
        }
        when (/Y/){
            $command = StateOrderCmd->new(@parameters);
        }
        when (/Z/){
            $command = ItineraryCmd->new(@parameters);    
        }
        when (/T/){                             #test command.
            $command = shift;    
        }

        default{
            my $error = MyError->new("Error al parsear: ".$line);
            push $self->{'errors'}, $error;
        }
    } 

    if($command){
        push $self->{'commands'}, $command;
    }
      return $command;
}

sub run_commands {
    my $self = shift;
    my @list = @{$self->{'commands'}};
    my $text;
    for my $command (@list){
        my $output = $command->execute;
        if ($output->isa("MyError")) {
            $text.= "Error\n";
            push $self->{'errors'}, $output;
        }
       else {
            $text.= $output->get_output()."\n";
        }
    }
    return $text;
}

sub print_errors {
    my $self = shift;
    my @list =  @{$self->{'errors'}};
    my $text;
    for my $error (@list){
        $text .= $error->get_output()."\n";
    }
    return $text;
}

1;

