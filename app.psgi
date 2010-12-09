#!/usr/bin/perl

my $app = sub {
  my $env = shift;

  return [
    200,
    [ 'Content-type', 'text/plain' ],
    [ 'Hello world' ],
  ]
};
