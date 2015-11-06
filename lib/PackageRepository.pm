#
#===============================================================================
#
#         FILE: PackageRepository.pm
#
#  DESCRIPTION: 
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 06/11/15 16:22:23
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use v5.18; 
use DBI;
use Data::Dumper;
package PackageRepository;

our @ISA = qw(Repository);

sub insert {
    my $self = shift;
    my $key = shift;
    my $package = shift;
    my $dbh = $self->{'dbh'};

    my $insert = $dbh->prepare(q{INSERT INTO package (package_number,
    package_state, package_location, package_contents,order_number) VALUES
    (?, ?, ?, ?, ?)});
    
    $insert->execute($package->number, $package->state, $package->location, $package->contents, $key);

}

sub update {
    my $self = shift;
    my $package = shift;
    my $state = shift;
    my $dbh = $self->{'dbh'};

    my $update = $dbh->prepare(q{UPDATE package SET package_state = ? WHERE package_number = ?});

    $update->execute($state, $package);
}


1;
