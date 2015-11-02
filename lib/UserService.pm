package UserService;
use strict;
use warnings FATAL => 'all';

use UserHashRepository;
use User;

my $singleton_user_service = undef;

sub new {
    my $class = shift;

    return $singleton_user_service if defined $singleton_user_service;

    my $self = {};
    $singleton_user_service = bless $self, $class;
    return $singleton_user_service;
}

sub add_user {
    my $self = shift;
    my ($username, $first_name, $last_name) = @_;
    my $userRepository = UserHashRepository->new();
    if ($userRepository->find($username))
    {
        return 0;
    }
    my $user = User->new($username, $last_name, $first_name);
    return $userRepository->add($user);
}

sub delete_user {
    my $self = shift;
    my $username = shift;
    my $userRepository = UserHashRepository->new();
    my $user = $userRepository->find($username);
    if ($user)
    {
        return $userRepository->delete($username);

    }
    return 0;
}



1;