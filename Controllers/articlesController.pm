package Controllers::articlesController;

use strict;
use warnings;

use vars qw(@ISA);
use Controller;
@ISA = qw(Controllers::Controller);

sub showAllAction;

# sub new{
    # my $class = ref($_[0])||$_[0];
    # return bless{}, $class;
# }


sub showAllAction
{
 my ($self, $request) = @_;

 return "Hello from controller";
}

1;
