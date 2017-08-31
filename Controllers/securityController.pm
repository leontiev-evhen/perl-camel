package Controllers::securityController;

use strict;
use warnings;


use vars qw(@ISA);
use Controller;
use Models::Users;

use DBI;

@ISA = qw(Controllers::Controller);

sub isUserAction;

# sub new{
    # my $class = ref($_[0])||$_[0];
    # return bless{}, $class;
# }


sub isUserAction{
    my ($self) = @_;
    my $model = Models::Users->new($self->get('model'), $self->get('db'));
    
   my %hash = ('login' => 'test777', 'password' => '123', 'email' => 'test777@test.com');
    return $model->updateUser(\%hash,1);
}

1;
