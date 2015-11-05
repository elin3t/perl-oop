package Server;
use strict;
use warnings FATAL => 'all';

use strict;
use warnings;

use CGI;
use JSON;
my $q = CGI->new;

# Prepare various HTTP responses
print $q->header('application/json');

my $json->{"output"} = "my output";
my $json_text = to_json($json);
print $json_text;


1;