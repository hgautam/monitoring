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
  $commandStatus = system("wget $host --spider --quiet -T 20");
  if ($commandStatus != 0) {
        print "$host is dowm\n";
        push(@errorList, $host)
    } else {
        print "$host is up\n";
    }
}




if (scalar @errorList > 0 ) {
    exit 1;
    #system("echo '@errorList proxy is down' | mail -s 'Warning' hgautam\@ebay.com");
}
