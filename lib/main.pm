package main;
use strict;
use warnings FATAL => 'all';
use v5.18;
use Data::Dumper;
use lib '/';
use UserHashRepository;
use User;
sub main{

    my $user = User->new('juan', 'pepe', 'kk');
    my $rep = UserHashRepository->new();
    $rep->add($user);

    my $user2 = $rep->find('juan');
    print Dumper \$user2;
}
main();

1;
__END__
