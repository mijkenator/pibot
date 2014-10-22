#!/usr/bin/perl 

use strict;
use warnings;
use HTML::Template;
use Data::Dumper;

my ($template_dir, $pub_dir) = ($ARGV[0] || '/home/ashim/work/pibot/tmpl', $ARGV[1] || '/home/ashim/work/pibot/priv_dir/html');
builder($template_dir, $pub_dir);


sub builder {
    my ($template_dir, $pub_dir) = @_;
    for my $full_fname (glob($template_dir."/*.tmpl")){
        print "processing -> ",$full_fname,"\n";
        my $template = HTML::Template->new(filename => $full_fname, path => [$template_dir]);

        my $base_fnwe = ( $full_fname =~ /([^\/]+)\.tmpl$/ )[0];
        my $pas_list = [ map { s/$pub_dir//; +{sname =>$_} } (glob($pub_dir."/js/".$base_fnwe."_page/*_auto.js")) ];

        $template->param(PAGE_AUTO_SCRIPTS => $pas_list);
        open(my $fh, ">".$pub_dir."/".$base_fnwe.".html");
        print $fh $template->output;
        close $fh;
    }
}
