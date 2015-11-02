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

use strict;
use warnings FATAL => 'all';
use v5.18;

package OrderService;

sub new {
    my $class = shift;
    my ($user_hash_repository, $order_hash_repository) = @_;
    my $self = bless {}, $class;

    $self->{'user_hash_repository'} = $user_hash_repository;
    $self->{'order_hash_repository'} = $order_hash_repository;

    return $self;
}

sub buy {
    my ($self,$user_id, $ord_num, $description, $amount_of_pkgs) = @_;
    my $user = $self{'user_hash_repository'}->find($user_id);
    if($user) {
        my $order = $self{'order_hash_repository'}->find($number);
        if(undef $order) {
            $order = Order->new($user_id, $ord_num, $description, $amount_of_pkgs);
            $self{'order_hash_repository'}->add($order);
            # Add package stubs to order
            for (my $i = 0; $i < $amount_of_pkgs; $i++) {
                $package = Package->new($i,"", "", "");
            }
            print "Success!!";
        } else {
            print "Error: order exists";
        }
    } else {
        print "Error: user not found";
    }
}

sub dispatch {
    my ($self, $ord_num, $pkg_num, $content, $location, $date) = @_;
    my ($order, $package, $itinerary);
    $order = $self{'order_hash_repository'}->find($ord_num);
    if($order) {
        # Check if the package already exist in the order
        foreach $pkg (@{$order->package_list()}) {
            if ($pkg->number() == $pkg_num) {
                $package = $pkg;
                last;
            }
        }
        if (undef $package) {
            $package = Package->new($pkg_num,"Enviado", $location, $content);
            $itinerary = Itinerary->new($ord_num, $location, $date, "Ubicacion inicial");
            $package->add_itinerary($itinerary);
            $order->add_package($package);
        } else {
            print "Error: package already exist in the order";
        }
    } else {
        print "Error: order not found";
    }
}

sub post_package {
    my ($self, $ord_num, $pkg_num, $location, $description, $date) = @_;
    my ($order, $package, $itinerary);
    $order = $self{'order_hash_repository'}->find($ord_num);
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
        } else {
            print "Error: package not found";
        }
    } else {
        print "Error: order not found";
    }
}

sub reception_package {
    my ($ord_num, $pkg_num, $location, $date) = @_;
    my ($order, $package, $itinerary);
    $order = $self{'order_hash_repository'}->find($ord_num);
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
    my ($order, $state, $user_id, $user, $pendientes, $despachados, $recibidos, $cant_pkg);
    $pendientes = 0;
    $despachados = 0;
    $recibidos = 0;
    $cant_pkg = 0;
    $order = $self{'order_hash_repository'}->find($ord_num);
    if($order) {
        $user_id = $order->user_id();
        $user = $self->{'user_hash_repository'}->find($user_id);
        if ($user) {
            foreach $pkg (@{$order->package_list()}) {
                $cant_pkg++;
                if ($pkg->state() == "") {
                    $pendientes++;
                }
                if ($pkg->state() == "Enviado") {
                    $despachados++;
                }
                if ($pkg->state() == "Recibido") {
                    $recibidos++;
                }
            }
            if ($pendientes == $cant_pkg ) {
                $state = "Pendiente";
            }
        } else {
            print "Error: user not found";
        }
    } else {
        print "Error: order not found";
    }
}

sub read_itinerary {
    my $ord_num = shift;
}

1;