#user 11
package Models::DB;
use strict;
use warnings FATAL => 'all';

use Data::Dumper;
use DBI;

my $dbh;
my $self;

#my $dbName = 'user11';
#my $dbHost = 'localhost';
#my $dbUser = 'user11';
#my $dbPassword = 'tuser11';


sub instance
{
    my ($class, $args) = @_;

    $self = $args;
    $self->{'data'} = ();

    bless $self, $class;
    return $self;
}

sub connect
{
    my ($self) = @_;
    $dbh = DBI->connect("DBI:$self->{'dbType'}:$self->{'dbName'}:$self->{'dbHost'}",$self->{'dbUser'}, $self->{'dbPassword'});
    if ($dbh)
    {
        return $dbh;
    }
}

sub select
{
    my ($self, $table, $params) = @_;

    my $param = join(',', @$params);
    $self->{'sql'} .= "SELECT $param FROM $table ";
}

sub _join
{
    my ($self, $type, $table, $on) = @_;

    $self->{'sql'} .= " $type JOIN $table ON $on";
}

sub where
{
    my ($self, $key, $value) = @_;
    
    $self->{'sql'} .= "WHERE $key = $value";
}

sub _where
{
    my ($self, $key, $value, $type) = @_;
    $self->{'sql'} .= "$type $key = $value";
}

sub execute
{
    return $self->{'sql'};
}

sub test
{
    my($self) = @_;
    my $sql = "SELECT email FROM users WHERE login = 'yevhen'";

    my $query = $dbh->prepare($sql);

    $query->execute();
   my  $row = $query->fetchrow_hashref();
       
    $query->finish();
    return $row->{'email'};
    

}

sub insert
{
    my($self, $table, $hash) = @_;
    $self->checkConnect();
    my @keys = ();
    my @values = ();

    foreach my $key (keys %{$hash})
    {
        push @keys, $key;
        push @values, "'$hash->{$key}'";
    }

    my $keys = join(', ', @keys);
    my $values = join(', ', @values);

    my $sql = "INSERT INTO $table ($keys) VALUES ($values)";

    my $query = $dbh->prepare($sql);

    if ($query->execute())
    {
        $query->finish();
        return 1;
    }
}

sub update
{
    my($self, $table, $hash, $id) = @_;
    $self->checkConnect();

    my @values =();
    foreach my $key (keys %{$hash})
    {
        push @values , join(' = ', $key, "'$hash->{$key}'");
    }

    my $values = join(', ' , @values);

    
    my $sql = "UPDATE $table SET $values WHERE id = $id";
print Dumper $sql;

    my $query = $dbh->prepare($sql);

    if ($query->execute())
    {
        $query->finish();
        return 1;
    }
}

sub delete
{
    my($self, $table, $id) = @_;
    $self->checkConnect();

    my $sql = "DELETE FROM $table  WHERE id = $id";
    my $query = $dbh->prepare($sql);

    if ($query->execute())
    {
        $query->finish();
        return 1;
    }
    return 0;
}


sub getData
{
    my($self, $sql) = @_;
    my $query = $dbh->prepare($sql);

    $query->execute();
    while (my $row = $query->fetchrow_hashref())
    {
        push @{$self->{'data'}}, $row;
    }

    return $self->{'data'};
}

sub checkConnect
{
    my($self) = @_;
    if (!$dbh)
    {
        $dbh = $self->connect();
    }
}

sub DESTROY
{
    if (defined($dbh))
    {
        $dbh->disconnect;
    }
}



1;
