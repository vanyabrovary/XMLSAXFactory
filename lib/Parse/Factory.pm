package Parse::Factory;

use warnings; use strict;

sub initialise {
    my $class = shift;
    my $type  = shift;

    require "Parse/$type.pm";
    return  "Parse::$type"->new(@_);
}

1;
