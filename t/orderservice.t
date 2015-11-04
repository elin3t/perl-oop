#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

use lib '../lib';
use UserService;
use OrderService;

my $user_service = UserService->new();
my $order_service = OrderService->new();
my $output;

# TEST 1
$output = $order_service->buy('testname','100','compra de prueba','10');
is($output->get_output(), 'Error: user not found', 'BUY 1 -->INEXISTENT USER');

# TEST 2
$user_service->add_user('testname','test_firstname', 'test_lastname');
$output = $order_service->buy('testname','100','compra de prueba','10');
is($output->get_output(), 'Compra \'100\' registrada', 'BUY 2 --> SUCCESSFUL ORDER CREATION');

# TEST 3
$output = $order_service->buy('testname','100','compra de prueba','10');
is($output->get_output(), 'Error: order exists', 'BUY 3 --> ORDER EXISTS');

# TEST 4
$output = $order_service->dispatch('200','5','Figuritas de luke skywalker', 'Globant NorthPark', '03112015');
is($output->get_output(), 'Error: order not found', 'DISPATCH 1 --> ORDER NOT FOUND');

# TEST 5
$user_service->add_user('dlalo','dlalo_firstname', 'dlalo_lastname');
$order_service->buy('dlalo','200','compra de prueba 2','2');
$output = $order_service->dispatch('200','1','Figuritas de luke skywalker', 'Globant NorthPark', '03112015');
is($output->get_output(), 'El paquete \'1\' del Pedido \'200\' despachado', 'DISPATCH 2 --> SUCCESSFUL DISPATCH');

# TEST 6
$order_service->buy('dlalo','300','compra de prueba 2','2');
$output = $order_service->dispatch('300','0','Figuritas de luke skywalker', 'Globant NorthPark', '03112015');
$output = $order_service->dispatch('300','1','Death Star', 'Globant NorthPark', '03112015');
$output = $order_service->dispatch('300','2','Millenium Hawk', 'Globant NorthPark', '03112015');
is($output->get_output(), 'Error: el pedido \'300\' ya posee todos los paquetes', 'DISPATCH 3 --> ALL ALREADY DISPATCHED');

# TEST 7
$output =$order_service->post_package('400','5', 'Aduana EZE', 'Bateria de celular thl W8+', '02112015');
is($output->get_output(), 'Error: order not found', 'POSTA PACKAGE 1 --> INEXISTENT ORDER');

# TEST 8
$order_service->buy('dlalo','400','compra de prueba 2','2');
$output = $order_service->post_package('400','5','Correo argentino - monserrat','posta Nro 2', '03112015');
is ($output->get_output(), 'Error: package not found', 'POSTA PACKAGE 2 --> PACKAGE NOT FOUND');

# TEST 9
$order_service->dispatch('400','1','Bateria de celular thl W8+', 'Aduana EZE', '02112015');
$output = $order_service->post_package('400','1','Correo argentino - monserrat','posta Nro 2', '03112015');
is ($output->get_output(),'Posta del paquete \'1\' del Pedido \'400\' registrada', 'POSTA PACKAGE 3 --> SUCCESSFUL ADD POSTA');

# TEST 10
$output = $order_service->reception_package('500','1', 'Aduana EZE', 'Bateria de celular thl W8+', '02112015');
is($output->get_output(), 'Error: order not found', 'RECEPTION PACKAGE 1 --> ORDER NOT FOUND');

# TEST 11
$output = $order_service->reception_package('400','5', 'Aduana EZE', 'Bateria de celular thl W8+', '02112015');
is($output->get_output(), 'Error: package not found', 'RECEPTION PACKAGE 2 --> PACKAGE NOT FOUND');

# TEST 12
$output = $order_service->reception_package('400','1', 'Mi casa!!', 'Bateria de celular thl W8+', '02112015');
is($output->get_output(), 'Paquete \'1\' del Pedido \'400\' recibido', 'RECEPTION PACKAGE 3 --> SUCCESSFUL RECEPTION');

# TEST 13
$output = $order_service->state_order('60');
is($output->get_output(), 'Error: order not found', 'STATE ORDER 1 --> ORDER NOT FOUND');

# TEST 14
$order_service->buy('dlalo','600','Elementos de cocina','2');
$output = $order_service->state_order('600');
is($output->get_output(), "Pedido: 600\nUsuario: dlalo\nNombre: dlalo_lastname, dlalo_firstname\nEstado: Pendiente\nPaquetes:\n", 'STATE ORDER 2 --> PENDIENTE');

# TEST 15
$order_service->dispatch('600','1','Microondas', 'Rodo sede microcentro', '02112015');
$output = $order_service->state_order('600');
is($output->get_output(), "Pedido: 600\nUsuario: dlalo\nNombre: dlalo_lastname, dlalo_firstname\nEstado: Despachando\nPaquetes:\n 1: Microondas - Rodo sede microcentro\n", 'STATE ORDER 3 --> DESPACHANDO');

# TEST 16
$order_service->dispatch('600','2','Lavarropas', 'Rodo sede boedo', '03112015');
$output = $order_service->state_order('600');
is($output->get_output(), "Pedido: 600\nUsuario: dlalo\nNombre: dlalo_lastname, dlalo_firstname\nEstado: Enviado\nPaquetes:\n 1: Microondas - Rodo sede microcentro\n 2: Lavarropas - Rodo sede boedo\n",'STATE ORDER 4 --> ENVIADO');

# TEST 17
$order_service->reception_package('600','1', 'Mi casa', '04112015');
$order_service->reception_package('600','2', 'Mi casa', '04112015');
$output = $order_service->state_order('600');
is($output->get_output(), "Pedido: 600\nUsuario: dlalo\nNombre: dlalo_lastname, dlalo_firstname\nEstado: Entregado\nPaquetes:\n 1: Microondas - Rodo sede microcentro\n 2: Lavarropas - Rodo sede boedo\n", 'STATE ORDER 5 --> ENTREGADO');

# TEST 18
$output = $order_service->read_itinerary('700');
is($output->get_output(), 'Error: order not found', 'READ ITINERARY 1 --> ORDER NOT FOUND');


$order_service->buy('dlalo','700','Elementos de jardin','2');


done_testing();