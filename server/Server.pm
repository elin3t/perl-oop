#!/usr/bin/perl
package Server;
use strict;
use warnings FATAL => 'all';

use CGI;
use JSON;
use URL::Encode qw(url_decode );
use lib '../lib';
use Handler;

my $q = CGI->new;

my $value = $q->param('command') || "NOCOMMAND";

my $handler = Handler->new();
$handler->command_factory($value);
my $op = $handler->run_commands();
my $error = "";
if(scalar @{$handler->{'errors'}}) {
    $error = $handler->print_errors();
}

print $q->header('application/json;charset=UTF-8');
my $json->{"output"} = "$op";
$json->{"error"} = "$error";
$json->{'command'}="$value";
my $json_text = to_json($json);
print $json_text;

1;
