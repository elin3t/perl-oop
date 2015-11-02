#!/usr/bin/perl
use strict;
use warnings;

package Order;

sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
    return $self;
}
sub toTest{
    return ':)ok!';
}
1;

use Test::More;# tests => 6;
use lib '../lib';
use User;

#User contructor must set all values
my $user = User->new('theUserName', 'thelastName', 'theName');

is($user->username,'theUserName', 'initial value of user name' );
is($user->first_name, 'theName', 'initial value of name' );
is($user->last_name, 'thelastName','initial value of lastName' );
is(scalar @{$user->get_order_list}, 0, 'initialize order list' );

my $order = Order->new();
$user->add_order($order);

is(scalar  @{$user->get_order_list},1, 'Check order list is present after add');
is(@{$user->get_order_list}[0]->toTest, ':)ok!', 'Check instance of order can be called');
done_testing();

