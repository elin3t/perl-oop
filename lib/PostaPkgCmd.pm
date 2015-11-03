package PostaPkgCmd;

use strict;
use warnings;
use parent 'Command';

use OrderService;
use Output;
use Error;

our @ISA = qw(Command);

sub excecute {

    my $self = shift;
    my $order_service = shift || OrderService->new();
    my ($order_number, $package_number, $location, $description, $date) =  ($self->parameters());
    return $order_service->post_package($order_number, $package_number, $location, $description, $date);
}
1;
