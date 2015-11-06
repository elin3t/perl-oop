use strict;
use warnings FATAL => 'all';
use parent 'Repository';


package OrderHashRepository;
use Package;
use Order;
use Itinerary;

our @ISA = qw(Repository);

sub add{
    my $self = shift;
    my $order = shift;

    if ($self->SUPER::find($order->number)) {
        return 0
    } else {
        $self->SUPER::add($order->number, $order);
        return 1;
    }
}

my $build_objects = sub {
    my $self = shift;
    my $order_number = shift;

    my $stmt_order = $self->sql_order_query();

    $stmt_order->execute($order_number);
    my (@row) = $stmt_order->fetchrow_array;
    if (!@row) {
        return 0;
    }
    my $order = Order->new(@row);

    my $stmt_package = $self->sql_package_query();
    $stmt_package->execute($order->number);
    while (my @package = $stmt_package->fetchrow_array) {

        my $package = Package->new(@package);
        $order->add_package($package);

        my $stmt_itinerary = $self->sql_itinerary_query();
        $stmt_itinerary->execute($package->number);
        while (my @itinerary = $stmt_itinerary->fetchrow_array) {
            my $itinerary = Itinerary->new(@itinerary);
            $package->add_itinerary($itinerary);
        }
    }
    return $order;
};
sub find {
    my $self = shift;
    my $order_number = shift;
    return $self->$build_objects($order_number);

}
1;