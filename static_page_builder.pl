#!/usr/bin/perl 

use strict;
use warnings;
use HTML::Template;

my ($template_dir, $pub_dir) = ($ARGV[0] || '/home/ashim/work/pibot/tmpl', $ARGV[1] || '/home/ashim/work/pibot/priv_dir/html');
builder($template_dir, $pub_dir);


sub builder {
    my ($template_dir, $pub_dir) = @_;
    for(glob($template_dir."/*.tmpl")){
        print "processing -> ",$_,"\n";
        my $template = HTML::Template->new(filename => $_, path => [$template_dir]);
        open(my $fh, ">".$pub_dir."/".(/([^\/]+)\.tmpl$/)[0].".html");
        print $fh $template->output;
        close $fh;
    }
}
