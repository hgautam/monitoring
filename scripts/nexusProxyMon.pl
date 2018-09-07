use strict;
use warnings;

#my $filename = 'lvsProxyHosts';
my $filename = $ARGV[0];
print "file name is $filename\n";
open(my $fh, '<:encoding(UTF-8)', $filename)
  or die "Could not open file '$filename' $!";

my $commandStatus = 0;
my @errorList = ();

while (my $host = <$fh>) {
  chomp $host;
  #$commandStatus = system("wget $host --spider --quiet -T 20");
  my $appURL = "http://$host/service/local/status";
  print "url is $appURL\n";
  $commandStatus = system("/usr/bin/wget -T 10 -t 3 --spider $appURL > /dev/null 2>&1");
  if ($commandStatus != 0) {
        print "$host is down\n";
        push(@errorList, $host)
    } else {
        print "$host is up\n";
    }
}




if (scalar @errorList > 0 ) {
    exit 1;
    #system("echo '@errorList proxy is down' | mail -s 'Warning' hgautam\@ebay.com");
}
