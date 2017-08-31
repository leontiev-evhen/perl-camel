package Libs::Request;

use strict;
use warnings;
use Data::Dumper;

sub isPost;

sub new{
    my $class = ref($_[0])||$_[0];
    return bless{}, $class;
}

sub isPost{
  my ($self) = @_;
  $ENV{'REQUEST_METHOD'} =~ tr/a-z/A-Z/;
  if ($ENV{'REQUEST_METHOD'} eq "POST")
  {
     return 1;
  }
  return 0;
 }


1;