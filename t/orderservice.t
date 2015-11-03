#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

use lib '../lib';
use UserService;
use OrderService;

my $user_service = UserService->new();
my $order_service = OrderService->new();

# BUY
# Inexistent user
is($order_service->buy('testname','100','compra de prueba','10'), 0, 'Error: user not found');
# Successful buy
$user_service->add_user('testname','test_firstname', 'test_lastname');
is($order_service->buy('testname','100','compra de prueba','10'), 1, 'Compra \'100\' registrada');
# Order exists
is($order_service->buy('testname','100','compra de prueba','10'), 0, 'Error: order exists');

# DISPATCH
# Inexistent order
is($order_service->dispatch('200','5','Figuritas de luke skywalker', 'Globant NorthPark', '03112015'), 0, 'Error: order not found');
# Inexistent package
$user_service->add_user('dlalo','dlalo_firstname', 'dlalo_lastname');
$order_service->buy('dlalo','200','compra de prueba 2','2');
is($order_service->dispatch('200','5','Figuritas de luke skywalker', 'Globant NorthPark', '03112015'), 0, 'Error: package 5 doesn\'t exist in the order');
# Successful dispatch
$order_service->buy('dlalo','300','compra de prueba 2','7');
is($order_service->dispatch('300','5','Figuritas de luke skywalker', 'Globant NorthPark', '03112015'), 1, 'El paquete \'5\' del pedido \'300\' despachado');

#POST_PACKAGE
# Inexistent order
is($order_service->post_package('400','5', 'Aduana EZE', 'Bateria de celular thl W8+', '02112015'), 0, 'Error: order not found');
# Inexistent package
$order_service->buy('dlalo','400','compra de prueba 2','2');
is ($order_service->post_package('400','5','Correo argentino - monserrat','posta Nro 2', '03112015'), 0, 'Error: package not found');
# Successful post
$order_service->dispatch('400','1','Bateria de celular thl W8+', 'Aduana EZE', '02112015');
is ($order_service->post_package('400','1','Correo argentino - monserrat','posta Nro 2', '03112015'), 1, 'Posta del paquete \'1\' del pedido \'400\' registrada');

# RECEPTION_PACKAGE
# Inexistent order
is($order_service->reception_package('500','1', 'Aduana EZE', 'Bateria de celular thl W8+', '02112015'), 0, 'Error: order not found');
# Inexistent package
is($order_service->reception_package('400','5', 'Aduana EZE', 'Bateria de celular thl W8+', '02112015'), 0, 'Error: package not found');
# Successful reception
is($order_service->reception_package('400','1', 'Mi casa!!', 'Bateria de celular thl W8+', '02112015'), 1, 'Paquete \'1\' del pedido \'400\' recibido');

# State order
# Inexistent order
is($order_service->state_order('60'), 0, 'Error: order not found');
# State Pendiente
$order_service->buy('dlalo','600','Elementos de cocina','2');
is($order_service->state_order('600'), 1, 'Pedido: 600\nUsuario: dlalo\nNombre: dlalo_lastname, dlalo_firstname\nEstado: Pendiente\nPaquetes:\n');
# State Despachando
$order_service->dispatch('600','1','Microondas', 'Rodo sede microcentro', '02112015');
is($order_service->state_order('600'), 1, 'Pedido: 600\nUsuario: dlalo\nNombre: dlalo_lastname, dlalo_firstname\nEstado: Despachando\nPaquetes:\n 1: Microondas - Rodo sede microcentro\n');
# State Enviado
$order_service->dispatch('600','2','Lavarropas', 'Rodo sede boedo', '03112015');
is($order_service->state_order('600'), 1, 'Pedido: 600\nUsuario: dlalo\nNombre: dlalo_lastname, dlalo_firstname\nEstado: Enviado\nPaquetes:\n 1: Microondas - Rodo sede microcentro\n 2: Lavarropas - Rodo sede boedo\n');
# State entregado
$order_service->reception_package('600','1', 'Mi casa', '04112015');
$order_service->reception_package('600','2', 'Mi casa', '04112015');
is($order_service->state_order('600'), 1, 'Pedido: 600\nUsuario: dlalo\nNombre: dlalo_lastname, dlalo_firstname\nEstado: Entregado\nPaquetes:\n 1: Microondas - Rodo sede microcentro\n 2: Lavarropas - Rodo sede boedo\n');

done_testing();