package Libs::Configuration;

use strict;
use warnings;
use XML::Simple;
use Data::Dumper;

sub new;
sub readConfig;

sub new{
    my $class = ref($_[0])||$_[0];
    return bless{}, $class;
}


sub readConfig
{
 my ($self, $filename) = @_;
 my $simple = XML::Simple->new();
 my $data = $simple->XMLin($filename); 

 return $data;
}

1;
