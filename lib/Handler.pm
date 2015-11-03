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
use v5.18;
use AddUserCmd;
use DelUserCmd;
#use PurchaseCmd;
use PostaPkgCmd;
#use DispatchCmd;
use ReceptionCmd;
#use StateOrderCmd;
use ItineraryCmd;
use Error;

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
            $command = AddUserCmd->new();
            push $self->{'commands'}, $command;
        }
        when (/E/){
            $command = DelUserCmd->new();         
            push $self->{'commands'}, $command;
        }
        when (/C/){
           $command = PurchaseCmd->new(); 
            push $self->{'commands'}, $command;
        }
        when (/D/){
            $command = DispatchCmd->new();
            push $self->{'commands'}, $command;
        }
        when (/P/){
            $command = PostaPkgCmd->new();
            push $self->{'commands'}, $command;
        }
        when (/R/){
            $command = ReceptionCmd->new();    
            push $self->{'commands'}, $command;
        }
        when (/Y/){
            $command = StateOrderCmd->new();
            push $self->{'commands'}, $command;
        }
        when (/Z/){
            $command = ItineraryCmd->new();    
            push $self->{'commands'}, $command;
        }

        default{
            my $error = Error->new("Error al parsear: ".$line);
            push $self->{'errors'}, $error;
        }
    }   
      return $command;
}

sub run_command {
    my $self = shift;
    my @list = @{$self->{'commands'}};

    for my $command (@list){
        my $output = $command->execute;
        if ($output->isa("Error")) {
            push $self->{'errors'}, $output;
        }
        else {
            say $output->get_output();
        }
    }
}

sub print_errors {
    my $self = shift;
    my @list =  @{$self->{'errors'}};
    
    for my $error (@list){
        die $error->get_output();
    }
}

1;

