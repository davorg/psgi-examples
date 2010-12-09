#!/usr/bin/perl

use Plack::Request;
use Data::Dumper;

my $app = sub {

  my $req = Plack::Request->new(shift);

  return [
    200,
    [ 'Content-type', 'text/plain' ],
    [ Dumper $req ],
  ];
}
