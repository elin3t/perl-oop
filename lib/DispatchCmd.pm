#!/usr/bin/perl
use strict;
use warnings;

package DispatchCmd;
use parent 'Command';
our @ISA = qw(Command);
use OrderService;

sub execute {
    my $self = shift;
    my $order_service = shift || OrderService->new();
    my @parameters = $self->parameters;
    #my ($order_number,$package_number,$content,$location,$date) = @parameters;
    return $order_service->dispatch(@parameters);
}
1;
