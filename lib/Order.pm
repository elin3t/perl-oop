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

package Order;

sub new {
    my $class = shift;
    my ($user_id, $number, $description, $package_number) = @_; #order se construye con estos parametros.
    my $self = bless {}, $class;

    $self->{'user_id'} = $user_id;
    $self->{'number'} = $number;     
    $self->{'description'} = $description;
    $self->{'package_number'} = $package_number;
    $self->{'state'} = "Pendiente";#Pending
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
    my $self = shift;
    my $send = 0;
    my $received = 0;
    my $state = $self->{'state'};
    
    foreach my $pkg ($self->package_list()) {
	    if($pkg->state() eq "Enviado") {
	        $send++;
	    }
	    elsif($pkg->state() eq "Recibido") {
	        $received++;
	    }
    }

    if($send == 0 && $received == 0){
	    $state = "Pendiente";
    }
    elsif($send >= 1 && $send < $self->package_number()){
        $state = "Despachando";
    }
    elsif($send == $self->package_number()){
	    $state = "Enviado";
    }
    elsif($received == $self->package_number()){
	    $state = "Entregado";
    }

    $self->{'state'} = $state;

    return $state;
}

sub add_package {
    my $self = shift;
    my $new_package = shift;
    push $self->{'package_list'}, $new_package;
}

sub package_list {
    return @{shift->{'package_list'}};
}

sub package_number {
    return shift->{'package_number'};
}

1;
