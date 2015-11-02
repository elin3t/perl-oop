#!/usr/bin/perl
use strict;
use warnings;

package Command;

sub new {
    my $class = shift;
    bless {}, $class;
}

sub execute {
     die "This method must be overridden by a subclass of __PACKAGE__";
 }

sub validate {
     die "This method must be overridden by a subclass of __PACKAGE__";
}

1;
