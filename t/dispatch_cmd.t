#!/usr/bin/perl
#use strict;
use warnings;
use Test::More;

use lib '../lib';
use DispatchCmd;
use Error;

my @parameters = ('12345', '54321', 'Figura coleccionable de Darth Vader','Indianapolis-USA', '20151102');
my $dispatch_cmd = DispatchCmd->new(@parameters);
my $output = $dispatch_cmd->execute(OrderServiceFake->new());
is($output->get_output(),"El paquete '$parameters[1]' del pedido '$parameters[0]' despachado", "correct package dispatch");


my @parameters1 = ('99999', '54321', 'Figura coleccionable de Darth Vader','Indianapolis-USA', '20151102');
$dispatch_cmd = DispatchCmd->new(@parameters1);
my $output1 = $dispatch_cmd->execute(OrderServiceFake->new());
is($output1->get_output(),"El pedido '$parameters1[0]' ya posee todos los paquetes", "full order in dispatch");

my @parameters2 = ('33333', '54321', 'Figura coleccionable de Darth Vader','Indianapolis-USA', '20151102');
$dispatch_cmd = DispatchCmd->new(@parameters2);
my $output2 = $dispatch_cmd->execute(OrderServiceFake->new());
is($output2->get_output(),"El pedido '$parameters2[0]' no fue encontrado", "order not found");


done_testing();

package OrderServiceFake;

sub new {
    my $class = shift;
    return bless {}, $class;
}

sub dispatch{
    my $self = shift;
    my ($order, $package , $content, $location, $date) = @_;
    if($order eq "33333"){
        return Error->new("El pedido '33333' no fue encontrado");
    }elsif($order eq "99999"){
        return Error->new("El pedido '99999' ya posee todos los paquetes");
    }
    return Output->new("El paquete '$package' del pedido '$order' despachado");
}
1;
