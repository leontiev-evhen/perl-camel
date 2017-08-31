package Controllers::userController;

use strict;
use warnings;
use vars qw($regform %in);

use vars qw(@ISA);
use Controller;
@ISA = qw(Controllers::Controller);

sub registrationAction;
sub loginAction;
sub logoutAction;

sub findUserAction;
sub updateUserAction;
sub profilInfoAction;

# sub new{
    # my $class = ref($_[0])||$_[0];
    # return bless{}, $class;
# }

sub registrationAction
{
 my ($self,  $request) = @_;

# if($request->isPost())
# {
 #my $nick = %in->{'nick'};
 # my $pas1 = $request->post('password1', undef);
 # my $pas2 = $request->post('password2', undef);
 # my $email = $request->post('email', undef);
 
   # print "Content-type: text/html; charset=utf-8\n\n";
  # print $nick;
 
 # }

 require "user/registration.pl";
 return $regform;
}

1;