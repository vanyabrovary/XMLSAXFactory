package Store;

use warnings; use strict;

use Store::Factory;

sub new {
    my $class = shift;
    my $store = shift;
    $class    = ref $class if ref $class;
    my $self  = bless {}, $class;

    $self->{__store} = Store::Factory->initialise($store);

    return $self;
}

sub start {
    my $self = shift;
    $self->{tmp} = ();
}

sub end {
    my $self = shift;

    my $store;

    eval { $store = $self->{__store}->new( $self->{tmp} ); };
    die $@ if $@;

    eval { $store->save(); };
    die $@ if $@;

    return $store;
}

sub set {
    my ( $self, $elem ) = @_;
    if ( ref($elem) eq 'HASH' ) {
        $self->{tmp}->{$_} = $elem->{$_} foreach ( keys %{$elem} );
    } else {
        $self->{tmp} = $elem;
    }
}

sub end_dumper { 
    my $self = shift; 
    use Data::Dumper;
    return Dumper($self->{tmp});
}

1;
