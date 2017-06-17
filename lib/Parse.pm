package Parse;

use warnings; use strict;

sub xml_file {

    use Parse::Factory;
    my $handler = Parse::Factory->initialise('SomeFile');
    $handler->store('SomeFile');

    use XML::SAX::ParserFactory;
    my $parser = XML::SAX::ParserFactory->parser( Handler => $handler );
    $parser->parse_file( 'c.xml' );

    return 1;

}


1;
