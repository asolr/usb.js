# a simple http server in perl

use HTTP::Daemon;
use HTTP::Status;
    #my $d = new HTTP::Daemon;
	my $d = HTTP::Daemon->new(
	           LocalAddr => '127.0.0.1',
	           LocalPort => 80,
	       );
  print "Please contact me at: <URL:", $d->url, ">\n";
  while (my $c = $d->accept) {
      while (my $r = $c->get_request) {
          if ($r->method eq 'GET' and $r->url->path eq "/") {
              # remember, this is *not* recommened practice :-)
              $c->send_file_response("index.html");
          } else {
              $c->send_error(RC_FORBIDDEN)
          }
      }
      $c->close;
      undef($c);
  }
