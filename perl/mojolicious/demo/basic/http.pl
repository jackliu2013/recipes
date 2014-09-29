#!/usr/bin/env perl
use strict;
use warnings;
use Mojolicious::Lite;

# 访问请求的信息, 通过 req 的对象.
get '/agent' => sub {
    my $c    = shift;
    my $host = $c->req->url->to_abs->host;
    my $ua   = $c->req->headers->user_agent;
    $c->render( text => "Request by $ua reached $host." );
};

# 通过 res 这个对象定制输出的 header.
post '/echo' => sub {
    my $c = shift;
    $c->res->headers->header( 'X-Bender' => 'Bite my shiny metal ass!' );
    $c->render( data => $c->req->body );
};

app->start;
