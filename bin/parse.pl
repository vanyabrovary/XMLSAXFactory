use strict; use warnings;

use FindBin qw/$Bin/;
use lib "$Bin/../lib";

use Parse;
print Parse::xml_file();