#!/usr/bin/perl
use strict;
use warnings;

package Order;

sub new {
    my $class = shift;
    my $number = shift;
    my $self = {
        number=>$number
    };
    bless $self, $class;
    return $self;
}
sub number {
    my $self = shift;
    return $self->{number};
}
1;

use Test::More;# tests => 6;
use lib '../lib';
use OrderHashRepository;

my $orderRepository = OrderHashRepository->new();
my $order = Order->new('the_number');

$orderRepository->add($order);

my $orderFinded = $orderRepository->find('the_number');

is($orderFinded->{number}, 'the_number', 'Can add order');

my $orderDeleted = $orderRepository->delete($order->number);

is($orderDeleted, 1, 'Can delete order');

$orderFinded = $orderRepository->find('the_number');

is($orderFinded, 0, 'Can delete order');

done_testing();

