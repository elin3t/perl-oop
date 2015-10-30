#
#===============================================================================
#
#         FILE: order.t
#
#  DESCRIPTION: 
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 30/10/15 16:03:01
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use v5.18;
package P;

sub new {
    my $class = shift;
    my $name = @_;
    my $self = bless {}, $class;

    $self->{'name'} = $name;
    return $self;
}

sub name {
    return shift->{'name'};
}
1;

my $pack1 = P->new("p1");
my $pack2 = P->new("p2");
my $salida = $pack1->name;

use Test::More;# tests => 5;                      # last test to print
use lib '../lib/';
use Order;

my $order = Order->new("pauriarte",122,"detalles orden",1);

is($order->user_id, "pauriarte", "user_id.");
is($order->number, 122, "number");
is($order->description, "detalles orden", "description");
is($order->state, 0, "state");# Pending.
$order->set_state(1); 
is($order->state, 1, "set_state");
#$order->add_package(\$pack1);
#$order->add_package(\$pack2);
#my @package_list = $order->package_list;
#my $pack = $package_list[0];
#is($pack->name,"p1", "add_package");
#is($order->state, 1, "set_state");

done_testing();
