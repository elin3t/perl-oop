package User;
use strict;
use warnings FATAL => 'all';

sub new {
    my $class = shift;
    my ($user_name, $last_name, $name) = @_;
    my $self = {
        username => $user_name,
        first_name => $name,
        last_name => $last_name,
        order_list => []
        };
    bless $self, $class;
    return $self;
}
sub username{
    my $self = shift;
    return $self->{username};
}

sub first_name{
    my $self = shift;
    return $self->{first_name};
}

sub last_name{
    my $self = shift;
    return $self->{last_name};
}

sub add_order{
   my $self = shift;
   my $order = shift;
   push( @{ $self->{order_list} }, $order );
}

sub get_order_list {
    my $self = shift;
    return $self->{order_list};
}
1;