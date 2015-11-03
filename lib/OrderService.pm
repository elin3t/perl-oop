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
use Output;
use Error;

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
        my $order = $order_repo->find($ord_num);
        if($order) {
            my $error = Error->new("Error: order exists");
            return $error;
        } else {
            $order = Order->new($user_id, $ord_num, $description, $amount_of_pkgs);
            $order_repo->add($order);
            my $output = Output->new("Compra '$ord_num' registrada");
            return $output;

        }
    } else {
        my $error = Error->new("Error: user not found");
        return $error;
    }
}

sub dispatch {
    my $self = shift;
    my ($ord_num, $pkg_num, $content, $location, $date) = @_;
    my ($order, $package, $itinerary);
    my $order_repo = OrderHashRepository->new();
    $order = $order_repo->find($ord_num);
    if($order) {
        # Check the amount of packages dispatched
        if ($order->package_list() < $order->package_number()) {
            $package = Package->new($pkg_num, $location, $content);
            $itinerary = Itinerary->new($ord_num, $location, $date, "Ubicacion inicial");
            $package->add_itinerary($itinerary);
            $order->add_package($package);
            my $output = Output->new("El paquete '$pkg_num' del Pedido '$ord_num' despachado");
            return $output;
        } else {
            my $error = Error->new("Error: el pedido '$ord_num' ya posee todos los paquetes");
            return $error;
        }
    } else {
        my $error = Error->new("Error: order not found");
        return $error;
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
        foreach my $pkg ($order->package_list()) {
            if ($pkg->number() == $pkg_num) {
                $package = $pkg;
                last;
            }
        }
        if ($package) {
            $itinerary = Itinerary->new($ord_num, $location, $date, $description);
            $package->add_itinerary($itinerary);
            my $output = Output->new("Posta del paquete '$pkg_num' del Pedido '$ord_num' registrada");
            return $output;
        } else {
            my $error = Error->new("Error: package not found");
            return $error;
        }
    } else {
        my $error = Error->new("Error: order not found");
        return $error;
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
        foreach my $pkg ($order->package_list()) {
            if ($pkg->number() == $pkg_num) {
                $package = $pkg;
                last;
            }
        }
        if ($package) {
            $itinerary = Itinerary->new($ord_num, $location, $date, "Recibido");
            $package->add_itinerary($itinerary);
            $package->set_state("Recibido");
            my $output = Output->new("Paquete '$pkg_num' del Pedido '$ord_num' recibido");
            return $output;
        } else {
            my $error = Error->new("Error: package not found");
            return $error;
        }
    } else {
        my $error = Error->new("Error: order not found");
        return $error;
    }
}

sub state_order {
    my $self = shift;
    my $ord_num = shift;
    my ($order, $user_id, $user, $str_out);
    my $user_repo = UserHashRepository->new();
    my $order_repo = OrderHashRepository->new();
    $order = $order_repo->find($ord_num);
    if($order) {
        $user_id = $order->user_id();
        $user = $user_repo->find($user_id);
        $str_out = "Pedido: " . $order->number() . "\n";
        $str_out .= "Usuario: " .  $user->username() ."\n";
        $str_out .= "Nombre: ". $user->last_name() . ", " . $user->first_name() . "\n";
        $str_out .= "Estado: " . $order->state() . "\n";
        $str_out .= "Paquetes:\n";
        foreach my $pkg ($order->package_list()) {
        	$str_out .= " ". $pkg->number(). ": " . $pkg->contents() . "-" .  $pkg->location() . "\n";
	    }
        my $output = Output->new($str_out);
        return $output;
    } else {
        my $error = Error->new("Error: order not found");
        return $error;
    }
}

sub read_itinerary {
    my $self = shift;
    my $ord_num = shift;
    my ($order, $user_id, $user, $str_out);
    my $user_repo = UserHashRepository->new();
    my $order_repo = OrderHashRepository->new();
    $order = $order_repo->find($ord_num);
    if($order) {
        $user_id = $order->user_id();
        $user = $user_repo->find($user_id);
        $str_out = "Pedido: $order->number()\n";
        $str_out .= "Usuario: $user->username()\n";
        $str_out .= "Nombre: $user->last_name(), $user->first_name()\n";
        $str_out .= "Estado: $order->state()\n";
        foreach my $pkg (@{$order->package_list()}) {
            $str_out .= "Itinerario: \n";
            $str_out .= "          $pkg->number(): $pkg->contents() - ";
            foreach my $itinerary (@{$pkg->itineraries()}) {
                $str_out .= "$itinerary->location() ($itinerary->date()), $itinerary->description()\n";
            }
        }
        my $output = Output->new($str_out);
        return $output;
    } else {
        my $error = Error->new("Error: order not found");
        return $error;
    }
}

1;
