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
    my $class = shift;a
    my ($user_id, $number, $description, $package_number) = @_; #order se construye con estos parametros.
    my $this = bless {}, $class;

    $this->{'user_id'} = $user_id;
    $this->{'number'} = $number;     
    $this->{'description'} = $description;
    $this->{'package_number'} = $package_number;
    $this->{'state'} = undef;
    $this->{'package_list'} = [];
    
    return $this;
}

sub get_user_id {
    return shift->{'user_id'};
}

sub get_number {
    return shift->{'number'};
}

sub get_description {
    return shift->{'description'};
}

sub get_state {
    return shift->{'state'};
}

sub set_state{
    $this = shift;
    $state = shift;
    $this->{'state'} = $state;
}
sub add_package {
    my $this = shift;
    my $new_package = shift;
    my $package_list = $this->{'package_list'};
    push $package_list, $new_package;
}

sub get_package_list {
    return shift->{'package_list'};
}

1;
