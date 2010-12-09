#!/usr/bin/perl

use Plack::Builder;

my $app = sub {
  my $env = shift;

  return [
    200,
    [ 'Content-type', 'text/plain' ],
    [ 'Hello world' ],
  ]
};

builder {
  enable 'Runtime';
  enable 'XFramework', framework => 'MyFramework';
  $app;
}

