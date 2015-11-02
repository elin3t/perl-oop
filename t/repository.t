#!/usr/bin/perl
use strict;
use warnings;

package Item;

sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
    return $self;
}
sub set_value {
    my $self = shift;
    my $value = shift;
    $self->{value} = $value;
}
sub toTest{
    return ':)ok!';
}
1;

use Test::More;# tests => 6;
use lib '../lib';
use Repository;

my $repository = Repository->new();
my $item = Item->new();
$item->set_value('a value');

my $item2 = Item->new();
$item2->set_value('a value2');

$repository->add('theKey', $item);
$repository->add('theKey2', $item2);

my $auxItem = $repository->find('theKey');
is($auxItem->{value}, 'a value', 'Find element by key' );

my $auxItem1 = $repository->find('theKey2');
is($auxItem1->{value}, 'a value2', 'Find element by other key' );

my $auxItem2 = $repository->find('theKey3');
is($auxItem2, 0, 'Find unexistent element by key' );

my $items = $repository->list();

my $count = keys $items;
is($count, 2, 'List items' );
is($items->{theKey}->{value} , 'a value', 'List items' );
is($items->{theKey2}->{value} , 'a value2', 'List items' );


my $count1 = keys $repository->{items};
is($count1, 2, 'Add element to items' );

my $result = $repository->delete('theKey2');
my $resultNotKey = $repository->delete('notKey');
is($result ,1, 'Remove element' );

my $count2 = keys $repository->{items};
is($count2, 1, 'Remove element' );

done_testing();

