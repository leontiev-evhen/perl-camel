package Utilities::sessionUtil;

use strict;
use warnings;

sub new
{
	my ($class) = ref($_[0]) || $_[0];

	return bless {
		'debugMode' => $_[1],
		'driver' => 'driver:File',
		'serializer' => 'serializer:Default',
		'sid' => undef,
		'sessionDir' => undef,
		'errorMessage' => undef }, $class;
}

sub setDebug
{
	my ($self) = shift;
	$self->{'debugMode'} = shift;
}

sub debugMode
{
	my ($self) = shift;
	return $self->{'debugMode'};
}

sub debug
{
	my ($self) = shift;

	my ($package, $file, $line, $sub) = caller(1);

	print "<b>[line:$line $sub]</b> @_<br>\n"
		if ($self->debugMode());

	return 1;
}

sub set
{
	my ($self) = shift;
	my ($key) = shift;
	$self->{$key} = shift;
}

sub get
{
	my ($self, $key) = @_;
	return $self->{$key};
}

sub setErrorMessage
{
	my ($self) = shift;
	$self->{'errorMessage'} = shift;
}

sub getErrorMessage
{
	my ($self) = shift;
	return $self->{'errorMessage'};
}

# a new session file starting or an exist file connecting by session id
sub sessionStarter
{
	my ($self) = shift;

	unless ( $self->get('sessionDir') )
	{
		$self->debug("Can't start a session because session"
			. " work directory isn't preset!");
		return undef;
	}

	unless ( $self->isValidExpTime($self->get('sessionExpires')) )
	{
		$self->debug("Wrong format of expiration value!");
		return undef;
	}

	eval
	{
		require CGI::Session;
		CGI::Session->import();
		require CGI::Session::File;
		CGI::Session::File->import();
	};

	my ($driver) = $self->get('driver');
	my ($serializer) = $self->get('serializer');
	my ($sid) = $self->get('sid');
	my ($workDir) = $self->get('sessionDir');

	my ($session) = CGI::Session->new("$driver;$serializer", $sid,
		{ Directory => $workDir });

	unless ( $session )
	{
		$self->debug("can't create/open SESSION file!");
		$self->setErrorMessage('%LANG_service_temp_not_available');
		return undef;
	}

	$session->expire($self->get('sessionExpires'));
	$self->set('sessionHandler', $session);
	$self->debug("The SESSION file successfuly crated/opened.");

	return 1;
}

# get the session file id
sub getSid
{
	my ($self) = shift;

	my ($session) = $self->get('sessionHandler');
	my ($sid) = $session->id();
	$self->set('sid', $sid);
	$self->debug("Session Id: $sid");

	return $sid;
}

# +===========+===============+
# |   alias   |   meaning     |
# +===========+===============+
# |     s     |   Second      |
# |     m     |   Minute      |
# |     h     |   Hour        |
# |     w     |   Week        |
# |     M     |   Month       |
# |     y     |   Year        |
# +-----------+---------------+

sub isValidExpTime
{
	my ($self, $expTime) = @_;
	return ($expTime =~ /^\d+$/
		|| $expTime =~ /^[+]{1}[0-9]{1,2}[smhWMY]{1}$/);
}

# the session expiration date return
sub getSessionExpiration
{
	my ($self) = shift;
	my ($session) = $self->get('sessionHandler');
	return $session->expire();
}

# returns the last access time of the session in
# the form of seconds from epoch. This time is used internally
# while auto-expiring sessions and/or session parameters.
sub getLastAccessTime
{
	my ($self) = shift;
	my ($session) = $self->get('sessionHandler');
	return $session->atime();
}

# returns the time when the session was first created.
sub getSessionCreationTime
{
	my ($self) = shift;
	my ($session) = $self->get('sessionHandler');
	return $session->ctime();
}

# returns all the session parameters as a reference to a hash
sub getSessionElementsHashref
{
	my ($self) = shift;
	my ($session) = $self->get('sessionHandler');
	return $session->param_hashref();
}

# get an element by name from the session file
sub getSessionElement
{
	my ($self, $key) = @_;
	my ($session) = $self->get('sessionHandler');
	return $session->param($key);
}

# set the element into the current session file
sub setSessionElement
{
	my ($self, $key, $value) = @_;
	my ($session) = $self->get('sessionHandler');
	$session->param($key, $value);
}

# clears parameters from the session object.
# If passed an argument as an arrayref,
# clears only those parameters found in the list.
# clear(["_IS_LOGGED_IN"])
sub clearSessionElements
{
	my ($self, $keys) = @_;
	my ($session) = $self->get('sessionHandler');
	$session->clear($keys);
}

# synchronizes data in the buffer with its copy in disk.
# Normally it will be called for you just before the program terminates,
# session object goes out of scope or close() is called.
sub flush
{
	my ($self) = shift;
	my ($session) = $self->get('sessionHandler');
	$session->flush();
}

# closes the session temporarily until new()
# is called on the same session next time.
# In other words, it's a call to flush() and DESTROY(), but a lot slower.
# Normally you never have to call close().
sub sessionClose
{
	my ($self) = shift;
	my ($session) = $self->get('sessionHandler');
	$session->close();
}

# deletes the session from the disk.
# In other words, it calls for immediate expiration
# after which the session will not be accessible
sub sessionDelete
{
	my ($self) = shift;
	my ($session) = $self->get('sessionHandler');
	$session->delete();	
}

sub DESTROY
{
	my ($self) = shift;
	$self->flush();
}

return 1;

