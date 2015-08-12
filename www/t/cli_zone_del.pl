#!/usr/bin/perl -w
use v5.14;
use autodie;
use Modern::Perl;

use lib './lib/';
use configuration ':all';
use encryption ':all';
use app;
use utf8;

if( @ARGV != 1 && @ARGV != 3 ) {
    say "usage : ./$0 [ login passwd ] ndd ";
    exit 1;
}

my ($login, $passwd, $dom) = (qw/test test/, $ARGV[0]);
($login, $passwd, $dom) = ($ARGV[0], $ARGV[1], $ARGV[2]) if ( @ARGV == 3 );

eval {
    my $app = app->new(get_cfg());
    my $user = $app->auth($login, encrypt($passwd));
    $app->delete_domain( $user, $dom );
};

if( $@ ) {
    say q{Une erreur est survenue. } . $@;
}
