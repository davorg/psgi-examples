#!/usr/bin/perl

use strict;
use warnings;

use Plack::Builder;
use HTTP::Exception;

my $app = sub {
  HTTP::Exception::500->throw(status_message => 'Everything is fine');
};

builder {
  enable 'HTTPExceptions';
  $app;
};

