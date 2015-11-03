#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

use lib '../lib';
use PurchaseCmd;
use Error;

#create one order to test
my @parameters = ('jjlopez', '50312', 'paquete de prueba', '3');
my $purchase_cmd = PurchaseCmd->new(@parameters);
my $output = $purchase_cmd->execute(OrderServiceFake->new());
is( $output->get_output(), "Compra '$parameters[1]' registrada", 'The order has been added' );

#error cases
my @eparameters = ('jjlopez1', '95332', 'paquete de prueba', '3');
my $epurchase_cmd = PurchaseCmd->new(@eparameters);
my $error = $epurchase_cmd->execute(OrderServiceFake->new());
is( $error->get_output(), "El pedido '$eparameters[1]' ya fue ingresado al sistema", "Error: order non exists");

my @eparameters1 = ('lopez1', '50312', 'paquete de prueba', '3');
my $epurchase_cmd1 = PurchaseCmd->new(@eparameters1);
my $error1 = $epurchase_cmd1->execute(OrderServiceFake->new());
is( $error1->get_output(), "El usuario '$eparameters1[0]' no fue encontrado", "Error: user non exists");
done_testing();

package OrderServiceFake;

sub new {
    my $class = shift;
    return bless {}, $class;
}

sub buy{
    my $self = shift;
    my ($user_id, $ord_num, $description, $amount_of_pkgs) = @_;
    if($ord_num eq "95332"){
        return Error->new("El pedido '95332' ya fue ingresado al sistema");
    }elsif($user_id eq "jjlopez"){
        return Output->new("Compra '$ord_num' registrada");
    }
    return Error->new("El usuario '$user_id' no fue encontrado");
}

1;