#===============================================================================
#
#         FILE: OrderService.pm
#
#  DESCRIPTION:
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Israel Diego Lalo (),
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 02/11/15 15:04:32
#     REVISION: ---
#===============================================================================

package OrderService;

use strict;
use warnings FATAL => 'all';

use UserHashRepository;
use OrderHashRepository;
use User;
use Order;
use Itinerary;
use Package;

my $singleton_order_service = undef;

sub new {
    my $class = shift;

    return $singleton_order_service if defined $singleton_order_service;

    my $self = {};
    $singleton_order_service = bless $self, $class;
    return $singleton_order_service;
}

sub buy {
    my $self = shift;
    my ($user_id, $ord_num, $description, $amount_of_pkgs) = @_;
    my $user_repo = UserHashRepository->new();
    my $order_repo = OrderHashRepository->new();
    my $user = $user_repo->find($user_id);
    if($user) {
        my $order = $order_repo->find($number);
        if(undef $order) {
            $order = Order->new($user_id, $ord_num, $description, $amount_of_pkgs);
            $order_repo->add($order);
            print "Compra '$ord_num' registrada";
        } else {
            print "Error: order exists";
        }
    } else {
        print "Error: user not found";
    }
}

sub dispatch {
    my $self = shift;
    my ($ord_num, $pkg_num, $content, $location, $date) = @_;
    my ($order, $package, $itinerary);
    my $order_repo = OrderHashRepository->new();
    $order = $order_repo->find($ord_num);
    if($order) {
        # Check if the package already exist in the order
        foreach $pkg (@{$order->package_list()}) {
            if ($pkg->number() == $pkg_num) {
                $package = $pkg;
                last;
            }
        }
        if ($package) {
            $package = Package->new($pkg_num,"Enviado", $location, $content);
            $itinerary = Itinerary->new($ord_num, $location, $date, "Ubicacion inicial");
            $package->add_itinerary($itinerary);
            $order->add_package($package);
            print "El paquete '$pkg_num' del Pedido '$ord_num' despachado";
        } else {
            print "Error: package $pkg_num doesn't exist in the order";
        }
    } else {
        print "Error: order not found";
    }
}

sub post_package {
    my $self = shift;
    my ($ord_num, $pkg_num, $location, $description, $date) = @_;
    my ($order, $package, $itinerary);
    my $order_repo = OrderHashRepository->new();
    $order = $order_repo->find($ord_num);
    if($order) {
        # Search package
        foreach $pkg (@{$order->package_list()}) {
            if ($pkg->number() == $pkg_num) {
                $package = $pkg;
                last;
            }
        }
        if ($package) {
            $itinerary = Itinerary->new($ord_num, $location, $date, $description);
            $package->add_itinerary($itinerary);
            print "Posta del paquete '$pkg_num' del Pedido '$ord_num' registrada";
        } else {
            print "Error: package not found";
        }
    } else {
        print "Error: order not found";
    }
}

sub reception_package {
    my $self = shift;
    my ($ord_num, $pkg_num, $location, $date) = @_;
    my ($order, $package, $itinerary);
    my $order_repo = OrderHashRepository->new();
    $order = $order_repo->find($ord_num);
    if($order) {
        # Search package
        foreach $pkg (@{$order->package_list()}) {
            if ($pkg->number() == $pkg_num) {
                $package = $pkg;
                last;
            }
        }
        if ($package) {
            $itinerary = Itinerary->new($ord_num, $location, $date, "Recibido");
            $package->add_itinerary($itinerary);
            $package->set_state("Recibido");
            print "Paquete '$pkg_num' del Pedido '$ord_num' recibido\n";
        } else {
            print "Error: package not found";
        }
    } else {
        print "Error: order not found";
    }
}

sub state_order {
    my $self = shift;
    my $ord_num = shift;
    my ($order, $user_id, $user);
    my $user_repo = UserHashRepository->new();
    my $order_repo = OrderHashRepository->new();
    $order = $order_repo->find($ord_num);
    if($order) {
        $user_id = $order->user_id();
        $user = $user_repo->find($user_id);
        print "Pedido: $order->number()\n";
        print "Usuario: $user->username()\n";
        print "Nombre: $user->last_name(), $user->first_name()\n";
        print "Estado: $order->state()\n";
        print "Paquetes:\n";
        foreach $pkg (@{$order->package_list()}) {
        	print " $pkg->number(): $pkg->contents() - $pkg->location()\n";
	}
    } else {
        print "Error: order not found";
    }
}

sub read_itinerary {
    my $self = shift;
    my $ord_num = shift;
    my ($order, $user_id, $user);
    my $user_repo = UserHashRepository->new();
    my $order_repo = OrderHashRepository->new();
    $order = $order_repo->find($ord_num);
    if($order) {
        $user_id = $order->user_id();
        $user = $user_repo->find($user_id);
        if ($user) {
            print "Pedido: $order->number()\n";
            print "Usuario: $user->username()\n";
            print "Nombre: $user->last_name(), $user->first_name()\n";
            print "Estado: $order->state()\n";
            foreach $pkg (@{$order->package_list()}) {
                print "Itinerario: \n";
                print "          $pkg->number(): $pkg->contents() - ";
                foreach $itinerary (@{$pkg->itineraries()}) {
                    print "$itinerary->location() ($itinerary->date()), $itinerary->description()\n";
                }
            }
        } else {
            print "Error: user not found";
        }
    } else {
        print "Error: order not found";
    }
}

1;
