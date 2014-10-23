# Author: Hu Yin
# Tweet Class, has text and date attributes
# Used by User Module
#


package Tweet;

use Moose;
use 5.12.0;


has 'text' =>(
	is  => 'rw',
	isa => 'Str',	
);

has 'date' =>(
	is  => 'rw',
);

sub get_text{
	my $self = shift;
	return $self->text;
}

sub get_date{
	my $self = shift;
	return $self->date;
}




1;