#
#===============================================================================
#
#         FILE: Order.pm
#
#  DESCRIPTION: 
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 30/10/15 14:32:32
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use v5.18; 
package Order;

sub new {
    my $class = shift;
    my ($user_id, $number, $description, $package_number) = @_; #order se construye con estos parametros.
    my $self = bless {}, $class;

    $self->{'user_id'} = $user_id;
    $self->{'number'} = $number;     
    $self->{'description'} = $description;
    $self->{'package_number'} = $package_number;
   # use enum qw (hola mundhola mundoo);
   # say hola;
    $self->{'state'} = 0;#Pending
    $self->{'package_list'} = [];
    
    return $self;
}

sub user_id {
    return shift->{'user_id'};
}

sub number {
    return shift->{'number'};
}

sub description {
    return shift->{'description'};
}

sub state {
    return shift->{'state'};
}

sub set_state{
    my $self = shift;
    my $state = shift;
    $self->{'state'} = $state;
}
sub add_package {
    my $self = shift;
    my $new_package = shift;
    my @package_list = ;
    push @{$self->{'package_list'}}, $new_package;
}

sub package_list {
    return shift->{'package_list'};
}

1;
