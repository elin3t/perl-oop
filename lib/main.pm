package main;
use strict;
use warnings FATAL => 'all';
use v5.18;
use Data::Dumper;
use lib '/';
use UserHashRepository;
use OrderHashRepository;
use Order;
use User;
use PackageRepository;
use OrderService;
sub main{

#    #my $user = User->new('juan', 'pepe', 'kk');
#    my $rep = UserHashRepository->new();
#    #$rep->add($user);
#
#    my $user2 = $rep->find('manuel');
#
#    #$rep->delete('juan');
#    my $repOrder = OrderHashRepository->new();
#
#    my $newOrder = Order->new('manuel', 3, 'description', 40);
#    $repOrder->add($newOrder);
#    my $order = $repOrder->find(3);
#
#    my $rep2 = PackageRepository->new();
#    my $pack = Package->new(4,'UY', 'Cualquiera' );
#
#    $rep2->insert($order->number, $pack);
#    $rep2->update(4, ':)');
#    my $order2 = $repOrder->find(3);
#
#    print Dumper \$order2;

    # my ($ord_num, $pkg_num, $location, $description, $date)
    my $ordRep = OrderService->new();
   # $ordRep->post_package(1,2 , 'San Ramon', 'The Description', '2012/08/29');

    my $output = $ordRep->read_itinerary(1);
    print $output->get_output() .  "\n";

}
main();

1;
__END__
