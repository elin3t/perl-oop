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
    
     
    use v5.18; 
    given(shift @parameters){
        when (/A/){
            $command = AddUserCmd->new();
        }
        when (/E/){
            $command = DelUserCmd->new();         
        }
        when (/C/){
           $command = PurchaseCmd->new(); 
        }
        when (/D/){
            $command = DispatchCmd->new();
        }
        when (/P/){
            $command = PostaPkgCmd->new();
        }
        when (/R/){
            $command = ReceptionCmd->new();    
        }
        when (/Y/){
            $command = StateOrderCmd->new();
        }
        when (/Z/){
            $command = ItineraryCmd->new();    
        }
        when (/T/){                             #test command.
            $command = shift;    
        }

        default{
            my $error = Error->new("Error al parsear: ".$line);
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
        if ($output->isa("Error")) {
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

