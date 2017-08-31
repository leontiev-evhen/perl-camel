package Libs::Router;

use strict;
use warnings;

sub getRoute;

sub new{
    my $class = ref($_[0])||$_[0];
    return bless{}, $class;
}

sub getRoute{
    my ($self, $route, $default) = @_;
    my ($buffer, @pairs, $pair, $name, $value, $route_str, @route, $route_size, %hash_route);
    my %get = ();
    
    # Read get params
    $buffer = $ENV{'QUERY_STRING'};
   
   
    # Split information into name/value pairs
    @pairs = split(/&/, $buffer);

    # Make hash
     foreach $pair (@pairs)
     {
        ($name, $value) = split(/=/, $pair);
       
       $value =~ tr/+/ /;
       $value =~ s/%(..)/pack("C", hex($1))/eg;
  
        $get{$name} = $value;
     }
   
    
      $route_str =(exists $get{$route}) ? $get{$route} : $default;
      
      @route = split m|/|, $route_str;
      $route_size = @route;
      if($route_size <2)
      {
          @route = split m|/|, $default;       #redirect from default/homePage
      }	
      
      %hash_route = ('controller'=>$route[0].'Controller', 'action'=> $route[1].'Action');
      return \%hash_route;
      
}


1;