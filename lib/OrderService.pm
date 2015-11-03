package OrderService;
use strict;
use warnings FATAL => 'all';

use UserHashRepository;
use OrderHashRepository;

use User;
use Order;

sub buy {
    my $self = shift;
    my ($user_id, $ord_num, $description, $amount_of_pkgs) = @_;
    my $user_repo = UserHashRepository->new();
    my $order_repo = OrderHashRepository->new();
    my $user = $user_repo->find($user_id);
    if($user) {
        my $order = $order_repo->find($ord_num);
        if(undef $order) {
            $order = Order->new($user_id, $ord_num, $description, $amount_of_pkgs);
            $order_repo->add($order);
            print "Compra '$ord_num' registrada";
            return "hola mundo";
        } else {
            print "Error: order exists";
        }
    } else {
        print "Error: user not found";
    }
}


1;