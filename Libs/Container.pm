package Libs::Container;

use strict;
use warnings;

sub set;
sub get;

my $objects;


sub new{
    $objects = {};
    my $class = ref($_[0])||$_[0];
    return bless{}, $class;
}


sub set{
    my ($self, $key, $value)=@_;
    $objects->{$key} = $value;
}

sub get{
    my ($self, $key)=@_;
    return (exists $objects->{$key}) ? $objects->{$key} : undef;  
}

1;