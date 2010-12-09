#!/usr/bin/perl
use Template;
my $app = sub {
  my $tt = Template->new;
  my $out;
  $tt->process('time.tt',
               { time => scalar localtime },
               \$out) or die $tt->error;

  return [
    200,
    [ 'Content-type', 'text/html' ],
    [ $out ]
  ]
};
