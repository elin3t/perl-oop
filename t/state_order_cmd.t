#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

use lib '../lib';
use StateOrderCmd;
use Error;

#check the status of an order
my @parameters = ('95332');
my $purchase_cmd = StateOrderCmd->new(@parameters);
my $output = $purchase_cmd->execute(OrderServiceFake->new());
is( $output->get_output(), "Pedido: 95332 \nNombre: jjlopez", 'The status of the order has been shown' );

#error case
my @eparameters = ('50312');
my $epurchase_cmd = StateOrderCmd->new(@eparameters);
my $error = $epurchase_cmd->execute(OrderServiceFake->new());
is( $error->get_output(), "El pedido '$eparameters[0]' no fue encontrado", "Error: the order does not exist");


package OrderServiceFake;

sub new {
    my $class = shift;
    return bless {}, $class;
}

sub state_order{
    my $self = shift;
    my ($ord_num) = @_;
    if($ord_num eq '95332'){
        return Output->new("Pedido: 95332 \nNombre: jjlopez");
    }else {
        return Error->new("El pedido '$ord_num' no fue encontrado");
    }
}

1;
