package Store::SomeFile;

use warnings; use strict;

use Data::Dumper;

sub new {
    my ( $class, $init ) = @_;

    $class = ref $class if ref $class;
    my $self = bless {}, $class;

    map { $self->{$_} = $init->{$_} } keys %{$init};

    return $self;
}

sub save() {
    my $self      = shift;

    print Dumper($self);

    return $self;
}

1;
