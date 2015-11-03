#!/usr/bin/perl
use strict;
use v5.18;
use warnings;
package Command;

sub new {
    my $class = shift;
    my @parameters = @_;
    my $self = {
        parameters => \@parameters
    };
    bless $self, $class;
    return $self;
}

sub parameters {
    my $parameters = shift->{'parameters'};
    return  @{$parameters} ;
}

sub execute {
     die "This method must be overridden by a subclass of __PACKAGE__";
 }


1;
