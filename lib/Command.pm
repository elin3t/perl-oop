#!/usr/bin/perl
use strict;
use warnings;

package Command;

sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
    return $self;
}

sub execute {
     die "This method must be overridden by a subclass of __PACKAGE__";
 }


1;
