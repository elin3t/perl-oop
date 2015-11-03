package OrderService;
use strict;
use warnings FATAL => 'all';

sub new {
    my $class = shift;
    return bless {}, $class;
}

sub buy{
    my $self = shift;
    my ($user_id, $ord_num, $description, $amount_of_pkgs) = @_;
    if($ord_num eq "95332"){
        return Error->new("El pedido '95332' ya fue ingresado al sistema");
    }elsif($user_id eq "jjlopez"){
        return Output->new("Compra '$ord_num' registrada");
    }
    return Error->new("El usuario '$user_id' no fue encontrado");
}

1;