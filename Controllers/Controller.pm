package Controllers::Controller;

use strict;
use warnings;

sub new;
sub setContainer;
sub get;

my $container;

sub new{
    $container = ();
    my $class = ref($_[0])||$_[0];
    return bless{}, $class;
}


sub setContainer
{
 my ($self, $data_container) = @_;
 $container = $data_container;
 

}


sub get
{
 my ($self, $key) = @_;
 return $container->get($key);
}




1;
