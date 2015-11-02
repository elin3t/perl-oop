#!/usr/bin/perl
use strict;
use warnings;

package User;

sub new {
    my $class = shift;
    my $username = shift;
    my $self = {
        username=>$username
    };
    bless $self, $class;
    return $self;
}
sub username {
    my $self = shift;
    return $self->{username};
}
1;

use Test::More;# tests => 6;
use lib '../lib';
use UserHashRepository;

my $userRepository = UserHashRepository->new();
my $user = User->new('the_username');

$userRepository->add($user);

my $userFinded = $userRepository->find('the_username');

is($userFinded->{username}, 'the_username', 'Can add user');

my $userDeleted = $userRepository->delete($user);

is($userDeleted->{username}, 'the_username', 'Can delete user');

$userFinded = $userRepository->find('the_username');

is($userFinded, -1, 'Can delete user');

done_testing();

