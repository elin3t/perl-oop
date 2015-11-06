package main;
use strict;
use warnings FATAL => 'all';
use v5.18;
use Data::Dumper;
use lib '/';
use UserHashRepository;
use OrderHashRepository;
use User;
sub main{

    #my $user = User->new('juan', 'pepe', 'kk');
    my $rep = UserHashRepository->new();
    #$rep->add($user);

    my $user2 = $rep->find('manuel');

    #$rep->delete('juan');
    my $repOrder = OrderHashRepository->new();
    my $order = $repOrder->find(1);
    print Dumper \$order;
}
main();

1;
__END__
