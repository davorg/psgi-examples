#!/usr/bin/perl

use Plack::Request;
use Plack::Response;
use Data::Dumper;

my $app = sub {

  my $req = Plack::Request->new(shift);

  my $res = Plack::Response->new(200);
  $res->content_type('text/plain');
  $res->body(Dumper $req);

  return $res->finalize;
}
