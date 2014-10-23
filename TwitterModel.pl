#Author: Hu Yin
# A model to simulate Twitter, uses User module, which uses 
# Tweet module
# 
# Create a new user account and set the user name and email
# 
# The User object has an attribute of Array containing Tweet 
# objects, post method creates a new tweet object and adds 
# it into the array 

use Moose;
use 5.12.0;
use User;
use Test::More;

# Create a new object from User class

my $user = User->new(
	name  => 'Hu',
	email => 'huyin8@gmail.com',
);

####################################################

# Testing methods #

# No post for this new user

say "\n--All posts--";
$user->get_allposts();

# Print user name and user email

say "\nUser name is: ".$user->get_name();
say "User email is: ".$user->get_email();
is($user->get_name(), 'Hu', "User name is Hu");
is($user->get_email(), 'huyin8@gmail.com', 'Use email is huyin8@gmail.com');


# Publish three posts, @para: String passed as post text, date is automatically recorded
is($user->get_count(), 0, "No post now");

$user->post("First_Post"); 

is($user->get_count(), 1, "One post now");

$user->post("Second_Post");

is($user->get_count(), 2, "Two posts now");

$user->post("Third_Post");

is($user->get_count(), 3, "Three posts now");

# Print all posts
say "\n--All posts--";
$user->get_allposts();

# Print the last post
say "\n--The last post--";
$user->get_lastpost();

# Delete the last post
say "\n--Delete the last post--";
$user->delete_lastpost();
is($user->get_count(), 2, "Two posts left");

# Print all posts after deletion
say "\n--Now we have two posts left--";
$user->get_allposts();

# Delete last post
say "\n--Delete all posts--";
$user->delete_lastpost();
is($user->get_count(), 1, "One post left");

$user->delete_lastpost();
is($user->get_count(), 0, "No post left");

$user->delete_lastpost();
is($user->get_count(), 0, "No post left");

done_testing();