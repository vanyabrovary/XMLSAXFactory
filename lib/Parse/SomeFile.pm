package Parse::SomeFile;

use warnings; use strict;

use UNIVERSAL::can;

use Store;

sub new {
    my $class = shift;
    $class = ref $class if ref $class;
    my $self  = bless {}, $class;
    return $self;
}

sub store {
    my $self    = shift;
    $self->{db} = Store->new(shift);
}

sub start_psv() {
    my ( $self, $e ) = @_;
    $self->{db}->start;
    $self->{db}->set( {$_ => $self->_attr_val( $e, $_ )} ) foreach ( qw/started_at finished_at/ );
}

sub start_avg() {
    my ( $self, $e ) = @_;
    $self->{db}->set( {'net_latency_avg_nanosec' => $self->_attr_val( $e, 'nseconds' )} );
}

sub start_min() {
    my ( $self, $e ) = @_;
    $self->{db}->set( {'net_latency_min_nanosec' => $self->_attr_val( $e, 'nseconds' )} );
}

sub start_max() {
    my ( $self, $e ) = @_;
    $self->{db}->set( {'net_latency_max_nanosec' => $self->_attr_val( $e, 'nseconds' )} );
}

sub end_psv() {
    my ( $self, $e ) = @_;
    $self->{db}->end;
}

sub start_element() {
    my ( $self, $e ) = @_;
    my $method_name  = "start_".$e->{Name};
    $self->$method_name($e) if ( defined $self->can( $method_name ) );
}

sub end_element() {
    my ( $self, $e ) = @_;
    my $method_name  = "end_".$e->{Name};
    $self->$method_name($e) if ( defined $self->can( $method_name ) );
}

sub _attr_val() {
    my ( $self, $e, $key ) = @_; 
    return $e->{'Attributes'}->{'{}'.$key}->{'Value'} || 0;
}

1;
