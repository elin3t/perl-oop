use strict;
use warnings FATAL => 'all';
use parent 'Repository';
use User;
use Package;
use Order;
use Itinerary;
use DBI;
use Data::Dumper;

package UserHashRepository;


our @ISA = qw(Repository);
my $singlenton;

sub new {
    my $class = shift;

    my $dsn = "DBI:mysql:database=perl-cgi;host=localhost;port=3306";
    my $dbh = DBI->connect($dsn, 'root', 'root') or die $DBI::errstr;


    my $self = {
        items=> {},
        dbh => $dbh
    };
    $singlenton ||= bless $self, $class;
    return $singlenton;
}


sub add{
    my $self = shift;
    my $user = shift;


    if ($self->find($user->username)) {
       return 0
    } else {
       my $sql = "INSERT INTO user values (?,?,?)";
       my $stmt = $self->{dbh}->prepare($sql);

       $stmt->execute($user->username, $user->first_name, $user->last_name);
       return 1;
    }
}
sub delete {
    my $self = shift;
    my $username = shift;

    if ($self->find($username)) {
        my $sql = "DELETE FROM user WHERE username = ?";
        my $stmt = $self->{dbh}->prepare($sql);

        $stmt->execute($username);
        return 1;
    } else {
        return 0;
    }
}
my $sql_user_query = sub{
    my $self = shift;
    my $sql = "SELECT *
                FROM user u
                where u.username = ?";
    my $stmt = $self->{dbh}->prepare($sql);

    return $stmt;
};

my $sql_order_query = sub{
    my $self = shift;
    my $sql = "SELECT *
            FROM `order` o
            where o.user_username = ?";
    my $stmt = $self->{dbh}->prepare($sql);

    return $stmt;
};

my $sql_package_query = sub{
    my $self = shift;

    my $sql = "SELECT *
        FROM package p
        where p.order_number = ?";
    my $stmt = $self->{dbh}->prepare($sql);

    return $stmt;
};

my $sql_itinerary_quer = sub{
    my $self = shift;

    my $sql = "SELECT *
        FROM itinerary i
        where i.package_number = ?";

    my $stmt = $self->{dbh}->prepare($sql);

    return $stmt;
};

my $build_objects = sub {
    my $self = shift;
    my $user_name = shift;

    my $stmt_user = $self->$sql_user_query($user_name);

    $stmt_user->execute($user_name);
    my (@row) = $stmt_user->fetchrow_array;
    if (!@row) {
        return 0;
    }
    my $user = User->new(@row);

    my $stmt_order =  $self->$sql_order_query($user_name);
    $stmt_order->execute($user_name);
    while(my @order = $stmt_order->fetchrow_array){
        my $order = Order->new(@order);
        $user->add_order($order);

        my $stmt_package = $self->$sql_package_query();
        $stmt_package->execute($order->number);
        while (my @package = $stmt_package->fetchrow_array) {

            my $package = Package->new(@package);
            $order->add_package($package);

            my $stmt_itinerary = $self->$sql_itinerary_quer();
            $stmt_itinerary->execute($package->number);
            while (my @itinerary = $stmt_itinerary->fetchrow_array) {
                my $itinerary = Itinerary->new(@itinerary);
                $package->add_itinerary($itinerary);
            }
        }

    }

   return $user;
};
sub find {
    my $self = shift;
    my $username = shift;
    return $self->$build_objects($username);

}
1;
