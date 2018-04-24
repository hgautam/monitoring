use strict;
use warnings;

#my @hostlist = ("ebaycentral04-2275473.lvs02.dev.ebayc3.com", "ebaycentral03-1843722.lvs02.dev.ebayc3.com",
#               "ebaycentral05-2305230.lvs02.dev.ebayc3.com", "ebaycentral06-2362111.lvs02.dev.ebayc3.com");

my $filename = 'lvsProxyHosts';
open(my $fh, '<:encoding(UTF-8)', $filename)
  or die "Could not open file '$filename' $!";

my $commandStatus = 0;
my @errorList = ();

while (my $host = <$fh>) {
  chomp $host;
  print "$host\n";
  #foreach my $host (@hostlist) {
  $commandStatus = system("wget $host --spider --quiet -T 20");
  if ($commandStatus != 0) {
        print "$host is dowm\n";
        push(@errorList, $host)
    } else {
        print "$host is up\n";
    }
#}
}




if (scalar @errorList > 0 ) {
    exit 1;
    #system("echo '@errorList proxy is down' | mail -s 'Warning' hgautam\@ebay.com");
}
