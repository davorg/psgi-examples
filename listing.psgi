use strict;
use warnings;

use Plack::Util;
use Template;

my $app = sub {
  my $env = shift;

  my $body;
  if ($env->{PATH_INFO} =~ m|^/show/(.+)|) {
    $body = show_file($1);
  } elsif ($env->{PATH_INFO} =~ m|^/run/(.+)|) {
    return run_file($1, $env);
  } else {
    $body = list_files();
  }

  return [
    200,
    [ Content_type => 'text/html' ],
    [ $body ]
  ];
};

sub show_file {
  my $file = shift;

  my $fh;
  open $fh, $file;
  return do { local $/; <$fh> };
}

sub run_file {
  my ($file, $env) = @_;

  my $new_app = Plack::Util::load_psgi($file);

  return Plack::Util::run_app $new_app, $env;
}

sub list_files {
  opendir(my $dir, '.');
  my @files = sort readdir($dir);

  my $tt = Template->new;
  $tt->process(\*DATA, { files => \@files }, \my $body);

  return $body;
}

__DATA__
<html>
  <head>
    <title>PSGI Files</title>
  </head>
  <body>
    <h1>PSGI Files</h1>
    <ul>
[% FOREACH file IN files -%]
[% NEXT IF file.match('^\.') -%]
      <li>[% file %]
        <a href="show/[% file %]">show</a>
[% NEXT UNLESS file.match('\.psgi$') -%]
        <a href="run/[% file %]">run</a></li>
[% END -%]
    </ul>
  </body>
</html>
