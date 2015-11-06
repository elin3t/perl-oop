package Repository;
use strict;
use warnings FATAL => 'all';
use Data::Dumper;
use DBI;

sub new {
    my $class = shift;
    my $dsn = "DBI:mysql:database=perl-cgi;host=localhost;port=3306";
    my $dbh = DBI->connect($dsn, 'root', 'root') or die $DBI::errstr;


    my $self = {
        items=> {},
        dbh => $dbh
    };
    bless $self, $class;
    return $self;
}
sub add{
    my $self = shift;
    my $key = shift;
    my $object = shift;
    return $self->{items}{$key} = $object;
}

sub delete{
    my $self = shift;
    my $key = shift;
    my $result = delete $self->{items}{$key};
    if ($result) {
        return 1;
    } else {
        return 0;
    }
}

sub find{
    my $self = shift;
    my $key = shift;
    if (exists $self->{items}{$key}) {
        return $self->{items}{$key};
    }
    else {
        return 0;
    }
}

sub list{
   my $self = shift;
   return $self->{items};
}
sub sql_order_by_username_query {

    my $self = shift;
    my $sql = "SELECT *
        FROM `order` o
        where o.user_username = ?";
    my $stmt = $self->{dbh}->prepare($sql);

    return $stmt;
}

sub sql_order_query{

    my $self = shift;
    my $sql = "SELECT *
        FROM `order` o
        where o.order_number = ?";
    my $stmt = $self->{dbh}->prepare($sql);
    return $stmt;
}

sub sql_package_query{
    my $self = shift;

    my $sql = "SELECT *
        FROM package p
        where p.order_number = ?";
    my $stmt = $self->{dbh}->prepare($sql);

    return $stmt;
}

sub sql_itinerary_query {
    my $self = shift;

    my $sql = "SELECT *
        FROM itinerary i
        where i.package_number = ?";

    my $stmt = $self->{dbh}->prepare($sql);

    return $stmt;
}

sub sql_user_query{
    my $self = shift;
    my $sql = "SELECT *
        FROM user u
        where u.username = ?";
    my $stmt = $self->{dbh}->prepare($sql);

    return $stmt;
};

1;