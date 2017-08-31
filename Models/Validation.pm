package Models::Validation;

use strict;
use warnings FATAL => 'all';
use Data::Dumper;
use Email::Valid;

sub new
{
    my $class = ref($_[0])||$_[0];
    return bless {}, $class;
}

# Removes all HTML tags
sub clearHtml
{
    my($self, $string) = @_;

    if ($string)
    {
        $string =~ s/<([^>]|\n)*>//g;

        if (length($string) <= 3)
        {
            return 0;
        }

        return $string;
    }
    else
    {
        return 0;
    }
}

# Remove all spaces in word
sub clearWord
{
    my($self, $string) = @_;
    $string = $self->clearHtml($string);
    if ($string)
    {
        $string =~ s/[^-A-Za-z0-9_.]+?//g;

        if (length($string) <= 3)
        {
            return 0;
        }

        return $string;
    }
    else
    {
        return 0;
    }
}

# Remove all spaces before and after article
sub clearArticle
{
    my($self, $string) = @_;
    $string = $self->clearHtml($string);
    if ($string)
    {
        $string =~ s/^\s+//img;
        $string =~ s/\s+$//img;

        if (length($string) <= 3)
        {
            return 0;
        }

        return $string;
    }
    else
    {
        return 0;
    }
}

# Correct email and remove all spaces
sub clearEmail
{
    my($self, $string) = @_;

    if ($string)
    {
        my $check = Email::Valid->new();
        $string = $check->address($string);

        if ($string and length($string) <= 7)
        {
            return 0;
        }

        return $string;
    }
    else
    {
        return 0;
    }
}

# Processing login form data
sub checkLoginForm
{
    my($self, %hash) = @_;
    
    $hash{'login'} = $self->clearWord($hash{'login'});
    $hash{'password'} = $self->clearWord($hash{'password'});
    
    return %hash;
}

# Processing registration form data
sub checkRegForm
{
    my($self, %hash) = @_;

    $hash{'login'} = $self->clearWord($hash{'login'});
    $hash{'email'} = $self->clearEmail($hash{'email'});
    $hash{'password'} = $self->clearWord($hash{'password'});
    $hash{'password_v'} = $self->clearWord($hash{'password_v'});
    if ($hash{'password'} == $hash{'password_v'})
    {
        $hash{'password_v'} = 1;
    }
    
    return %hash;    
}

# Processing email user form data
sub checkUserForm
{
    my($self, $string) = @_;

    if(!($string = $self->clearEmail($string)))
    {
        return 0;
    }

    return $string;
}

1;