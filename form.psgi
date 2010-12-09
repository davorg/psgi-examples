#!/usr/bin/perl

use Plack::Request;
use Data::Dumper;

my $app = sub {

  my $req = Plack::Request->new(shift);

  my $content;
  if (keys %{$req->parameters}) { 
    $content = response($req);
  } else {
    $content = form();
  }

  return [
    200,
    [ 'Content-type', 'text/html' ],
    [ $content ],
  ];
};

sub response {
  my $req = shift;

  my $name    = $req->parameters->{name};
  my $age     = $req->parameters->{age};
  my $gender  = $req->parameters->{gender};
  my $hobbies = join ', ', $req->parameters->get_all('hobby');
  $hobbies = 'None' unless $hobbies;

  return <<END_OF_HTML;
<html>
  <head>
    <title>$name</title>
  </head>
  <body>
    <h1>Welcome $name</h1>
    <p>Here are your details:</p>
    <table>
      <tr><th>Name:</th><td>$name</td></th><tr>
      <tr><th>Age:</th><td>$age</td></th><tr>
      <tr><th>Gender:</th><td>$gender</td></th><tr>
      <tr><th>Hobbies:</th><td>$hobbies</td></th><tr>
    </table>
  </body>
</html>
END_OF_HTML
}

sub form {
  return <<END_OF_FORM;
<html>
  <head>
    <title>Test Form</title>
  </head>
  <body>
    <h1>Test Form</h1>
    <p>Tell us about yourself.</p>
    <form method="get">
      <table>
        <tr>
          <td>Name:</td>
          <td><input type="text" name="name"><td>
        </tr>
        <tr>
          <td>Age:</td>
          <td><select name="age" size="1">
                <option>Under 15</option>
                <option>15 - 25</option>
                <option>26 - 35</option>
                <option>36 - 45</option>
                <option>Over 45</option>
              </select></td>
        </tr>
        <tr>
          <td>Gender:</td>
          <td><input type="radio" name="gender" 
                     value="Male">Male
              <input type="radio" name="gender" 
                     value="Female">Female</td>
        </tr>
        <tr>
          <td>Hobbies:</td>
          <td><input type="checkbox" name="hobby" 
                     value="Sport">Sport
              <input type="checkbox" name="hobby" 
                     value="Music">Music
              <input type="checkbox" name="hobby" 
                     value="Reading">Reading
              <input type="checkbox" name="hobby" 
                     value="Beer">Beer</td>
        </tr>
        <tr>
          <td colspan="2"><input type="submit"></td>
        </tr>
      </table>
    </form>
  </body>
</html>
END_OF_FORM
}
