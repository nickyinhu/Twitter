#Author: Hu Yin
# User Module, has attributes: name, email, array of Tweet objects
#
# Has methods: get_name, get_email, post (add tweet), 
# get_count (count tweets), get_allposts, get_last (post), 
# delete_last (post),  print_posts
#
# Uses Tweet Module


package User;

use Moose;
use Tweet;
use DateTime;
use 5.12.0;

# User name attribute
has 'name' => (
	is   => 'rw',
	isa  => 'Str',
	required => 1,
);
# Email attribute
has 'email' => (
	is   => 'rw',
	isa  => 'Str',
	required => 1,
);
# Tweet object array
has 'tweets' => (
	traits  => ['Array'],
	isa => 'ArrayRef[Tweet]',
	default => sub { [] },
	handles => {
		add_tweet 	=> 'push',
		delete_last => 'pop',
		all 		=> 'elements',
		count		=> 'count',
		
	},
);
# Return user name
sub get_name {
	my $self = shift;
	return $self->name;
}
# Return user email
sub get_email {
	my $self = shift;
	return $self->email;
}
# Add a new tweet to user's tweet array
sub post{
	my $self  = shift;
	my $text  = shift;
	my $tweet = Tweet->new(
		text => $text,
		date => DateTime->now,
	);
	$self->add_tweet($tweet);
}
# Count the number of tweets
sub get_count {
	my $self = shift;
	return $self->count;
}
# Print all posts
sub get_allposts {
	my $self = shift;
	my @tweets = $self->all();
	$self->print_posts(@tweets);
}
# Print the last post
sub get_lastpost {
	my $self = shift;
	my @tweets = $self->all();
	$self->print_posts($tweets[$#tweets]);
}
# Delete the last post
sub delete_lastpost {
	my $self = shift;
	my @tweets = $self->all();
	$self->delete_last();
	say "Last post has been deleted!";
}
# Print posts
sub print_posts{
	my $self = shift;
	if(@_ == 0){
		say "You have NO post to delete!";
		return;
	}
	for (@_){
		say "Author: ".$self->get_name(),
			" | Date: ".$_->get_date(),
			" | Text: ".$_->get_text();
	}
}


1;