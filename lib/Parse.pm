package Parse;

use warnings; use strict;
use Parse::Factory;
use XML::SAX::ParserFactory;

sub xml_file {
    my $handler = Parse::Factory->initialise('SomeFile');
    $handler->store('SomeFile');

    my $parser = XML::SAX::ParserFactory->parser( Handler => $handler );
    $parser->parse_file( 'c.xml' );

    return 1;
}


1;
