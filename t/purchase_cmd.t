#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use Test::MockModule;

use lib '../lib';
use PurchaseCmd;
use MyError;

my $module = Test::MockModule->new('OrderService');
$module->mock(buy => sub{
    my $self = shift;
    my ($user_id, $ord_num, $description, $amount_of_pkgs) = @_;
    if($ord_num eq "95332"){
        return MyError->new("El pedido '95332' ya fue ingresado al sistema");
    }elsif($user_id eq "jjlopez"){
        return Output->new("Compra '$ord_num' registrada");
    }
    return MyError->new("El usuario '$user_id' no fue encontrado");
}
);

#create one order to test
my @parameters = ('jjlopez', '50312', 'paquete de prueba', '3');
my $purchase_cmd = PurchaseCmd->new(@parameters);
my $output = $purchase_cmd->execute();
is( $output->get_output(), "Compra '$parameters[1]' registrada", 'The order has been added' );

#error cases
my @eparameters = ('jjlopez1', '95332', 'paquete de prueba', '3');
my $epurchase_cmd = PurchaseCmd->new(@eparameters);
my $error = $epurchase_cmd->execute();
is( $error->get_output(), "El pedido '$eparameters[1]' ya fue ingresado al sistema", "Error: order non exists");

my @eparameters1 = ('lopez1', '50312', 'paquete de prueba', '3');
my $epurchase_cmd1 = PurchaseCmd->new(@eparameters1);
my $error1 = $epurchase_cmd1->execute();
is( $error1->get_output(), "El usuario '$eparameters1[0]' no fue encontrado", "Error: user non exists");

done_testing();

1;