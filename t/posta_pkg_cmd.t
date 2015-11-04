#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use lib '../lib';
use PostaPkgCmd;

my $order_service = OrderServiceFake->new();
my ($order_number, $package_number, $location, $description, $date) =
    ('param1', 'param2', 'param3', 'param4', 'param5');
my $add_user_cmd = PostaPkgCmd->new($order_number, $package_number, $location, $description, $date);

my $result = $add_user_cmd->execute($order_service);
is ($result, "Todo ok", "Execute order service and return the result");

my $add_user_cmd1 = PostaPkgCmd->new($order_number, $package_number, 'jeje',
$description, $date);

my $result1 = $add_user_cmd1->execute($order_service);
is ($result1, "Todo nok :(", "Execute order service and return the other
    result");

done_testing();


package OrderServiceFake;

sub new {
    my $class = shift;
    my $self = {};
    return  bless $self, $class;
}

sub post_package {
    my $self = shift;
    my ($order_number, $package_number, $location, $description, $date) =  @_;

    if ($location eq 'param3') {
        return 'Todo ok'
    } else {
        return 'Todo nok :(';
    }
}