package UserService;
use strict;
use warnings FATAL => 'all';

use User_Hash_Repository;
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

    if (User_Hash_Repository::find($username))
    {
        return 0;
    }
    my $user = User->new($username, $last_name, $first_name);
    return User_Hash_Repository::add($user);
}

sub delete_user {
    my $self = shift;
    my $username = shift;
    my $user = User_Hash_Repository::find($username);
    if ($user)
    {
        return User_Hash_Repository::delete($user);

    }
    return 0;
}



1;