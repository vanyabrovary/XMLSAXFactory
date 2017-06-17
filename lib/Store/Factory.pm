package Store::Factory;

use warnings; use strict;

sub initialise {
    my $class = shift;
    my $type  = shift;

    require "Store/$type.pm";
    return  "Store::$type"->new(@_);
}

1;
