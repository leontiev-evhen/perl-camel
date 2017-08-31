#user 11
package Models::Users;

use strict;
use warnings FATAL => 'all';

use Data::Dumper;

use Models::DB;

my $db;
my $model;
my $table = 'users';

sub new
{
    my($self,$dbModel, $dbh) = @_;
    print "Content-type: text/html; charset=utf-8\n\n";
    print Dumper $dbModel;
    $model = $dbModel;
    $db = $dbh;
    my $class = ref($_[0])||$_[0];
    return bless {}, $class;
}

sub getUserById
{
    my ($self, $hash) = @_;
    
    my @arr = ('id');
    my %arr2 = ('id' => '1');
    $model->select($table, \@arr);
# $model->join('inner', 'test', 'eas');
    $model->where('id','1');
    return $model->execute();
    #$model->getData($sql);


}

sub test
{
    my($self) = @_;
    return $model->test();
}

sub createUser
{
   
    my($self, $hash) = @_;

    return $model->insert($table, $hash);
}

sub issetUser
{
    my($self, %post) = @_;
    my $query = $db->prepare("SELECT * FROM $table WHERE login = ? AND password = ?");

    $query->bind_param(1, $post{'login'});
    $query->bind_param(2, $post{'password'});
    $query->execute();

    if ($query->rows)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

sub updateUser
{
    my ($self, $arr, $userId) = @_;

    return $model->update($table, $arr, $userId);
}

1;
