package main;
use strict;
use warnings FATAL => 'all';
use v5.18;
use Data::Dumper;
use lib '/';
use UserHashRepository;

sub main{
    my $rep = UserHashRepository->new();
    my $user = $rep->find('manuel');
    print Dumper \$user;
}
main();

1;
__END__
