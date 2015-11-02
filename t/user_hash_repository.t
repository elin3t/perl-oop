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

my $userRepository2 = UserHashRepository->new();

my $userFinded1 = $userRepository2->find('the_username');

is($userFinded1->{username}, 'the_username', 'Check singleton works');

my $userDeleted = $userRepository->delete($user->username);

is($userDeleted, 1, 'Can delete user');

$userFinded = $userRepository->find('the_username');

is($userFinded, 0, 'Can delete user');

done_testing();

