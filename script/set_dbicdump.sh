PERL='/usr/bin/perl'
PERLBIN='local/lib/perl5/'
DBICDUMP='/usr/bin/dbicdump'
CONF='dbdump.conf'

$PERL -I $PERLBIN $DBICDUMP $CONF 
