#!/usr/bin/perl

use Data::Dumper;

my $app = sub {
  my $env = shift;

  return [
    200,
    [ 'Content-type', 'text/plain' ],
    [ Dumper $env ],
  ];
}
