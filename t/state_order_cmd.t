#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use Test::MockModule;

use lib '../lib';
use StateOrderCmd;
use MyError;

my $module = Test::MockModule->new('OrderService');
$module->mock(state_order => sub{
    my $self = shift;
    my ($ord_num) = @_;
    if($ord_num eq '95332'){
        return Output->new("Pedido: 95332 \nNombre: jjlopez");
    }else {
        return MyError->new("El pedido '$ord_num' no fue encontrado");
    }
}
);

#check the status of an order
my @parameters = ('95332');
my $purchase_cmd = StateOrderCmd->new(@parameters);
my $output = $purchase_cmd->execute();
is( $output->get_output(), "Pedido: 95332 \nNombre: jjlopez", 'The status of the order has been shown' );

#error case
my @eparameters = ('50312');
my $epurchase_cmd = StateOrderCmd->new(@eparameters);
my $error = $epurchase_cmd->execute();
is( $error->get_output(), "El pedido '$eparameters[0]' no fue encontrado", "Error: the order does not exist");

done_testing();

1;
