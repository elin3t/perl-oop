#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use Test::MockModule;

use lib '../lib';
use ReceptionCmd;
use MyError;

my $module = Test::MockModule->new('OrderService');
$module->mock(reception_package => sub{
    my $self = shift;
    my ($order, $package, $location, $date) = @_;
    if($order eq "11111"){
        return MyError->new("El pedido '11111' no fue encontrado");
    }elsif($package eq "999"){
        return MyError->new("El paquete '999' no fue encontrado");
    }
    return Output->new("El paquete '$package' del pedido '$order' recibido");
}
);

my @parameters = ('12345', '54321', 'Cabillito JM Moreno 200', '20151102');
my $recpetioncmd = ReceptionCmd->new(@parameters);
my $output = $recpetioncmd->execute();
is( $output->get_output(), "El paquete '$parameters[1]' del pedido '$parameters[0]' recibido", "correct package reception");

#error cases
my @eparameters = ('11111', '54321', 'Cabillito JM Moreno 200', '20151102');
my $recpetioncmde = ReceptionCmd->new(@eparameters);
my $error = $recpetioncmde->execute();
is( $error->get_output(), "El pedido '$eparameters[0]' no fue encontrado", "Error: order non exists");

my @eparameters1 = ('12345', '999', 'Cabillito JM Moreno 200', '20151102');
my $recpetioncmde1 = ReceptionCmd->new(@eparameters1);
my $error1 = $recpetioncmde1->execute();
is( $error1->get_output(), "El paquete '$eparameters1[1]' no fue encontrado", "Error: package non exists");

done_testing();

1;
