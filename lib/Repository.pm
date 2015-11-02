package Repository;
use strict;
use warnings FATAL => 'all';

sub new {
    my $class = shift;
    my $self = {
        items=> {}
    };
    bless $self, $class;
    return $self;
}
sub add{
    my $self = shift;
    my $key = shift;
    my $object = shift;
    return $self->{items}{$key} = $object;
}

sub delete{
    my $self = shift;
    my $key = shift;
    my $result = delete $self->{items}{$key};
    if ($result) {
        return $result;
    } else {
        return -1;
    }
}

sub find{
    my $self = shift;
    my $key = shift;
    if (exists $self->{items}{$key}) {
        return $self->{items}{$key};
    }
    else {
        return -1;
    }
}

sub list{
   my $self = shift;
   return $self->{items};
}
1;