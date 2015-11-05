package Server;
use strict;
use warnings FATAL => 'all';

use strict;
use warnings;

use CGI;
use JSON;
my $q = CGI->new;

my $value = $q->param('command');
# Prepare various HTTP responses
print $q->header('application/json;charset=UTF-8');

my $json->{"output"} = "my output";
$json->{"command"} = "$value";
my $json_text = to_json($json);
print $json_text;


1;