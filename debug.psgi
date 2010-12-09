#!/usr/bin/perl

use strict;
use warnings;

use Plack::Builder;

my $app = sub {
  my $env = shift;

  return [
    200,
    [ 'Content-type', 'text/html' ],
    [ <DATA> ],
  ]
};

builder {
  enable 'Debug';
  $app;
}

__DATA__
<html>
  <head>
    <title>Test</title>
  </head>
  <body>
    <h1>Test</h1>
    <p>This is a test</p>
  </body>
</html>
