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
use Data::Dumper;
package P;

sub new {
    my $class = shift;
    my $name = $_[0];
    my $self = bless {}, $class;

    $self->{'name'} = $name;
    return $self;
}

sub name {
    return shift->{'name'};
}

sub state {
    return "Enviado";
}
1;

my $pack1 = P->new("p1");
my $pack2 = P->new("p2");
my $salida = $pack1->name;

use Test::More;# tests => 5;                      # last test to print
use lib '../lib/';
use Order;

my $order = Order->new("pauriarte",122,"detalles orden", 5);

is($order->user_id, "pauriarte", "user_id.");
is($order->number, 122, "number");
is($order->description, "detalles orden", "description");
is($order->state, "Pendiente", "initial state Pending");# Pending.
$order->add_package($pack1);
$order->add_package($pack2);
my @package_list = $order->package_list;
my ($p1,$p2) = @package_list;
is($p1->name(),"p1", "add_package");
is($p2->name(),"p2", "package_list");
is($order->state, "Despachando", "state Despachando");
done_testing();
