use Plack::App::Directory;

my $app = Plack::App::Directory->new({
  root => '/home/dave/Dropbox/psgi',
})->to_app;
