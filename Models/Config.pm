package Models::Config;

use strict;
use warnings FATAL => 'all';


sub new
{
    my $class = ref($_[0])||$_[0];
    return bless {}, $class;
}

sub getData
{
    return (
        'dbType' => 'mysql',
        'dbName' => 'user11',
        'dbHost' => 'localhost',
        'dbUser' => 'root',
        'dbPassword' => 'root'
    );
}


1;