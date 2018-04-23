use strict;
use warnings;

my @hostlist = ("ebaycentral04-2275473.lvs02.dev.ebayc3.com", "ebaycentral03-1843722.lvs02.dev.ebayc3.com",
                "ebaycentral05-2305230.lvs02.dev.ebayc3.com", "ebaycentral06-2362111.lvs02.dev.ebayc3.com");

my $commandStatus = 0;
my @errorList = ();
foreach my $host (@hostlist) {
    $commandStatus = system("wget $host --spider --quiet -T 20");
    if ($commandStatus != 0) {
        print "$host is dowm\n";
        push(@errorList, $host)
    }
}

if (scalar @errorList > 0 ) {
    exit 1;
    #system("echo '@errorList proxy is down' | mail -s 'Warning' hgautam\@ebay.com");
}
