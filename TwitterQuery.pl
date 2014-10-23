#Author: Hu Yin
# Search Perl in Twitter, display 10 posts with Date, Author, and Post
# Uses Net::Twitter API

use Net::Twitter;
use 5.12.0;
use strict;
use Test::More;


my $nt = Net::Twitter->new                               #Create a new twitter authentication
  (
   traits          		=> [qw/API::RESTv1_1/],
   consumer_key    		=> $consumer_key,
   consumer_secret 		=> $consumer_secret,
   access_token       	=> $token,
   access_token_secret	=> $token_secret,
   ssl => 1,
  ); 

my $response = $nt->search("Perl", {lang=>"en"});         #Only search for English posts
for (0..9){
	last unless my $hash_ref=$response->{statuses}->[$_];     
	say "---------Post ".($_+1)."---------";
	say "DATE: ".$$hash_ref{created_at};		 		  #Date
	my $name = $$hash_ref{user}->{name};
	say "AUTHOR: "."$name";                               #Author
	my $text = $$hash_ref{text};
	say "POST: ".$text, "\n";							  #Post
	ok($text =~ /perl/i or $name =~ /perl/i, "This post has Perl");
}

say "-------------Done-------------";

done_testing();