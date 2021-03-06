#CODE 0 (MEMBUAT DB DI SERVER)
#---- 1
#UNTUK MEMBUAT FILE YANG BERISI NAMA TB BARU UNTUK PARSING
#!C:/Perl/bin/perl.exe -w
#!/usr/bin/perl
use DBI;
use warnings;
$start = time;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
open (OUT2, '>matching/DokumenParsing.txt') or die "can't open";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
print "Opened database successfully\n";
@months = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
@days = qw(Sun Mon Tue Wed Thu Fri Sat Sun);
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
$a = ("tb_parsing_$mday$months[$mon]_");
printf OUT2 ($a."%02d_%02d_%02d", $hour, $min, $sec);
$dbh->disconnect();
}
close (OUT);
close (OUT2);

#---- 2
#UNTUK MEMBUAT TB BARU UNTUK PARSING DI SERVER
#!C:/Perl/bin/perl.exe -w
#!/usr/bin/perl
use DBI;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
open (OUT2, 'matching/DokumenParsing.txt') or die "can't open";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
@a = <OUT2>;
$aa = "@a";
$stmt = qq(CREATE TABLE $aa
      (Id INT PRIMARY KEY     NOT NULL,
      Parsing           VARCHAR(1000)    NOT NULL););
$rv = $dbh->do($stmt);
if($rv < 0) {
   print $DBI::errstr;
} else {
   print "TABLE CREATED SUCCESSFULLY\n";
}
$dbh->disconnect();
}
close (OUT);

#---- 3
#UNTUK MEMBUAT FILE YANG BERISI NAMA TB BARU UNTUK MATCH JALAN
#!C:/Perl/bin/perl.exe -w
#!/usr/bin/perl
use DBI;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
open (OUT2, '>matching/DokumenMatchJalan.txt') or die "can't open";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
print "Opened database successfully\n";
@months = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
@days = qw(Sun Mon Tue Wed Thu Fri Sat Sun);
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
$a = ("tb_matchjln_$mday$months[$mon]_");
printf OUT2 ($a."%02d_%02d_%02d", $hour, $min, $sec);
$dbh->disconnect();
}
close (OUT);
close (OUT2);

#---- 4
#UNTUK MEMBUAT TB BARU UNTUK MATCH JALAN DI SERVER
#!C:/Perl/bin/perl.exe -w
#!/usr/bin/perl
use DBI;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
open (OUT2, 'matching/DokumenMatchJalan.txt') or die "can't open";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
@a = <OUT2>;
$aa = "@a";
$stmt = qq(CREATE TABLE $aa
      (Id INT PRIMARY KEY     NOT NULL,
      Keterangan           VARCHAR(255)    NOT NULL););
$rv = $dbh->do($stmt);
if($rv < 0) {
   print $DBI::errstr;
} else {
   print "TABLE CREATED SUCCESSFULLY\n";
}
$dbh->disconnect();
}
close (OUT);

#---- 5
#UNTUK MEMBUAT FILE YANG BERISI NAMA TB BARU UNTUK MATCH ADM
#!C:/Perl/bin/perl.exe -w
#!/usr/bin/perl
use DBI;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
open (OUT2, '>matching/DokumenMatchAdm.txt') or die "can't open";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
print "Opened database successfully\n";
@months = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
@days = qw(Sun Mon Tue Wed Thu Fri Sat Sun);
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
$a = ("tb_matchadm_$mday$months[$mon]_");
printf OUT2 ($a."%02d_%02d_%02d", $hour, $min, $sec);
$dbh->disconnect();
}
close (OUT);
close (OUT2);

#---- 6
#UNTUK MEMBUAT TB BARU UNTUK MATCH ADM DI SERVER
#!C:/Perl/bin/perl.exe -w
#!/usr/bin/perl
use DBI;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
open (OUT2, 'matching/DokumenMatchAdm.txt') or die "can't open";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
@a = <OUT2>;
$aa = "@a";
$stmt = qq(CREATE TABLE $aa
      (Id INT PRIMARY KEY     NOT NULL,
      match_vi           VARCHAR(255),
      match_su           VARCHAR(255),
      match_di           VARCHAR(255),
      match_pr           VARCHAR(255)););
$rv = $dbh->do($stmt);
if($rv < 0) {
   print $DBI::errstr;
} else {
   print "TABLE CREATED SUCCESSFULLY\n";
}
$dbh->disconnect();
}
close (OUT);

#------------------------------------------------------------------------------------------------------------#

#CODE 1 (MENYELESAIKAN MASALAH PARSING)
#---- 1
#UNTUK MENARIK DATA YANG DIBUTUHKAN DARI DATABASE
#SETELAH MENARIK DATA, MAKA DATA YANG ADA AKAN DIUBAH FORMATNYA SESUAI DENGAN YANG DIGUNAKAN PADA PROSES PARSING DI CODE 2
#!C:/Perl/bin/perl.exe -w
use DBI;
use DBD::mysql;
open (OUT, '>matching/StringAlamat1.txt') or die "can't open";
open (OUT2, 'matching/Dokumen.txt') or die "can't open";
foreach $aaa (<OUT2>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
$sth = $dbh->prepare(qq{SELECT upper(concat('* ',id,' ^| ',ori_address,', ',ori_vi,', ',ori_su,', ',ori_di,', ',ori_pr,' ')) FROM $tb where flag_geocode != 'Q' order by id});
$sth->execute or die "SQL Error: $DBI::errstr\n";
while (@row = $sth->fetchrow_array) {
print OUT "@row\n";
}
}
close (OUT2);
close (OUT);
open(FILE2, ">>matching/StringAlamat1.txt") or die "can't open";
print FILE2 "% ~ ";
close (FILE2);

#---- 2
#UNTUK MELAKUKAN PROSES PARSING
#CODINGAN PART 1 INI UNTUK MENGHILANGKAN TANDA BACA TERTENTU HANYA DARI STRING ALAMAT
#!C:/Perl64/bin/perl.exe -w
open(FILE2, "matching/StringAlamat1.txt") or die "can't open";
open (OUT, '>matching/StringAlamat2.txt') or die "can't open";
while (<FILE2>) {
chomp;
@string = split ('\^', $_);
$string[1] =~ tr/a-z/A-Z/;
if ($string[1] =~ /\.|\:|\,|\-/) {
$string[1] =~ s/\.|\:|\,|\-/ /g;
}
if ($string[1] =~ /\'/) {
$string[1] =~ s/\'//g;
}
if ($string[1] =~ /\(|\)|\//) {
$string[1] =~ s/\(/ \( /g;
$string[1] =~ s/\)/ \) /g;
$string[1] =~ s/\// \/ /g;
}
if ($string [1] =~ /  /) {
$string[1] =~ s/  / /g;
}
print OUT @string;
print OUT "\n";
}
close (FILE2);
close (OUT);

##CODINGAN PART 2 INI UNTUK MENGUBAH KATA-KATA SINGKATAN MENJADI KATA SEBENARNYA
#!C:/Perl64/bin/perl.exe -w
open(FILE, "matching/DB4.txt") or die "can't open";
open(FILE2, "matching/StringAlamat2.txt") or die "can't open";
open (OUT, '>matching/StringAlamat3.txt') or die "can't open";
@aa = <FILE2>;
$aaa = "@aa";
foreach ($aaa =~ /\~ /) {
@listdata = split(/\~ /, $aaa);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
foreach $entitas(<FILE>) {
@lines = split(/,/, $entitas);
chomp @lines;
$a = $lines[0];
$b = $lines[1];
if ($listdata[$i] =~ / $a /) {
$listdata[$i] =~ s/ $a / $b /g;
}
}
if ($listdata[$i] =~ /([0-9])([A-Z])/) {
$listdata[$i] =~ s/([0-9])([A-Z])/$1 $2/g;
}
if ($listdata[$i] =~ /(NO) ([0-9]+) ([A-Z]{1})/) {
$listdata[$i] =~ s/(NO) ([0-9]+) ([A-Z]{1})/NO $2$3/g;
}
if ($listdata[$i] =~ /(NO) ([0-9]+)([A-Z]{2,})/) {
$listdata[$i] =~ s/(NO) ([0-9]+)([A-Z]{2,})/NO $2 $3/g;
}
#mengubah format DKI DKI JAKARTA menjadi DKI JAKARTA, DLL
if ($listdata[$i] =~ /DKI DKI JAKARTA|DKI JAKARTA BARAT|DKI JAKARTA TIMUR|DKI JAKARTA PUSAT|DKI JAKARTA UTARA|DKI JAKARTA SELATAN|DI DAERAH ISTIMEWA YOGYAKARTA|D I DAERAH ISTIMEWA YOGYAKARTA|POLDA ACEH|BATU PHAT|DPASAR|KELUNGKUNG| D E N P A S A R | PASR /) {
$listdata[$i] =~ s/DKI DKI JAKARTA/DKI JAKARTA/g;
$listdata[$i] =~ s/DKI JAKARTA BARAT/JAKARTA BARAT/g;
$listdata[$i] =~ s/DKI JAKARTA TIMUR/JAKARTA TIMUR/g;
$listdata[$i] =~ s/DKI JAKARTA PUSAT/JAKARTA PUSAT/g;
$listdata[$i] =~ s/DKI JAKARTA UTARA/JAKARTA UTARA/g;
$listdata[$i] =~ s/DKI JAKARTA SELATAN/JAKARTA SELATAN/g;
$listdata[$i] =~ s/DI DAERAH ISTIMEWA YOGYAKARTA/DAERAH ISTIMEWA YOGYAKARTA/g;
$listdata[$i] =~ s/D I DAERAH ISTIMEWA YOGYAKARTA/DAERAH ISTIMEWA YOGYAKARTA/g;
$listdata[$i] =~ s/POLDA ACEH/POLDA BANDA ACEH/g;
$listdata[$i] =~ s/BATU PHAT/BATU PHAT BARAT/g;
$listdata[$i] =~ s/BATU PHAT BARAT BARAT/BATU PHAT BARAT/g;
$listdata[$i] =~ s/BATU PHAT BARAT TIMUR/BATU PHAT TIMUR/g;
$listdata[$i] =~ s/DPASAR/DENPASAR/g;
$listdata[$i] =~ s/KELUNGKUNG/KLUNGKUNG/g;
$listdata[$i] =~ s/D E N P A S A R/DENPASAR/g;
$listdata[$i] =~ s/PASR/PASAR/g;
}
#mengubah format KOTA KOTA MEDAN menjadi KOTA MEDAN, DLL
if ($listdata[$i] =~ /TELUK KOTA MEDAN|TANJUNG KOTA MEDAN|TALANG KOTA MEDAN|SUKA KOTA MEDAN|SIMPANG KOTA KOTA MEDAN|SELAT TANJUNG KOTA MEDAN|RENAH KOTA MEDAN|PERKEBUNAN TANJUNG KOTA MEDAN|KOTA MEDAN TUNTUNGAN|KOTA MEDAN TIMUR|KOTA MEDAN TENGGARA|KOTA MEDAN TEMBUNG|KOTA MEDAN SUNGGAL|KOTA MEDAN SINEMBAH|KOTA MEDAN SERI RAMBAHAN|KOTA MEDAN SELAYANG|KOTA MEDAN SATRIA|KOTA MEDAN POLONIA|KOTA MEDAN PETISAH|KOTA MEDAN PERJUANGAN|KOTA MEDAN MARELAN|KOTA MEDAN MAIMUN|KOTA MEDAN LABUHAN|KOTA MEDAN KRIO|KOTA MEDAN KOTA BELAWAN|KOTA MEDAN KOTA|KOTA MEDAN JOHOR|KOTA MEDAN JAYA|KOTA MEDAN HELVETIA|KOTA MEDAN ESTATE|KOTA MEDAN DENAI|KOTA MEDAN DELI|KOTA MEDAN BARU|KOTA MEDAN BARAT|KOTA MEDAN AREA|KOTA MEDAN AMPLAS|KOTA KOTA MEDAN|KAMPUNG KOTA MEDAN|GUNUNG KOTA MEDAN/) {
$listdata[$i] =~ s/TELUK KOTA MEDAN/TELUK MEDAN/g;
$listdata[$i] =~ s/TANJUNG KOTA MEDAN/TANJUNG MEDAN/g;
$listdata[$i] =~ s/TALANG KOTA MEDAN/TALANG MEDAN/g;
$listdata[$i] =~ s/SUKA KOTA MEDAN/SUKA MEDAN/g;
$listdata[$i] =~ s/SIMPANG KOTA KOTA MEDAN/SIMPANG KOTA MEDAN/g;
$listdata[$i] =~ s/SELAT TANJUNG KOTA MEDAN/SELAT TANJUNG MEDAN/g;
$listdata[$i] =~ s/RENAH KOTA MEDAN/RENAH MEDAN/g;
$listdata[$i] =~ s/PERKEBUNAN TANJUNG KOTA MEDAN/PERKEBUNAN TANJUNG MEDAN/g;
$listdata[$i] =~ s/KOTA MEDAN TUNTUNGAN/MEDAN TUNTUNGAN/g;
$listdata[$i] =~ s/KOTA MEDAN TIMUR/MEDAN TIMUR/g;
$listdata[$i] =~ s/KOTA MEDAN TENGGARA/MEDAN TENGGARA/g;
$listdata[$i] =~ s/KOTA MEDAN TEMBUNG/MEDAN TEMBUNG/g;
$listdata[$i] =~ s/KOTA MEDAN SUNGGAL/MEDAN SUNGGAL/g;
$listdata[$i] =~ s/KOTA MEDAN SINEMBAH/MEDAN SINEMBAH/g;
$listdata[$i] =~ s/KOTA MEDAN SERI RAMBAHAN/MEDAN SERI RAMBAHAN/g;
$listdata[$i] =~ s/KOTA MEDAN SELAYANG/MEDAN SELAYANG/g;
$listdata[$i] =~ s/KOTA MEDAN SATRIA/MEDAN SATRIA/g;
$listdata[$i] =~ s/KOTA MEDAN POLONIA/MEDAN POLONIA/g;
$listdata[$i] =~ s/KOTA MEDAN PETISAH/MEDAN PETISAH/g;
$listdata[$i] =~ s/KOTA MEDAN PERJUANGAN/MEDAN PERJUANGAN/g;
$listdata[$i] =~ s/KOTA MEDAN MARELAN/MEDAN MARELAN/g;
$listdata[$i] =~ s/KOTA MEDAN MAIMUN/MEDAN MAIMUN/g;
$listdata[$i] =~ s/KOTA MEDAN LABUHAN/MEDAN LABUHAN/g;
$listdata[$i] =~ s/KOTA MEDAN KRIO/MEDAN KRIO/g;
$listdata[$i] =~ s/KOTA MEDAN KOTA BELAWAN/MEDAN KOTA BELAWAN/g;
$listdata[$i] =~ s/KOTA MEDAN KOTA/MEDAN KOTA/g;
$listdata[$i] =~ s/KOTA MEDAN JOHOR/MEDAN JOHOR/g;
$listdata[$i] =~ s/KOTA MEDAN JAYA/MEDAN JAYA/g;
$listdata[$i] =~ s/KOTA MEDAN HELVETIA/MEDAN HELVETIA/g;
$listdata[$i] =~ s/KOTA MEDAN ESTATE/MEDAN ESTATE/g;
$listdata[$i] =~ s/KOTA MEDAN DENAI/MEDAN DENAI/g;
$listdata[$i] =~ s/KOTA MEDAN DELI/MEDAN DELI/g;
$listdata[$i] =~ s/KOTA MEDAN BARU/MEDAN BARU/g;
$listdata[$i] =~ s/KOTA MEDAN BARAT/MEDAN BARAT/g;
$listdata[$i] =~ s/KOTA MEDAN AREA/MEDAN AREA/g;
$listdata[$i] =~ s/KOTA MEDAN AMPLAS/MEDAN AMPLAS/g;
$listdata[$i] =~ s/KOTA KOTA MEDAN/KOTA MEDAN/g;
$listdata[$i] =~ s/KAMPUNG KOTA MEDAN/KAMPUNG MEDAN/g;
$listdata[$i] =~ s/GUNUNG KOTA MEDAN/GUNUNG MEDAN/g;
}
if ($listdata[$i] =~ / JL SAMPING PASAR | JL DEPAN PASAR | JL DALAM PASAR | JL KIOS DEPAN PASAR | JL KIOS PASAR | DEPAN PASAR | KIOS DEPAN PASAR | DALAM PASAR /) {
$listdata[$i] =~ s/ JL SAMPING PASAR | JL DEPAN PASAR | JL DALAM PASAR | JL KIOS DEPAN PASAR | JL KIOS PASAR / PASAR /g;
$listdata[$i] =~ s/ DEPAN PASAR | KIOS DEPAN PASAR | DALAM PASAR / PASAR /g;
}
if ($listdata[$i] =~ / \* /) {
$listdata[$i] =~ s/ \* /\* /g;
}
if ($listdata[$i] =~ /  /) {
$listdata[$i] =~ s/  / /g;
}
print OUT $listdata[$i]."\n";
}
}
close (FILE);
close (FILE2);
close (OUT);

##CODINGAN PART 3 INI UNTUK MEMBERI TAG ATAU ENTITAS UNTUK MASING-MASING KATA YANG ADA DI DALAM STRING ALAMAT
#!C:/Perl64/bin/perl.exe -w
open(FILE3, "matching/DB1.txt") or die "can't open";
open(FILE4, "matching/DB2.txt") or die "can't open";
open(FILE5, "matching/DB3.txt") or die "can't open";
open(FILE6, "matching/DB5.txt") or die "can't open";
open(FILE7, "matching/DB7.txt") or die "can't open";
open (OUT2, 'matching/StringAlamat3.txt') or die "can't open";
open (OUT3, '>matching/StringHasil1.txt') or die "can't open";
@lines = <OUT2>;
$input = "@lines";
$input =~ tr/a-z/A-Z/;
$input =~ s/[,]//g;
foreach ($input =~ /\%/) {
@listdata = split(/\%/, $input);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
if ($listdata[$i] =~ /(LIST ALAMAT YANG AKAN DIPARSING:)/) {
do nothing;
}
#mengubah format JALAN |JLN |JALN |JLAN |JL menjadi {{JL\}\}
if ($listdata[$i] =~ /(JALAN |JLN |JALN |JLAN |JL)/) {
$listdata[$i] =~ s/(JALAN |JLN |JALN |JLAN |JL)/\{\{JL\}\} /g;
}
#mengubah format PROV | KAB | KEC | KEL menjadi PROVINSI, KABUPATEN, KECAMATAN, KELURAHAN
if ($listdata[$i] =~ /( PROV | KAB | KEC | KEL | DS )/) {
$listdata[$i] =~ s/( PROV )/ PROVINSI /g;
$listdata[$i] =~ s/( KAB )/ KABUPATEN /g;
$listdata[$i] =~ s/( KEC )/ KECAMATAN /g;
$listdata[$i] =~ s/( KEL )/ KELURAHAN /g;
$listdata[$i] =~ s/( DS )/ DESA /g;
}
#menghapus kata PROVINSI, KABUPATEN, KECAMATAN, KELURAHAN
if ($listdata[$i] =~ /(PROVINSI |KABUPATEN |KECAMATAN |KELURAHAN | DESA )/) {
$listdata[$i] =~ s/(PROVINSI |KABUPATEN |KECAMATAN |KELURAHAN | DESA)//g;
}
#memberi entitas untuk kata-kata yang mengandung kata blok (cth: BLOK SAWAH, BLOK M)
foreach $entitas6(<FILE6>) {
@lines6 = split(/,/, $entitas6);
$a6 = $lines6[0];
$b6 = $lines6[1];
$c6 = $lines6[2];
if ($listdata[$i] =~ / $a6 /) {
$listdata[$i] =~ s/ $a6 / $b6 /g;
}
if ($listdata[$i] =~ / $b6 /) {
if ($c6 =~ /PROVINSI/) {
$listdata[$i] =~ s/ $b6 / \{\{PROV\}\} $b6~ /g;
}
if ($c6 =~ /KABUPATEN/) {
$listdata[$i] =~ s/ $b6 / \{\{KAB\}\} $b6~ /g;
}
if ($c6 =~ /KECAMATAN/) {
$listdata[$i] =~ s/ $b6 / \{\{KEC\}\} $b6~ /g;
}
if ($c6 =~ /KELURAHAN/) {
$listdata[$i] =~ s/ $b6 / \{\{KEL\}\} $b6~ /g;
}
if ($c6 =~ /KABKEC/) {
$listdata[$i] =~ s/ $b6 / \{\{KEC\}\} \{\{KAB\}\} $b6~ /g;
}
if ($c6 =~ /KABUKECAKELU/) {
$listdata[$i] =~ s/ $b6 / \{\{KEL\}\} \{\{KEC\}\} \{\{KAB\}\} $b6~ /g;
}
if ($c6 =~ /KABKEL/) {
$listdata[$i] =~ s/ $b6 / \{\{KEL\}\} \{\{KAB\}\} $b6~ /g;
}
if ($c6 =~ /KECKEL/) {
$listdata[$i] =~ s/ $b6 / \{\{KEL\}\} \{\{KEC\}\} $b6~ /g;
}
if ($c6 =~ /PROVKABUKELU/) {
$listdata[$i] =~ s/ $b6 / \{\{KEL\}\} \{\{KAB\}\} \{\{PROV\}\} $b6~ /g;
}
if ($c6 =~ /PROVKEL/) {
$listdata[$i] =~ s/ $b6 / \{\{KEL\}\} \{\{PROV\}\} $b6~ /g;
}
}
}
#memberi entitas untuk kata-kata yang mengandung kata pasar (cth: PASAR MINGGU)
foreach $entitas7(<FILE7>) {
@lines7 = split(/,/, $entitas7);
$a7 = $lines7[0];
$b7 = $lines7[1];
$c7 = $lines7[2];
if ($listdata[$i] =~ / $a7 /) {
$listdata[$i] =~ s/ $a7 / $b7 /g;
}
if ($listdata[$i] =~ / $b7 /) {
if ($c7 =~ /PROVINSI/) {
$listdata[$i] =~ s/ $b7 / \{\{PROV\}\} $b7~ /g;
}
if ($c7 =~ /KABUPATEN/) {
$listdata[$i] =~ s/ $b7 / \{\{KAB\}\} $b7~ /g;
}
if ($c7 =~ /KECAMATAN/) {
$listdata[$i] =~ s/ $b7 / \{\{KEC\}\} $b7~ /g;
}
if ($c7 =~ /KELURAHAN/) {
$listdata[$i] =~ s/ $b7 / \{\{KEL\}\} $b7~ /g;
}
if ($c7 =~ /KABKEC/) {
$listdata[$i] =~ s/ $b7 / \{\{KEC\}\} \{\{KAB\}\} $b7~ /g;
}
if ($c7 =~ /KABUKECAKELU/) {
$listdata[$i] =~ s/ $b7 / \{\{KEL\}\} \{\{KEC\}\} \{\{KAB\}\} $b7~ /g;
}
if ($c7 =~ /KABKEL/) {
$listdata[$i] =~ s/ $b7 / \{\{KEL\}\} \{\{KAB\}\} $b7~ /g;
}
if ($c7 =~ /KECKEL/) {
$listdata[$i] =~ s/ $b7 / \{\{KEL\}\} \{\{KEC\}\} $b7~ /g;
}
if ($c7 =~ /PROVKABUKELU/) {
$listdata[$i] =~ s/ $b7 / \{\{KEL\}\} \{\{KAB\}\} \{\{PROV\}\} $b7~ /g;
}
if ($c7 =~ /PROVKEL/) {
$listdata[$i] =~ s/ $b7 / \{\{KEL\}\} \{\{PROV\}\} $b7~ /g;
}
}
}
#mengubah kata MALL, PLAZA, DLL menjadi \{\{POI\}\}
#GRAHA, GRHA,
#PASAR LAMA = KEL
if ($listdata[$i] =~ /(MALL |MAL |PLAZA |PLASA |GEDUNG |GD |KANTOR |KTR |APARTEMEN |APARTMENT |APT |APART |MENARA |CLUSTER |KLUSTER |GRIYA |GRAHA |GRHA |HOTEL |RUMAH SAKIT |KOPERASI |KOMPLEKS |KOMPLEK | RUKO |PERUMAHAN |PERUM |PERUMNAS | PASAR )/) {
$listdata[$i] =~ s/( MALL | MAL )/ \{\{POI\}\} MALL /g;
$listdata[$i] =~ s/(PLAZA |PLASA )/\{\{POI\}\} PLAZA /g;
$listdata[$i] =~ s/(GEDUNG |GD )/\{\{POI\}\} GEDUNG /g;
$listdata[$i] =~ s/(KANTOR |KTR )/\{\{POI\}\} KANTOR /g;
$listdata[$i] =~ s/( APARTEMEN | APARTMENT | APT | APART )/ \{\{POI\}\} APARTEMEN /g;
$listdata[$i] =~ s/(MENARA )/\{\{POI\}\} MENARA /g;
$listdata[$i] =~ s/(CLUSTER |KLUSTER )/\{\{POI\}\} CLUSTER /g;
$listdata[$i] =~ s/(GRIYA )/\{\{POI\}\} GRIYA /g;
$listdata[$i] =~ s/(GRAHA |GRHA )/\{\{POI\}\} GRAHA /g;
$listdata[$i] =~ s/(HOTEL )/\{\{POI\}\} HOTEL /g;
$listdata[$i] =~ s/(RUMAH SAKIT )/\{\{POI\}\} RUMAH SAKIT /g;
$listdata[$i] =~ s/(KOPERASI )/\{\{POI\}\} KOPERASI /g;
$listdata[$i] =~ s/(KOMPLEKS |KOMPLEK |KOMP )/\{\{POI\}\} KOMPLEK /g;
$listdata[$i] =~ s/( RUKO )/ \{\{POI\}\} RUKO /g;
$listdata[$i] =~ s/(PERUMAHAN |PERUM |PERUMNAS )/\{\{POI\}\} PERUMAHAN /g;
$listdata[$i] =~ s/( PASAR )/ \{\{POI\}\} PASAR /g;
}
#mengubah kata BLOK, NOMOR, DLL menjadi \{\{BLOK\}\}, \{\{NO\}\}, DLL
if ($listdata[$i] =~ /( BLOK | BLOCK | BLK | BK | BL | KAVLING | KAV |NOMOR |NMR | NO | NO:| RT |RW |\/RW)/) {
$listdata[$i] =~ s/( BLOK | BLOCK | BLK | BK | BL | KAVLING | KAV )/ \{\{BLOK\}\} /g;
$listdata[$i] =~ s/(NOMOR |NMR )/\{\{NO\}\} /g;
$listdata[$i] =~ s/( NO | NO:)/ \{\{NO\}\} /g;
$listdata[$i] =~ s/( RT)/ \{\{RT\}\} /g;
$listdata[$i] =~ s/( RW|\/RW)/ \{\{RW\}\} /g;
}
#mengubah kata \{\{BLOK\}\} M menjadi BLOK M
if ($listdata[$i] =~ /(\{\{BLOK\}\} M )/) {
$listdata[$i] =~ s/\{\{BLOK\}\} M /BLOK M /g;
}
#memberi entitas untuk kata-kata tunggal (cth: MAMPANG PRAPATAN)
foreach $entitas3(<FILE3>) {
@lines3 = split(/,/, $entitas3);
$a3 = $lines3[0];
$b3 = $lines3[1];
$c3 = $lines3[2];
if ($listdata[$i] =~ / $a3 /) {
$listdata[$i] =~ s/ $a3 / $b3 /g;
}
if ($listdata[$i] =~ / $b3 /) {
if ($c3 =~ /PROVINSI/) {
$listdata[$i] =~ s/ $b3 / \{\{PROV\}\} $b3~ /g;
}
if ($c3 =~ /KABUPATEN/) {
$listdata[$i] =~ s/ $b3 / \{\{KAB\}\} $b3~ /g;
}
if ($c3 =~ /KECAMATAN/) {
$listdata[$i] =~ s/ $b3 / \{\{KEC\}\} $b3~ /g;
}
if ($c3 =~ /KELURAHAN/) {
$listdata[$i] =~ s/ $b3 / \{\{KEL\}\} $b3~ /g;
}
if ($c3 =~ /KABKEC/) {
$listdata[$i] =~ s/ $b3 / \{\{KEC\}\} \{\{KAB\}\} $b3~ /g;
}
if ($c3 =~ /KABUKECAKELU/) {
$listdata[$i] =~ s/ $b3 / \{\{KEL\}\} \{\{KEC\}\} \{\{KAB\}\} $b3~ /g;
}
if ($c3 =~ /KABKEL/) {
$listdata[$i] =~ s/ $b3 / \{\{KEL\}\} \{\{KAB\}\} $b3~ /g;
}
if ($c3 =~ /KECKEL/) {
$listdata[$i] =~ s/ $b3 / \{\{KEL\}\} \{\{KEC\}\} $b3~ /g;
}
if ($c3 =~ /PROVKABUKELU/) {
$listdata[$i] =~ s/ $b3 / \{\{KEL\}\} \{\{KAB\}\} \{\{PROV\}\} $b3~ /g;
}
if ($c3 =~ /PROVKEL/) {
$listdata[$i] =~ s/ $b3 / \{\{KEL\}\} \{\{PROV\}\} $b3~ /g;
}
}
}
#memberi entitas untuk kata-kata turunan (cth: MAMPANG)
foreach $entitas4(<FILE4>) {
@lines4 = split(/,/, $entitas4);
$a4 = $lines4[0];
$b4 = $lines4[1];
$c4 = $lines4[2];
if ($listdata[$i] =~ / $a4 /) {
$listdata[$i] =~ s/ $a4 / $b4 /g;
}
if ($listdata[$i] =~ / $b4 /) {
if ($c4 =~ /PROVINSI/) {
$listdata[$i] =~ s/ $b4 / \{\{PROV\}\} $b4~ /g;
}
if ($c4 =~ /KABUPATEN/) {
$listdata[$i] =~ s/ $b4 / \{\{KAB\}\} $b4~ /g;
}
if ($c4 =~ /KECAMATAN/) {
$listdata[$i] =~ s/ $b4 / \{\{KEC\}\} $b4~ /g;
}
if ($c4 =~ /KELURAHAN/) {
$listdata[$i] =~ s/ $b4 / \{\{KEL\}\} $b4~ /g;
}
if ($c4 =~ /KABKEC/) {
$listdata[$i] =~ s/ $b4 / \{\{KEC\}\} \{\{KAB\}\} $b4~ /g;
}
if ($c4 =~ /KABUKECAKELU/) {
$listdata[$i] =~ s/ $b4 / \{\{KEL\}\} \{\{KEC\}\} \{\{KAB\}\} $b4~ /g;
}
if ($c4 =~ /KABKEL/) {
$listdata[$i] =~ s/ $b4 / \{\{KEL\}\} \{\{KAB\}\} $b4~ /g;
}
if ($c4 =~ /KECKEL/) {
$listdata[$i] =~ s/ $b4 / \{\{KEL\}\} \{\{KEC\}\} $b4~ /g;
}
if ($c4 =~ /PROVKABUKELU/) {
$listdata[$i] =~ s/ $b4 / \{\{KEL\}\} \{\{KAB\}\} \{\{PROV\}\} $b4~ /g;
}
if ($c4 =~ /PROVKEL/) {
$listdata[$i] =~ s/ $b4 / \{\{KEL\}\} \{\{PROV\}\} $b4~ /g;
}
}
}
#memberi spasi pada kata-kata yang seharusnya memang dispasi
foreach $entitas5(<FILE5>) {
@lines5 = split(/,/, $entitas5);
$a5 = $lines5[0];
$b5 = $lines5[1];
$c5 = $lines5[2];
if ($listdata[$i] =~ /$b5/) {
$listdata[$i] =~ s/$b5/$a5/g;
}
}
if ($listdata[$i] =~ /  /) {
$listdata[$i] =~ s/  / /g;
}
#menghilangkan tag PROV|KAB|KEC|KEL yang berada dibelakang kata-kata tertentu
if ($listdata[$i] =~ /(\{\{JL|POI\}\}([ A-Z]*) \{\{KEL|KEC|KAB|PROV\}\} \{\{KEL|KEC|KAB|PROV\}\}) || (\{\{JL|POI\}\}([ A-Z]*) \{\{KEL|KEC|KAB|PROV\}\})/) {
$listdata[$i] =~ s/\{\{JL\}\} TB \{\{KEL\}\}/\{\{JL\}\} TB/g;
$listdata[$i] =~ s/\{\{JL\}\} RE \{\{KEL\}\}/\{\{JL\}\} RE/g;
$listdata[$i] =~ s/\{\{JL\}\} BALAIDESA \{\{KEL\}\}/\{\{JL\}\} BALAIDESA/g;
$listdata[$i] =~ s/\{\{JL\}\} RAYA \{\{KEC\}\} \{\{KAB\}\}/\{\{JL\}\} RAYA/g;
$listdata[$i] =~ s/\{\{JL\}\} RAYA \{\{KEL\}\} \{\{KAB\}\}/\{\{JL\}\} RAYA/g;
$listdata[$i] =~ s/\{\{JL\}\} RAYA \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} RAYA/g;
$listdata[$i] =~ s/\{\{JL\}\} RAYA \{\{KEL\}\} \{\{PROV\}\}/\{\{JL\}\} RAYA/g;
$listdata[$i] =~ s/\{\{JL\}\} RAYA \{\{KEL\}\}/\{\{JL\}\} RAYA/g;
$listdata[$i] =~ s/\{\{JL\}\} RAYA \{\{KEC\}\}/\{\{JL\}\} RAYA/g;
$listdata[$i] =~ s/\{\{JL\}\} RAYA \{\{KAB\}\}/\{\{JL\}\} RAYA/g;
$listdata[$i] =~ s/\{\{JL\}\} RAYA \{\{PROV\}\}/\{\{JL\}\} RAYA/g;
$listdata[$i] =~ s/\{\{JL\}\} \{\{KEC\}\} \{\{KAB\}\}/\{\{JL\}\}/g;
$listdata[$i] =~ s/\{\{JL\}\} \{\{KEL\}\} \{\{KAB\}\}/\{\{JL\}\}/g;
$listdata[$i] =~ s/\{\{JL\}\} \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\}/g;
$listdata[$i] =~ s/\{\{JL\}\} \{\{KEL\}\} \{\{PROV\}\}/\{\{JL\}\}/g;
$listdata[$i] =~ s/\{\{JL\}\} \{\{KEL\}\}/\{\{JL\}\}/g;
$listdata[$i] =~ s/\{\{JL\}\} \{\{KEC\}\}/\{\{JL\}\}/g;
$listdata[$i] =~ s/\{\{JL\}\} \{\{KAB\}\}/\{\{JL\}\}/g;
$listdata[$i] =~ s/\{\{JL\}\} \{\{PROV\}\}/\{\{JL\}\}/g;
$listdata[$i] =~ s/\{\{POI\}\} PASAR INPRES \{\{KEC\}\} \{\{KAB\}\}/\{\{POI\}\} PASAR INPRES/g;
$listdata[$i] =~ s/\{\{POI\}\} PASAR INPRES \{KEL\}\} \{\{KAB\}\}/\{\{POI\}\} PASAR INPRES/g;
$listdata[$i] =~ s/\{\{POI\}\} PASAR INPRES \{\{KEL\}\} \{\{KEC\}\}/\{\{POI\}\} PASAR INPRES/g;
$listdata[$i] =~ s/\{\{POI\}\} PASAR INPRES \{\{KEL\}\} \{\{PROV\}\}/\{\{POI\}\} PASAR INPRES/g;
$listdata[$i] =~ s/\{\{POI\}\} PASAR INPRES \{\{KEL\}\}/\{\{POI\}\} PASAR INPRES/g;
$listdata[$i] =~ s/\{\{POI\}\} PASAR INPRES \{\{KEC\}\}/\{\{POI\}\} PASAR INPRES/g;
$listdata[$i] =~ s/\{\{POI\}\} PASAR INPRES \{\{KAB\}\}/\{\{POI\}\} PASAR INPRES/g;
$listdata[$i] =~ s/\{\{POI\}\} PASAR INPRES \{\{PROV\}\}/\{\{POI\}\} PASAR INPRES/g;
$listdata[$i] =~ s/\{\{POI\}\} PASAR \{\{KEC\}\} \{\{KAB\}\}/\{\{POI\}\} PASAR/g;
$listdata[$i] =~ s/\{\{POI\}\} PASAR \{KEL\}\} \{\{KAB\}\}/\{\{POI\}\} PASAR/g;
$listdata[$i] =~ s/\{\{POI\}\} PASAR \{\{KEL\}\} \{\{KEC\}\}/\{\{POI\}\} PASAR/g;
$listdata[$i] =~ s/\{\{POI\}\} PASAR \{\{KEL\}\} \{\{PROV\}\}/\{\{POI\}\} PASAR/g;
$listdata[$i] =~ s/\{\{POI\}\} PASAR \{\{KEL\}\}/\{\{POI\}\} PASAR/g;
$listdata[$i] =~ s/\{\{POI\}\} PASAR \{\{KEC\}\}/\{\{POI\}\} PASAR/g;
$listdata[$i] =~ s/\{\{POI\}\} PASAR \{\{KAB\}\}/\{\{POI\}\} PASAR/g;
$listdata[$i] =~ s/\{\{POI\}\} PASAR \{\{PROV\}\}/\{\{POI\}\} PASAR/g;
$listdata[$i] =~ s/\{\{POI\}\} RUKO \{\{KEL\}\} \{\{KEC\}\}/\{\{POI\}\} RUKO/g;
$listdata[$i] =~ s/\{\{POI\}\} RUKO \{\{KEL\}\}/\{\{POI\}\} RUKO/g;
$listdata[$i] =~ s/\{\{POI\}\} RUKO \{\{KEC\}\}/\{\{POI\}\} RUKO/g;
$listdata[$i] =~ s/\{\{POI\}\} PERUMAHAN \{\{KEL\}\} \{\{KEC\}\}/\{\{POI\}\} PERUMAHAN/g;
$listdata[$i] =~ s/\{\{POI\}\} PERUMAHAN \{\{KEL\}\}/\{\{POI\}\} PERUMAHAN/g;
$listdata[$i] =~ s/\{\{POI\}\} PERUMAHAN \{\{KEC\}\}/\{\{POI\}\} PERUMAHAN/g;
$listdata[$i] =~ s/\{\{POI\}\} KOMPLEK \{\{KEL\}\} \{\{KEC\}\}/\{\{POI\}\} KOMPLEK/g;
$listdata[$i] =~ s/\{\{POI\}\} KOMPLEK \{\{KEL\}\}/\{\{POI\}\} KOMPLEK/g;
$listdata[$i] =~ s/\{\{POI\}\} KOMPLEK \{\{KEC\}\}/\{\{POI\}\} KOMPLEK/g;
$listdata[$i] =~ s/\{\{POI\}\} KOMPLEK \{\{KAB\}\}/\{\{POI\}\} KOMPLEK/g;
$listdata[$i] =~ s/\{\{POI\}\} APARTEMEN \{\{KEL\}\} \{\{KEC\}\}/\{\{POI\}\} APARTEMEN/g;
$listdata[$i] =~ s/\{\{POI\}\} APARTEMEN \{\{KEL\}\}/\{\{POI\}\} APARTEMEN/g;
$listdata[$i] =~ s/\{\{POI\}\} APARTEMEN \{\{KEC\}\}/\{\{POI\}\} APARTEMEN/g;
$listdata[$i] =~ s/\{\{POI\}\} KANTOR \{\{KEL\}\} \{\{KEC\}\}/\{\{POI\}\} KANTOR/g;
$listdata[$i] =~ s/\{\{POI\}\} KANTOR \{\{KEL\}\}/\{\{POI\}\} KANTOR/g;
$listdata[$i] =~ s/\{\{POI\}\} KANTOR \{\{KEC\}\}/\{\{POI\}\} KANTOR/g;
$listdata[$i] =~ s/\{\{POI\}\} GEDUNG \{\{KEL\}\} \{\{KEC\}\}/\{\{POI\}\} GEDUNG/g;
$listdata[$i] =~ s/\{\{POI\}\} GEDUNG \{\{KEL\}\}/\{\{POI\}\} GEDUNG/g;
$listdata[$i] =~ s/\{\{POI\}\} GEDUNG \{\{KEC\}\}/\{\{POI\}\} GEDUNG/g;
$listdata[$i] =~ s/\{\{POI\}\} MALL \{\{KEL\}\} \{\{KEC\}\}/\{\{POI\}\} MALL/g;
$listdata[$i] =~ s/\{\{POI\}\} MALL \{\{KEL\}\}/\{\{POI\}\} MALL/g;
$listdata[$i] =~ s/\{\{POI\}\} MALL \{\{KEC\}\}/\{\{POI\}\} MALL/g;
$listdata[$i] =~ s/\{\{POI\}\} GRIYA \{\{KEL\}\} \{\{KEC\}\}/\{\{POI\}\} GRIYA/g;
$listdata[$i] =~ s/\{\{POI\}\} GRIYA \{\{KEL\}\}/\{\{POI\}\} GRIYA/g;
$listdata[$i] =~ s/\{\{POI\}\} GRIYA \{\{KEC\}\}/\{\{POI\}\} GRIYA/g;
}
#menghilangkan tag PROV|KAB|KEC|KEL yang berada dibelakang kata-kata tertentu
if ($listdata[$i] =~ /((\{\{JL|POI\}\}*)([ A-Z]*) \{\{KEL|KEC|KAB|PROV\}\} \{\{KEL|KEC|KAB|PROV\}\}) || ((\{\{JL|POI\}\}*)([ A-Z]*) \{\{KEL|KEC|KAB|PROV\}\})/) {
$listdata[$i] =~ s/\{\{JL\}\} RAYA JENDERAL \{\{KEL\}\}/\{\{JL\}\} RAYA JENDERAL/g;
$listdata[$i] =~ s/\{\{JL\}\} RAYA JENDRAL \{\{KEL\}\}/\{\{JL\}\} RAYA JENDRAL/g;
$listdata[$i] =~ s/\{\{JL\}\} RAYA JEND \{\{KEL\}\}/\{\{JL\}\} RAYA JEND/g;
$listdata[$i] =~ s/\{\{JL\}\} JENDERAL \{\{KEL\}\}/\{\{JL\}\} JENDERAL/g;
$listdata[$i] =~ s/\{\{JL\}\} JENDRAL \{\{KEL\}\}/\{\{JL\}\} JENDRAL/g;
$listdata[$i] =~ s/\{\{JL\}\} MAYJEND \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} MAYJEND/g;
$listdata[$i] =~ s/\{\{JL\}\} BRIGJEND \{\{KEL\}\}/\{\{JL\}\} BRIGJEND/g;
$listdata[$i] =~ s/\{\{JL\}\} BRIJEND \{\{KEL\}\}/\{\{JL\}\} BRIJEND/g;
$listdata[$i] =~ s/\{\{JL\}\} JEND \{\{KEL\}\}/\{\{JL\}\} JEND/g;
$listdata[$i] =~ s/ JEND \{\{KEL\}\}/ \{\{JEND\}\}/g;
$listdata[$i] =~ s/\{\{JL\}\} GANG \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} GANG/g;
$listdata[$i] =~ s/\{\{JL\}\} GANG \{\{KEL\}\}/\{\{JL\}\} GANG/g;
$listdata[$i] =~ s/ GANG \{\{KEL\}\} \{\{KEC\}\}/ \{\{GANG\}\}/g;
$listdata[$i] =~ s/ GANG \{\{KEL\}\}/ \{\{GANG\}\}/g;
$listdata[$i] =~ s/ GANG \{\{KAB\}\}/ \{\{GANG\}\}/g;
$listdata[$i] =~ s/ GANG \{\{KEC\}\}/ \{\{GANG\}\}/g;
$listdata[$i] =~ s/ GANG \{\{PROV\}\}/ \{\{GANG\}\}/g;
$listdata[$i] =~ s/\{\{JL\}\} RAYA MASJID \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} RAYA MASJID/g;
$listdata[$i] =~ s/\{\{JL\}\} RAYA MASJID \{\{KEL\}\}/\{\{JL\}\} RAYA MASJID/g;
$listdata[$i] =~ s/\{\{JL\}\} MASJID \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} MASJID/g;
$listdata[$i] =~ s/\{\{JL\}\} MASJID \{\{KEL\}\}/\{\{JL\}\} MASJID/g;
$listdata[$i] =~ s/\{\{JL\}\} BALAI \{\{KEL\}\}/\{\{JL\}\} BALAI/g;
$listdata[$i] =~ s/\{\{JL\}\} BALAI \{\{KEC\}\}/\{\{JL\}\} BALAI/g;
$listdata[$i] =~ s/\{\{JL\}\} BALAI \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} BALAI/g;
$listdata[$i] =~ s/\{\{JL\}\} SIMPANG IMAM \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} SIMPANG IMAM/g;
$listdata[$i] =~ s/\{\{JL\}\} IMAM \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} IMAM/g;
$listdata[$i] =~ s/ IMAM \{\{KEL\}\} \{\{KEC\}\}/ \{\{IMAM\}\}/g;
$listdata[$i] =~ s/\{\{JL\}\} RAYA KEDUNG \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} RAYA KEDUNG/g;
$listdata[$i] =~ s/\{\{JL\}\} RAYA KEDUNG \{\{KEL\}\}/\{\{JL\}\} RAYA KEDUNG/g;
$listdata[$i] =~ s/\{\{JL\}\} KEDUNG \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} KEDUNG/g;
$listdata[$i] =~ s/\{\{JL\}\} KEDUNG \{\{KEL\}\}/\{\{JL\}\} KEDUNG/g;
$listdata[$i] =~ s/\{\{JL\}\} KAWASAN \{\{KEL\}\}/\{\{JL\}\} KAWASAN/g;
$listdata[$i] =~ s/KAWASAN NIAGA \{\{KEL\}\}/\{\{KAWASAN NIAGA\}\}/g;
$listdata[$i] =~ s/KAWASAN \{\{KEL\}\}/\{\{KAWASAN\}\}/g;
$listdata[$i] =~ s/\{\{JL\}\} TUGU \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} TUGU/g;
$listdata[$i] =~ s/\{\{JL\}\} TUGU \{\{KEL\}\}/\{\{JL\}\} TUGU/g;
$listdata[$i] =~ s/\{\{JL\}\} RUNGKUT KIDUL \{\{KEL\}\}/\{\{JL\}\} RUNGKUT KIDUL/g;
$listdata[$i] =~ s/\{\{JL\}\} RUNGKUT \{\{KEL\}\}/\{\{JL\}\} RUNGKUT/g;
$listdata[$i] =~ s/\{\{JL\}\} RAYA BATU \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} RAYA BATU/g;
$listdata[$i] =~ s/\{\{JL\}\} RAYA BATU \{\{KEL\}\}/\{\{JL\}\} RAYA BATU/g;
$listdata[$i] =~ s/\{\{JL\}\} BATU \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} BATU/g;
$listdata[$i] =~ s/\{\{JL\}\} BATU \{\{KEL\}\}/\{\{JL\}\} BATU/g;
$listdata[$i] =~ s/\{\{JL\}\} BATU \{\{KEC\}\}/\{\{JL\}\} BATU/g;
$listdata[$i] =~ s/\{\{JL\}\} BENGAWAN \{\{KEL\}\}/\{\{JL\}\} BENGAWAN/g;
$listdata[$i] =~ s/BENGAWAN \{\{KEL\}\}/\{\{BENGAWAN\}\}/g;
$listdata[$i] =~ s/\{\{JL\}\} SULTAN \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} SULTAN/g;
$listdata[$i] =~ s/\{\{JL\}\} SULTAN \{\{KEL\}\}/\{\{JL\}\} SULTAN/g;
$listdata[$i] =~ s/BANK \{\{KEL\}\} \{\{PROV\}\}/\{\{BANK\}\}/g;
$listdata[$i] =~ s/BANK \{\{KEL\}\} \{\{KEC\}\}/\{\{BANK\}\}/g;
$listdata[$i] =~ s/BANK \{\{KEL\}\}/\{\{BANK\}\}/g;
$listdata[$i] =~ s/BANK \{\{PROV\}\}/\{\{BANK\}\}/g;
$listdata[$i] =~ s/\{\{JL\}\} KAMPUNG \{\{KEL\}\} \{\{KAB\}\}/\{\{JL\}\} KAMPUNG/g;
$listdata[$i] =~ s/\{\{JL\}\} KAMPUNG \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} KAMPUNG/g;
$listdata[$i] =~ s/\{\{JL\}\} KAMPUNG \{\{KEL\}\}/\{\{JL\}\} KAMPUNG/g;
$listdata[$i] =~ s/\{\{JL\}\} KAMPUNG \{\{KEC\}\}/\{\{JL\}\} KAMPUNG/g;
$listdata[$i] =~ s/\{\{JL\}\} RAYA SUNAN \{\{KEL\}\}/\{\{JL\}\} RAYA SUNAN/g;
$listdata[$i] =~ s/\{\{JL\}\} SUNAN \{\{KEL\}\} \{\{KAB\}\}/\{\{JL\}\} SUNAN/g;
$listdata[$i] =~ s/\{\{JL\}\} SUNAN \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} SUNAN/g;
$listdata[$i] =~ s/\{\{JL\}\} SUNAN \{\{KEL\}\}/\{\{JL\}\} SUNAN/g;
$listdata[$i] =~ s/\{\{JL\}\} BESAR \{\{KEL\}\} \{\{KEC\}\} \{\{KAB\}\}/\{\{JL\}\} BESAR/g;
$listdata[$i] =~ s/\{\{JL\}\} BESAR \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} BESAR/g;
$listdata[$i] =~ s/\{\{JL\}\} BESAR \{\{KEL\}\}/\{\{JL\}\} BESAR/g;
$listdata[$i] =~ s/\{\{JL\}\} BESAR \{\{KEC\}\}/\{\{JL\}\} BESAR/g;
$listdata[$i] =~ s/\{\{JL\}\} LINTAS \{\{KEL\}\} \{\{KEC\}\} \{\{KAB\}\}/\{\{JL\}\} LINTAS/g;
$listdata[$i] =~ s/\{\{JL\}\} LINTAS \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} LINTAS/g;
$listdata[$i] =~ s/\{\{JL\}\} LINTAS \{\{KEL\}\}/\{\{JL\}\} LINTAS/g;
$listdata[$i] =~ s/\{\{JL\}\} LINTAS \{\{KAB\}\}/\{\{JL\}\} LINTAS/g;
$listdata[$i] =~ s/\{\{JL\}\} LINTAS \{\{KEC\}\}/\{\{JL\}\} LINTAS/g;
$listdata[$i] =~ s/RAYA \{\{KEL\}\} \{\{KEC\}\} \{\{KAB\}\}/\{\{RAYA\}\}/g;
$listdata[$i] =~ s/RAYA \{\{KEL\}\} \{\{KEC\}\}/\{\{RAYA\}\}/g;
$listdata[$i] =~ s/RAYA \{\{KEL\}\} \{\{KAB\}\}/\{\{RAYA\}\}/g;
$listdata[$i] =~ s/RAYA \{\{KEL\}\}/\{\{RAYA\}\}/g;
$listdata[$i] =~ s/RAYA \{\{KEC\}\}/\{\{RAYA\}\}/g;
$listdata[$i] =~ s/\{\{JL\}\} RAYA RA \{\{KEL\}\}/\{\{JL\}\} RAYA RA/g;
$listdata[$i] =~ s/\{\{JL\}\} RA \{\{KEL\}\}/\{\{JL\}\} RA/g;
$listdata[$i] =~ s/\{\{JL\}\} RAYA PB \{\{KEL\}\}/\{\{JL\}\} RAYA PB/g;
$listdata[$i] =~ s/\{\{JL\}\} PB \{\{KEL\}\}/\{\{JL\}\} PB/g;
$listdata[$i] =~ s/PB \{\{KEL\}\}/\{\{PB\}\}/g;
$listdata[$i] =~ s/\{\{JL\}\} HOS \{\{KEL\}\}/\{\{JL\}\} HOS/g;
$listdata[$i] =~ s/\{\{JL\}\} TEUKU \{\{KEL\}\}/\{\{JL\}\} TEUKU/g;
}
#menghilangkan tag PROV|KAB|KEC|KEL yang berada dibelakang kata-kata tertentu
if ($listdata[$i] =~ /((\{\{JL|POI\}\}*)([ A-Z]*) \{\{KEL|KEC|KAB|PROV\}\} \{\{KEL|KEC|KAB|PROV\}\} \{\{KEL|KEC|KAB|PROV\}\}) || ((\{\{JL|POI\}\}*)([ A-Z]*) \{\{KEL|KEC|KAB|PROV\}\} \{\{KEL|KEC|KAB|PROV\}\}) || ((\{\{JL|POI\}\}*)([ A-Z]*) \{\{KEL|KEC|KAB|PROV\}\}) || (DEPAN RSU \{\{KEL\}\} CUT~) || (SISINGAMANGARAJA KAMPUNG \{\{KEL|KEC|KAB|PROV\}\}) || \{\{JL\}\} BLANG~/) {
$listdata[$i] =~ s/\{\{JL\}\} NASIONAL \{\{KEL\}\} \{\{KEC\}\} \{\{KAB\}\}/\{\{JL\}\} NASIONAL/g;
$listdata[$i] =~ s/\{\{JL\}\} TM \{\{KEL\}\}/\{\{JL\}\} TM/g;
$listdata[$i] =~ s/\{\{JL\}\} INONG \{\{KEL\}\}/\{\{JL\}\} INONG/g;
$listdata[$i] =~ s/\{\{JL\}\} BLANG~/\{\{JL\}\} BLANG/g;
$listdata[$i] =~ s/\{\{JL\}\} BLANG \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} BLANG/g;
$listdata[$i] =~ s/\{\{JL\}\} LISTRIK \{\{KEL\}\}/\{\{JL\}\} LISTRIK/g;
$listdata[$i] =~ s/DEPAN RSU \{\{KEL\}\} CUT~/DEPAN RSU CUT/g;
$listdata[$i] =~ s/\{\{JL\}\} UTAMA \{\{KEL\}\}/\{\{JL\}\} UTAMA/g;
$listdata[$i] =~ s/\{\{JL\}\} RAMA \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} RAMA/g;
$listdata[$i] =~ s/SISINGAMANGARAJA KAMPUNG \{\{KEL\}\} \{\{KEC\}\}/SISINGAMANGARAJA KAMPUNG/g;
$listdata[$i] =~ s/\{\{JL\}\} NYAK \{\{KEL\}\}/\{\{JL\}\} NYAK/g;
$listdata[$i] =~ s/\{\{JL\}\} HAMZAH \{\{KEC\}\}/\{\{JL\}\} HAMZAH/g;
$listdata[$i] =~ s/\{\{JL\}\} T \{\{KEL\}\}/\{\{JL\}\} T/g;
$listdata[$i] =~ s/\{\{JL\}\} TGK DI \{\{KEL\}\}/\{\{JL\}\} TGK DI/g;
$listdata[$i] =~ s/\{\{JL\}\} HASAN \{\{KEL\}\}/\{\{JL\}\} HASAN/g;
$listdata[$i] =~ s/\{\{JL\}\} T MAKAM \{\{KEL\}\}/\{\{JL\}\} T MAKAM/g;
$listdata[$i] =~ s/\{\{JL\}\} BANDARA SULTAN ISKANDAR MUDA AJE \{\{KEL\}\}/\{\{JL\}\} BANDARA SULTAN ISKANDAR MUDA AJE/g;
$listdata[$i] =~ s/\{\{POI\}\} PASAR ULEE \{\{KEL\}\}/\{\{POI\}\} PASAR ULEE/g;
$listdata[$i] =~ s/\{\{POI\}\} KOMPLEK TERMINAL \{\{KEC\}\}/\{\{POI\}\} KOMPLEK TERMINAL/g;
$listdata[$i] =~ s/\{\{JL\}\} BUANA \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} BUANA/g;
$listdata[$i] =~ s/\{\{JL\}\} GN \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} GN/g;
$listdata[$i] =~ s/\{\{JL\}\} GN \{\{KEC\}\}/\{\{JL\}\} GN/g;
$listdata[$i] =~ s/\{\{JL\}\} IDA \{\{KEL\}\}/\{\{JL\}\} IDA/g;
$listdata[$i] =~ s/\{\{JL\}\} RAYA TAMAN ~\{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} RAYA TAMAN/g;
$listdata[$i] =~ s/\{\{JL\}\} P \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} P/g;
$listdata[$i] =~ s/\{\{JL\}\} P \{\{KAB\}\}/\{\{JL\}\} P/g;
$listdata[$i] =~ s/\{\{JL\}\} TUKAD \{\{KEL\}\} \{\{KAB\}\}/\{\{JL\}\} TUKAD/g;
$listdata[$i] =~ s/\{\{JL\}\} TUKAD \{\{KEL\}\}/\{\{JL\}\} TUKAD/g;
$listdata[$i] =~ s/\{\{JL\}\} TUKAD \{\{KEC\}\}/\{\{JL\}\} TUKAD/g;
$listdata[$i] =~ s/\{\{JL\}\} PULAU \{\{KEL\}\}/\{\{JL\}\} PULAU/g;
$listdata[$i] =~ s/\{\{JL\}\} BUNG \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} BUNG/g;
$listdata[$i] =~ s/\{\{JL\}\} CEKO \{\{KEL\}\}/\{\{JL\}\} CEKO/g;
$listdata[$i] =~ s/\{\{JL\}\} DN \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} DN/g;
$listdata[$i] =~ s/\{\{JL\}\} DN \{\{KEL\}\}/\{\{JL\}\} DN/g;
$listdata[$i] =~ s/\{\{JL\}\} HANOMAN \{\{KEL\}\} \{\{KEC\}\} \{\{KAB\}\}/\{\{JL\}\} HANOMAN/g;
$listdata[$i] =~ s/\{\{JL\}\} BYPASS IDA \{\{KEL\}\}/\{\{JL\}\} BYPASS IDA/g;
$listdata[$i] =~ s/\{\{JL\}\} PLAWA GG \{\{KEL\}\}/\{\{JL\}\} PLAWA GG/g;
$listdata[$i] =~ s/\{\{JL\}\} UMA \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} UMA/g;
$listdata[$i] =~ s/\{\{JL\}\} RAYA BATU \{\{KEL\}\}/\{\{JL\}\} RAYA BATU/g;
$listdata[$i] =~ s/\{\{JL\}\} KAYU \{\{KEL\}\}/\{\{JL\}\} KAYU/g;
$listdata[$i] =~ s/\{\{POI\}\} PASAR POH \{\{KEL\}\} \{\{KEC\}\}/\{\{POI\}\} PASAR POH/g;
$listdata[$i] =~ s/\{\{JL\}\} ANGANTAKA \{\{KEL\}\}/\{\{JL\}\} ANGANTAKA/g;
$listdata[$i] =~ s/\{\{JL\}\} TUNJUNG \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} TUNJUNG/g;
$listdata[$i] =~ s/\{\{JL\}\} DANAU \{\{KEL\}\}/\{\{JL\}\} DANAU/g;
$listdata[$i] =~ s/\{\{JL\}\} ULUN \{\{KEL\}\}/\{\{JL\}\} ULUN/g;
$listdata[$i] =~ s/\{\{JL\}\} SAKURA DPN \{\{KEL\}\}/\{\{JL\}\} SAKURA DPN/g;
$listdata[$i] =~ s/\{\{JL\}\} RAYA GOA \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} RAYA GOA/g;
$listdata[$i] =~ s/\{\{JL\}\} GOA \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} GOA/g;
$listdata[$i] =~ s/\{\{JL\}\} PANTAI \{\{KEL\}\}/\{\{JL\}\} PANTAI/g;
$listdata[$i] =~ s/\{\{POI\}\} PERUMAHAN PONDOK \{\{KEL\}\}/\{\{POI\}\} PERUMAHAN PONDOK/g;
$listdata[$i] =~ s/\{\{JL\}\} RAYA SEWAN \{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} RAYA SEWAN/g;
$listdata[$i] =~ s/\{\{JL\}\} KMP \{\{KEL\}\}/\{\{JL\}\} KMP/g;
$listdata[$i] =~ s/\{\{JL\}\} VILLA \{\{KEC\}\}/\{\{JL\}\} VILLA/g;
$listdata[$i] =~ s/\{\{POI\}\} RUKO SENTRA \{\{KEL\}\} \{\{KEC\}\}/\{\{POI\}\} RUKO SENTRA/g;
$listdata[$i] =~ s/\{\{JL\}\} ISKANDAR MUDA \{\{KEL\}\}/\{\{JL\}\} ISKANDAR MUDA/g;
}
#menghilangkan tag PROV|KAB|KEC|KEL yang berada dibelakang kata-kata tertentu
if ($listdata[$i] =~ /((\{\{JL|POI\}\}*)([ A-Z]*) \{\{KEL|KEC|KAB|PROV\}\} \{\{KEL|KEC|KAB|PROV\}\} \{\{KEL|KEC|KAB|PROV\}\}) || ((\{\{JL|POI\}\}*)([ A-Z]*) \{\{KEL|KEC|KAB|PROV\}\} \{\{KEL|KEC|KAB|PROV\}\}) || ((\{\{JL|POI\}\}*)([ A-Z]*) \{\{KEL|KEC|KAB|PROV\}\})/) {
$listdata[$i] =~ s/\{\{JL\}\} SURYA \{\{KEL\}\}/\{\{JL\}\} SURYA/g;
$listdata[$i] =~ s/\{\{JL\}\} H WAWI \{\{KEL\}\}/\{\{JL\}\} H WAWI/g;
$listdata[$i] =~ s/\{\{JL\}\} RAYA GRAHA\{\{KEL\}\} \{\{KEC\}\}/\{\{JL\}\} RAYA GRAHA/g;
}
print OUT3 $listdata[$i]."\n";
}
}
close(FILE3);
close(FILE4);
close(FILE5);
close(FILE6);
close(FILE7);
close(OUT2);
close(OUT3);

##CODINGAN PART 4 INI UNTUK MENGHILANGKAN TANDA ~ YANG BERLEBIHAN
#!C:/Perl64/bin/perl.exe -w
open (OUT4, 'matching/StringHasil1.txt') or die "can't open";
open (OUT5, '>matching/StringHasil2.txt') or die "can't open";
@lines = <OUT4>;
$input = "@lines";
foreach ($input =~ /\{\{/) {
@listdata = split(/\{\{/, $input);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
#menghilangkan tanda ~ dari kata-kata tertentu yang diawali dengan JL atau POI
if ($listdata[$i] =~ /([A-Z])~ RAYA/) {
do nothing;
}
elsif ($listdata[$i] =~ /JL|POI| GANG|JEND|IMAM|KAWASAN|KAWASAN NIAGA|BENGAWAN|BANK|PB\}\} ([A-Z-]*\~)/ || $listdata[$i] =~ /JL|POI| GANG|JEND|IMAM|KAWASAN|KAWASAN NIAGA|BENGAWAN|BANK|PB\}\} ([A-Z-]*) ([A-Z-]*\~)/ || $listdata[$i] =~ /JL|POI| GANG|JEND|IMAM|KAWASAN|KAWASAN NIAGA|BENGAWAN|BANK|PB\}\} ([A-Z-]*) ([A-Z-]*) ([A-Z-]*\~)/ || $listdata[$i] =~ /JL|POI| GANG|JEND|IMAM|KAWASAN|KAWASAN NIAGA|BENGAWAN|BANK|PB\}\} ([A-Z-]*) ([A-Z-]*) ([A-Z-]*) ([A-Z-]*\~)/) {
$listdata[$i] =~ s/~//;
}
#menambahkan tanda \{\{ pada kata JL\}\}, NO\}\}, DLL
if ($listdata[$i] =~ /JL\}\}|NO\}\}|PROV\}\}|KAB\}\}|KEC\}\}|KEL\}\}|POI\}\}|BLOK\}\}|RT\}\}|RW\}\}/) {
$listdata[$i] =~ s/JL\}\}/\{\{JL\}\}/g;
$listdata[$i] =~ s/NO\}\}/\{\{NO\}\}/g;
$listdata[$i] =~ s/PROV\}\}/\{\{PROV\}\}/g;
$listdata[$i] =~ s/KAB\}\}/\{\{KAB\}\}/g;
$listdata[$i] =~ s/KEC\}\}/\{\{KEC\}\}/g;
$listdata[$i] =~ s/KEL\}\}/\{\{KEL\}\}/g;
$listdata[$i] =~ s/POI\}\}/\{\{POI\}\}/g;
$listdata[$i] =~ s/BLOK\}\}/\{\{BLOK\}\}/g;
$listdata[$i] =~ s/RT\}\}/\{\{RT\}\}/g;
$listdata[$i] =~ s/RW\}\}/\{\{RW\}\}/g;
}
print OUT5 $listdata[$i];
}
}
close (OUT4);
close (OUT5);

##CODINGAN PART 5 INI UNTUK MENGHILANGKAN TANDA SPASI DIANTARA PROV KAB KEC KEL
#!C:/Perl64/bin/perl.exe -w
open (OUT6, 'matching/StringHasil2.txt') or die "can't open";
open (OUT7, '>matching/StringHasil3.txt') or die "can't open";
@lines = <OUT6>;
$input = "@lines";
if ($input =~ /\{\{KEL\}\} \{\{KEC\}\} \{\{KAB\}\}|\{\{KEC\}\} \{\{KAB\}\}|\{\{KEL\}\} \{\{KAB\}\}|\{\{KEL\}\} \{\{KEC\}\}|\{\{KEL\}\} \{\{KAB\}\} \{\{PROV\}\}|\{\{KEL\}\} \{\{PROV\}\}| \{\{PROV\}\} | \{\{KAB\}\} | \{\{KEC\}\} | \{\{KEL\}\} /) {
$input =~ s/\{\{KEL\}\} \{\{KEC\}\} \{\{KAB\}\}/\{\{KEL\}\}\{\{KEC\}\}\{\{KAB\}\}/g;
$input =~ s/\{\{KEL\}\} \{\{KEC\}\}/\{\{KEL\}\}\{\{KEC\}\}/g;
$input =~ s/\{\{KEL\}\} \{\{KAB\}\} \{\{PROV\}\}/\{\{KEL\}\}\{\{KAB\}\}\{\{PROV\}\}/g;
$input =~ s/\{\{KEL\}\} \{\{KAB\}\}/\{\{KEL\}\}\{\{KAB\}\}/g;
$input =~ s/\{\{KEL\}\} \{\{PROV\}\}/\{\{KEL\}\}\{\{PROV\}\}/g;
$input =~ s/\{\{KEC\}\} \{\{KAB\}\}/\{\{KEC\}\}\{\{KAB\}\}/g;
$input =~ s/ \{\{PROV\}\} / ~\{\{PROV\}\} /g;
$input =~ s/ \{\{KAB\}\} / ~\{\{KAB\}\} /g;
$input =~ s/ \{\{KEC\}\} / ~\{\{KEC\}\} /g;
$input =~ s/ \{\{KEL\}\} / ~\{\{KEL\}\} /g;
$input =~ s/ GANG\}\} / GANG /g;
$input =~ s/ JEND\}\} / JEND /g;
$input =~ s/ IMAM\}\} / IMAM /g;
$input =~ s/ KAWASAN\}\} / KAWASAN /g;
$input =~ s/ KAWASAN NIAGA\}\} / KAWASAN NIAGA /g;
$input =~ s/ BENGAWAN\}\} / BENGAWAN /g;
$input =~ s/ BANK\}\} / BANK /g;
$input =~ s/ RAYA\}\} / RAYA /g;
$input =~ s/ PB\}\} / PB /g;
}
print OUT7 $input;
close (OUT6);
close (OUT7);

##CODINGAN PART 6 INI UNTUK MENAMBAHKAN TANDA ~ DAN TANDA SPASI DIANTARA PROV KAB KEC KEL
#!C:/Perl64/bin/perl.exe -w
open (OUT8, 'matching/StringHasil3.txt') or die "can't open";
open (OUT9, '>matching/StringHasil4.txt') or die "can't open";
@lines = <OUT8>;
$input = "@lines";
if ($input =~ /\{\{KEL\}\}\{\{KEC\}\}\{\{KAB\}\}|\{\{KEC\}\}\{\{KAB\}\}|\{\{KEL\}\}\{\{KAB\}\}|\{\{KEL\}\}\{\{KEC\}\}|\{\{KEL\}\}\{\{KAB\}\}\{\{PROV\}\}|\{\{KEL\}\}\{\{PROV\}\}/) {
$input =~ s/\{\{KEL\}\}\{\{KEC\}\}\{\{KAB\}\}/~\{\{KEL\}\} \{\{KEC\}\} \{\{KAB\}\}/g;
$input =~ s/\{\{KEL\}\}\{\{KEC\}\}/~\{\{KEL\}\} \{\{KEC\}\}/g;
$input =~ s/\{\{KEL\}\}\{\{KAB\}\}\{\{PROV\}\}/~\{\{KEL\}\} \{\{KAB\}\} \{\{PROV\}\}/g;
$input =~ s/\{\{KEL\}\}\{\{KAB\}\}/~\{\{KEL\}\} \{\{KAB\}\}/g;
$input =~ s/\{\{KEL\}\}\{\{PROV\}\}/~\{\{KEL\}\} \{\{PROV\}\}/g;
$input =~ s/\{\{KEC\}\}\{\{KAB\}\}/~\{\{KEC\}\} \{\{KAB\}\}/g;
}
if ($input =~ /\{\{JL\}\} KOTA MEDAN ~\{\{KAB\}\} BANDA ACEH~ || RSUD ~\{\{KEC\}\} MEURAXA~ || \{\{JL\}\} BLANG BINTANG LAMA ~\{\{KEL\}\} COT~ || \{\{JL\}\} BANDARA SULTAN ISKANDAR MUDA ~\{\{KEL\}\} COT~ GENDRUT || \{\{JL\}\} BANDARA SULTAN ISKANDAR MUDA ~\{\{KEL\}\} COT~ SIROI || \{\{JL\}\} BANDA ACEH ~\{\{KEL\}\} \{\{KAB\}\} KOTA MEDAN~ \{\{NO\}\} 7 8 ~\{\{KEC\}\} ULIM~ || \{\{JL\}\} KOTA MEDAN ~\{\{KEL\}\} \{\{KEC\}\} BANDA~ ACEHNO 91 LEUNG PUTU ~\{\{KAB\}\} PIDIE JAYA~ || \{\{JL\}\} KINTAMANI ~\{\{KEL\}\} SINGARAJA~ || \{\{JL\}\} ABIAN BASE BR ~\{\{KEL\}\} MUNCAN~ ~\{\{KEL\}\} KAPAL~ || \{\{JL\}\} KUBU ~\{\{KEL\}\} SINGARAJA~ || \{\{JL\}\} ABIMANYU \{\{NO\}\} 1 SBLH ~\{\{KEL\}\} \{\{KEC\}\} \{\{KAB\}\} BANJAR~ || \{\{JL\}\} PULAU ~\{\{KEL\}\} MOYO~ DEPAN \{\{POI\}\} PERUMAHAN WAKALOUKA ~\{\{KEL\}\} PEMOGAN~ || \{\{JL\}\} TRENGGULI \{\{NO\}\} 98 SAMPING ~\{\{KEL\}\} \{\{KEC\}\} \{\{KAB\}\} BANJAR~ KALAH ||  \{\{JL\}\} SEKAR ~\{\{KEL\}\} \{\{KEC\}\} GADUNG~ TRENGGANA \{\{NO\}\} 2 ~\{\{KEL\}\} TONJA~ || \{\{JL\}\} SEKAR ~\{\{KEL\}\} TUNJUNG~ III \{\{NO\}\} 26 ~\{\{KEL\}\} KESIMAN~ || \{\{JL\}\} BATUHYANGNO 993 ~\{\{KEL\}\} BATU BULAN~ || \{\{JL\}\} PANTAI ~\{\{KEL\}\} KELATING~ || \{\{JL\}\} SEMER ( UTARA ~\{\{KEL\}\} KAWAN~ ) ~\{\{KEL\}\} KEROBOKAN~\{\{JL\}\} BATUR~ RAYA 33 ~\{\{KEC\}\} TAMAN~ \{\{POI\}\} GRIYA/) {
$input =~ s/\{\{JL\}\} KOTA MEDAN ~\{\{KAB\}\} BANDA ACEH~/\{\{JL\}\} BANDA ACEH - MEDAN/g;
$input =~ s/RSUD ~\{\{KEC\}\} MEURAXA~/RSUD MEURAXA/g;
$input =~ s/\{\{JL\}\} BLANG BINTANG LAMA ~\{\{KEL\}\} COT~/\{\{JL\}\} BLANG BINTANG LAMA COT/g;
$input =~ s/\{\{JL\}\} BANDARA SULTAN ISKANDAR MUDA ~\{\{KEL\}\} COT~ GENDRUT/\{\{JL\}\} BANDARA SULTAN ISKANDAR MUDA COT GENDRUT/g;
$input =~ s/\{\{JL\}\} BANDARA SULTAN ISKANDAR MUDA ~\{\{KEL\}\} COT~ SIROI/\{\{JL\}\} BANDARA SULTAN ISKANDAR MUDA COT SIROI/g;
$input =~ s/\{\{JL\}\} BANDA ACEH ~\{\{KEL\}\} \{\{KAB\}\} KOTA MEDAN~/\{\{JL\}\} MEDAN - BANDA ACEH/g;
$input =~ s/\{\{JL\}\} KOTA MEDAN ~\{\{KEL\}\} \{\{KEC\}\} BANDA~ ACEHNO 91 LEUNG PUTU ~\{\{KAB\}\} PIDIE JAYA~/\{\{JL\}\} MEDAN - BANDA ACEH NO 91 LEUNG PUTU ~\{\{KAB\}\} PIDIE JAYA~/g;
$input =~ s/\{\{JL\}\} KINTAMANI ~\{\{KEL\}\} SINGARAJA~/\{\{JL\}\} KINTAMANI SINGARAJA/g;
$input =~ s/\{\{JL\}\} ABIAN BASE BR ~\{\{KEL\}\} MUNCAN~ ~\{\{KEL\}\} KAPAL~/\{\{JL\}\} ABIAN BASE BR MUNCAN ~\{\{KEL\}\} KAPAL~/g;
$input =~ s/\{\{JL\}\} KUBU ~\{\{KEL\}\} SINGARAJA~/\{\{JL\}\} KUBU SINGARAJA/g;
$input =~ s/\{\{JL\}\} ABIMANYU \{\{NO\}\} 1 SBLH ~\{\{KEL\}\} \{\{KEC\}\} \{\{KAB\}\} BANJAR~/\{\{JL\}\} ABIMANYU \{\{NO\}\} 1 SBLH BANJAR/g;
$input =~ s/\{\{JL\}\} PULAU ~\{\{KEL\}\} MOYO~ DEPAN \{\{POI\}\} PERUMAHAN WAKALOUKA ~\{\{KEL\}\} PEMOGAN~/\{\{JL\}\} PULAU MOYO DEPAN \{\{POI\}\} PERUMAHAN WAKALOUKA ~\{\{KEL\}\} PEMOGAN~/g;
$input =~ s/\{\{JL\}\} TRENGGULI \{\{NO\}\} 98 SAMPING ~\{\{KEL\}\} \{\{KEC\}\} \{\{KAB\}\} BANJAR~ KALAH/\{\{JL\}\} TRENGGULI \{\{NO\}\} 98 SAMPING BANJAR KALAH/g;
$input =~ s/\{\{JL\}\} SEKAR ~\{\{KEL\}\} \{\{KEC\}\} GADUNG~ TRENGGANA \{\{NO\}\} 2 ~\{\{KEL\}\} TONJA~/\{\{JL\}\} SEKAR GADUNG TRENGGANA \{\{NO\}\} 2 ~\{\{KEL\}\} TONJA~/g;
$input =~ s/\{\{JL\}\} SEKAR ~\{\{KEL\}\} TUNJUNG~ III \{\{NO\}\} 26 ~\{\{KEL\}\} KESIMAN~/\{\{JL\}\} SEKAR TUNJUNG III \{\{NO\}\} 26 ~\{\{KEL\}\} KESIMAN~/g;
$input =~ s/\{\{JL\}\} BATUHYANGNO 993 ~\{\{KEL\}\} BATU BULAN~/\{\{JL\}\} BATUHYANG NO 993 ~\{\{KEL\}\} BATU BULAN~/g;
$input =~ s/\{\{JL\}\} PANTAI ~\{\{KEL\}\} KELATING~/\{\{JL\}\} PANTAI KELATING/g;
$input =~ s/\{\{JL\}\} SEMER ( UTARA ~\{\{KEL\}\} KAWAN~ ) ~\{\{KEL\}\} KEROBOKAN~/\{\{JL\}\} SEMER ( UTARA KAWAN ) ~\{\{KEL\}\} KEROBOKAN~/g;
$input =~ s/\{\{JL\}\} BATUR~ RAYA 33 ~\{\{KEC\}\} TAMAN~ \{\{POI\}\} GRIYA/\{\{JL\}\} BATUR RAYA 33 TAMAN GRIYA/g;
}
if ($input =~ /\{\{JL\}\} PULAU ~\{\{KEL\}\} MENJANGAN~ || \{\{JL\}\} \{\{POI\}\} PASAR KODOK || \{\{JL\}\} TUNJUNG ~\{\{KEL\}\} \{\{KEC\}\} TUTUR~ || \{\{JL\}\} PULAU ~\{\{KEL\}\} \{\{KAB\}\} BUTON~ || \{\{JL\}\} PULAU ~\{\{KEL\}\} \{\{KEC\}\} KOMODO~ || \{\{NO\}\} 1 ~\{\{KEL\}\} DARI~ || \{\{JL\}\} TAMAN ~\{\{KEL\}\} \{\{KEC\}\} GIRI~ || \{\{JL\}\} TKD ~\{\{KEL\}\} BALIAN~ || SELATAN SRI ~\{\{KEL\}\} NADI~ || SEBELAH ~\{\{KEL\}\} GUDANG~ || SAMPING YAMAHA ~\{\{KEL\}\} MUSTIKA~ || DPN DIST ~\{\{KEL\}\} SAMPURNA~ || TOKO SARI ~\{\{KEL\}\} REJEKI~ || TOKO ~\{\{KEC\}\} MAKALE~ ADEK II || DEPAN KAMPUS ~\{\{KEL\}\} NUSANTARA~ || \{\{POI\}\} RUKO GADING ~\{\{KEL\}\} \{\{KEC\}\} SERPONG~ || \{\{JL\}\} RAYA BSD ~\{\{KEL\}\} \{\{KEC\}\} PARUNG~ || \{\{JL\}\} SILI ~\{\{KEL\}\} WANGI~ DEPAN PT ~\{\{KEL\}\} SULUNG~ BUDI || ~\{\{KEL\}\} \{\{KEC\}\} GADING~ ~\{\{KEL\}\} \{\{KEC\}\} SERPONG~ || \{\{JL\}\} RAYA SEWAN ~\{\{KEL\}\} \{\{KEC\}\} RAWA~ ||  \{\{JL\}\} GRAHA RAYA BINTARO~ || \{\{JL\}\} MH THAMRIN ~\{\{KEL\}\} KEBON~ ~\{\{KEL\}\} NANAS~ || BSD ~\{\{KEL\}\} \{\{KEC\}\} PARUNG~ || ~\{\{KEC\}\} TAMAN~ ~\{\{KEL\}\} \{\{KEC\}\} CIBODAS~ || \{\{JL\}\} BOULEVARD ~\{\{KEL\}\} BINTARO~ JAYA || \{\{JL\}\} RAYA BOULEVARD ~\{\{KEL\}\} \{\{KEC\}\} PERMATA~/){
$input =~ s/\{\{JL\}\} PULAU ~\{\{KEL\}\} MENJANGAN~ /\{\{JL\}\} PULAU MENJANGAN/g;
$input =~ s/\{\{JL\}\} \{\{POI\}\} PASAR KODOK/\{\{JL\}\} PASAR KODOK/g;
$input =~ s/\{\{JL\}\} TUNJUNG ~\{\{KEL\}\} \{\{KEC\}\} TUTUR~/\{\{JL\}\} TUNJUNG TUTUR/g;
$input =~ s/\{\{JL\}\} PULAU ~\{\{KEL\}\} \{\{KAB\}\} BUTON~/\{\{JL\}\} PULAU BUTON/g;
$input =~ s/\{\{JL\}\} PULAU ~\{\{KEL\}\} \{\{KEC\}\} KOMODO~/\{\{JL\}\} PULAU KOMODO/g;
$input =~ s/\{\{NO\}\} 1 ~\{\{KEL\}\} DARI~/\{\{NO\}\} 1 DARI/g;
$input =~ s/\{\{JL\}\} TAMAN ~\{\{KEL\}\} \{\{KEC\}\} GIRI~/\{\{JL\}\} TAMAN GIRI/g;
$input =~ s/\{\{JL\}\} TKD ~\{\{KEL\}\} BALIAN~/\{\{JL\}\} TKD BALIAN/g;
$input =~ s/SELATAN SRI ~\{\{KEL\}\} NADI~/SELATAN SRI NADI/g;
$input =~ s/SEBELAH ~\{\{KEL\}\} GUDANG~/SEBELAH GUDANG/g;
$input =~ s/SAMPING YAMAHA ~\{\{KEL\}\} MUSTIKA~/SAMPING YAMAHA MUSTIKA/g;
$input =~ s/DPN DIST ~\{\{KEL\}\} SAMPURNA~/DPN DIST SAMPURNA/g;
$input =~ s/TOKO SARI ~\{\{KEL\}\} REJEKI~/TOKO SARI REJEKI/g;
$input =~ s/TOKO ~\{\{KEC\}\} MAKALE~ ADEK II/TOKO MAKALE ADEK II/g;
$input =~ s/DEPAN KAMPUS ~\{\{KEL\}\} NUSANTARA~/DEPAN KAMPUS NUSANTARA/g;
$input =~ s/\{\{POI\}\} RUKO GADING ~\{\{KEL\}\} \{\{KEC\}\} SERPONG~/\{\{POI\}\} RUKO GADING SERPONG/g;
$input =~ s/\{\{JL\}\} RAYA BSD ~\{\{KEL\}\} \{\{KEC\}\} PARUNG~/\{\{JL\}\} RAYA BSD PARUNG/g;
$input =~ s/\{\{JL\}\} SILI ~\{\{KEL\}\} WANGI~ DEPAN PT ~\{\{KEL\}\} SULUNG~ BUDI/\{\{JL\}\} SILI WANGI DEPAN PT SULUNG BUDI/g;
$input =~ s/~\{\{KEL\}\} \{\{KEC\}\} GADING~ ~\{\{KEL\}\} \{\{KEC\}\} SERPONG~/GADING ~\{\{KEL\}\} \{\{KEC\}\} SERPONG~/g;
$input =~ s/\{\{JL\}\} RAYA SEWAN ~\{\{KEL\}\} \{\{KEC\}\} RAWA~/\{\{JL\}\} RAYA SEWAN RAWA/g;
$input =~ s/\{\{JL\}\} GRAHA RAYA BINTARO~/\{\{JL\}\} GRAHA RAYA BINTARO/g;
$input =~ s/\{\{JL\}\} MH THAMRIN ~\{\{KEL\}\} KEBON~ ~\{\{KEL\}\} NANAS~/\{\{JL\}\} MH THAMRIN KEBON NANAS/g;
$input =~ s/BSD ~\{\{KEL\}\} \{\{KEC\}\} PARUNG~/BSD PARUNG/g;
$input =~ s/~\{\{KEC\}\} TAMAN~ ~\{\{KEL\}\} \{\{KEC\}\} CIBODAS~/TAMAN CIBODAS/g;
$input =~ s/\{\{JL\}\} BOULEVARD ~\{\{KEL\}\} BINTARO~ JAYA/\{\{JL\}\} BOULEVARD BINTARO JAYA/g;
$input =~ s/\{\{JL\}\} RAYA BOULEVARD ~\{\{KEL\}\} \{\{KEC\}\} PERMATA~/\{\{JL\}\} RAYA BOULEVARD PERMATA/g;
}
if ($input =~ /\{\{POI\}\} KOMPLEK VILLA ~\{\{KEL\}\} MELATI~ MAS || MINISTOP ~\{\{KEL\}\} BINTARO~ || \{\{JL\}\} ALAM ~\{\{KEC\}\} SUTERA~ || TOKO ~\{\{KEL\}\} KARYA~ || \{\{JL\}\} RAYA SUNAN ~\{\{KEC\}\} BONANG~ || \{\{JL\}\} CEGER~ || MESJID AL ~\{\{KEL\}\} MUHAJIRIN~ || \{\{JL\}\} DAMAI ~\{\{KEL\}\} \{\{KEC\}\} PESANGGRAHAN~ || \{\{JL\}\} ULUJAMI~ || \{\{JL\}\} RAWA ~\{\{KEL\}\} KUTRUK~ || \{\{POI\}\} MALL ALAM ~\{\{KEL\}\} SUTRA~ || \{\{JL\}\} HALIM ~\{\{KEL\}\} PERDANA~ KUSUMA || \{\{JL\}\} PONDOK AREN~ || RESTORAN ~\{\{KEL\}\} BAMBU~ || \{\{POI\}\} PERUMAHAN \{\{POI\}\} || GG ~\{\{KEL\}\} SADAR~ || \{\{BLOK\}\} ~\{\{KAB\}\} DENPASAR~ || \{\{JL\}\} TAMAN ~\{\{KEL\}\} \{\{KEC\}\} \{\{KAB\}\} KETAPANG~ || \{\{JL\}\} RAYA \{\{POI\}\} || \{\{JL\}\} PELOR ~\{\{KEL\}\} TUKANG~ ~\{\{KEL\}\} \{\{KEC\}\} KAJANG~ || \{\{JL\}\} SUMATERA ~\{\{KEL\}\} \{\{KEC\}\} RAWA~ ~\{\{KEL\}\} LELE~ || \{\{POI\}\} GEDUNG ANA ~\{\{KEL\}\} BATIK~ || TK ~\{\{KEL\}\} BOB~ || RM ~\{\{KEL\}\} \{\{KEC\}\} \{\{KAB\}\} PADANG~ || SAMPING ~\{\{KEL\}\} YAYASAN~ || \{\{JL\}\} WARU ~\{\{KEL\}\} DOYONG~ ~\{\{KEL\}\} \{\{KEC\}\} JAYANTI~ || ALAM ~\{\{KEL\}\} SUTRA~ || TOKO ~\{\{KEL\}\} \{\{KEC\}\} BINTANG~ || ALAM ~\{\{KEC\}\} SUTERA~ || TOKO ~\{\{KEL\}\} BUDI LESTARI~/) {
$input =~ s/\{\{POI\}\} KOMPLEK VILLA ~\{\{KEL\}\} MELATI~ MAS/\{\{POI\}\} KOMPLEK VILLA MELATI MAS/g;
$input =~ s/MINISTOP ~\{\{KEL\}\} BINTARO~/MINISTOP BINTARO/g;
$input =~ s/\{\{JL\}\} ALAM ~\{\{KEC\}\} SUTERA~/\{\{JL\}\} ALAM SUTERA/g;
$input =~ s/TOKO ~\{\{KEL\}\} KARYA~/TOKO KARYA/g;
$input =~ s/\{\{JL\}\} RAYA SUNAN ~\{\{KEC\}\} BONANG~/\{\{JL\}\} RAYA SUNAN BONANG/g;
$input =~ s/\{\{JL\}\} CEGER~/\{\{JL\}\} CEGER/g;
$input =~ s/MESJID AL ~\{\{KEL\}\} MUHAJIRIN~/MESJID AL MUHAJIRIN/g;
$input =~ s/\{\{JL\}\} DAMAI ~\{\{KEL\}\} \{\{KEC\}\} PESANGGRAHAN~/\{\{JL\}\} DAMAI PESANGGRAHAN/g;
$input =~ s/\{\{JL\}\} ULUJAMI~/\{\{JL\}\} ULUJAMI/g;
$input =~ s/\{\{JL\}\} RAWA ~\{\{KEL\}\} KUTRUK~/\{\{JL\}\} RAWA KUTRUK/g;
$input =~ s/\{\{POI\}\} MALL ALAM ~\{\{KEL\}\} SUTRA~/\{\{POI\}\} MALL ALAM SUTRA/g;
$input =~ s/\{\{JL\}\} HALIM ~\{\{KEL\}\} PERDANA~ KUSUMA/\{\{JL\}\} HALIM PERDANA KUSUMA/g;
$input =~ s/\{\{JL\}\} PONDOK AREN~/\{\{JL\}\} PONDOK AREN/g;
$input =~ s/RESTORAN ~\{\{KEL\}\} BAMBU~/RESTORAN BAMBU/g;
$input =~ s/\{\{POI\}\} PERUMAHAN \{\{POI\}\}/\{\{POI\}\} PERUMAHAN/g;
$input =~ s/GG ~\{\{KEL\}\} SADAR~/GG SADAR/g;
$input =~ s/\{\{BLOK\}\} ~\{\{KAB\}\} DENPASAR~/\{\{BLOK\}\} DENPASAR/g;
$input =~ s/\{\{JL\}\} TAMAN ~\{\{KEL\}\} \{\{KEC\}\} \{\{KAB\}\} KETAPANG~/\{\{JL\}\} TAMAN KETAPANG/g;
$input =~ s/\{\{JL\}\} RAYA \{\{POI\}\}/\{\{JL\}\} RAYA/g;
$input =~ s/\{\{JL\}\} PELOR ~\{\{KEL\}\} TUKANG~ ~\{\{KEL\}\} \{\{KEC\}\} KAJANG~/\{\{JL\}\} PELOR TUKANG KAJANG/g;
$input =~ s/\{\{JL\}\} SUMATERA ~\{\{KEL\}\} \{\{KEC\}\} RAWA~ ~\{\{KEL\}\} LELE~/\{\{JL\}\} SUMATERA RAWA LELE/g;
$input =~ s/\{\{POI\}\} GEDUNG ANA ~\{\{KEL\}\} BATIK~/\{\{POI\}\} GEDUNG ANA BATIK/g;
$input =~ s/TK ~\{\{KEL\}\} BOB~/TK BOB/g;
$input =~ s/RM ~\{\{KEL\}\} \{\{KEC\}\} \{\{KAB\}\} PADANG~/RM PADANG/g;
$input =~ s/SAMPING ~\{\{KEL\}\} YAYASAN~/SAMPING YAYASAN/g;
$input =~ s/\{\{JL\}\} WARU ~\{\{KEL\}\} DOYONG~ ~\{\{KEL\}\} \{\{KEC\}\} JAYANTI~/\{\{JL\}\} WARU DOYONG JAYANTI/g;
$input =~ s/ALAM ~\{\{KEL\}\} SUTRA~/ALAM SUTRA/g;
$input =~ s/TOKO ~\{\{KEL\}\} \{\{KEC\}\} BINTANG~/TOKO BINTANG/g;
$input =~ s/ALAM ~\{\{KEC\}\} SUTERA~/ALAM SUTERA/g;
$input =~ s/TOKO ~\{\{KEL\}\} BUDI LESTARI~/TOKO BUDI LESTARI/g;
}
if ($input =~ /DEPAN ~\{\{KEL\}\} NUSANTARA~ || BIRO ~\{\{KEL\}\} JASA~ || TK ~\{\{KEL\}\} LUBIS~ || RM PADANG ~\{\{KEL\}\} SINAR BARU~ || \{\{JL\}\} WARU ~\{\{KEL\}\} DOYONG~ || TK ~\{\{KEL\}\} \{\{KEC\}\} MUTIARA~ || SAMPING ~\{\{KEL\}\} MAKMUR JAYA~ || TOKO ~\{\{KEL\}\} INDAH SARI~ || GG ~\{\{KEL\}\} LANGGAR~ || DEPAN ~\{\{KEL\}\} SUKA DANA~ || TOKO ~\{\{KEL\}\} MARIA~ || \{\{POI\}\} ~\{\{KEL\}\} \{\{KEC\}\} PASAR KEMIS~ || TOKO \{\{KEC\}\} ABUN~ || \{\{JL\}\} SIMPANG 3 ~\{\{KEL\}\} \{\{KEC\}\} \{\{KAB\}\} KETAPANG~ || \{\{JL\}\} RAYA MAUK ~\{\{KEL\}\} SASAK~ || \{\{JL\}\} PONDOK JAGUNG~ || \{\{POI\}\} PERUMAHAN TAMAN ~\{\{KEL\}\} WALET~ || \{\{JL\}\} \{\{POI\}\} || ~\{\{KEL\}\} KEBUN~ BESAR || PANTI ~\{\{KEL\}\} ASUHAN~ || MAN ~\{\{KEL\}\} \{\{KEC\}\} TAMBAK~ || NUSA ~\{\{KEL\}\} KAMBANGAN~ || GN ~\{\{KEL\}\} MERAPI~ || PULAU ~\{\{KEL\}\} \{\{KEC\}\} GALANG~ || TK ~\{\{KEL\}\} \{\{KEC\}\} \{\{KAB\}\} BATANG HARI~ || SERMA ~\{\{KEL\}\} MADE~ || TK ~\{\{KEL\}\} \{\{KEC\}\} MUSI~ || DN ~\{\{KAB\}\} POSO~ || P ~\{\{KEL\}\} KAWE~ || TK ~\{\{KEL\}\} \{\{KEC\}\} BANYUSARI~ || P ~\{\{KEL\}\} SELAYAR~ || BATAS ~\{\{KEL\}\} DUKUH SARI~ || PULAU ~\{\{KEL\}\} MOYO~ || GN ~\{\{KEL\}\} LEMPUYANG~ || KUBU ~\{\{KEL\}\} \{\{KEC\}\} ANYAR~/) {
$input =~ s/DEPAN ~\{\{KEL\}\} NUSANTARA~/DEPAN NUSANTARA/g;
$input =~ s/BIRO ~\{\{KEL\}\} JASA~/BIRO JASA/g;
$input =~ s/TK ~\{\{KEL\}\} LUBIS~/TK LUBIS/g;
$input =~ s/RM PADANG ~\{\{KEL\}\} SINAR BARU~/RM PADANG SINAR BARU/g;
$input =~ s/\{\{JL\}\} WARU ~\{\{KEL\}\} DOYONG~/\{\{JL\}\} WARU DOYONG/g;
$input =~ s/TK ~\{\{KEL\}\} \{\{KEC\}\} MUTIARA~/TK MUTIARA/g;
$input =~ s/SAMPING ~\{\{KEL\}\} MAKMUR JAYA~/SAMPING MAKMUR JAYA/g;
$input =~ s/TOKO ~\{\{KEL\}\} INDAH SARI~/TOKO INDAH SARI/g;
$input =~ s/GG ~\{\{KEL\}\} LANGGAR~/GG LANGGAR/g;
$input =~ s/DEPAN ~\{\{KEL\}\} SUKA DANA~/DEPAN SUKA DANA/g;
$input =~ s/TOKO ~\{\{KEL\}\} MARIA~/TOKO MARIA/g;
$input =~ s/\{\{POI\}\} ~\{\{KEL\}\} \{\{KEC\}\} PASAR KEMIS~/~\{\{KEL\}\} \{\{KEC\}\} PASAR KEMIS~/g;
$input =~ s/TOKO ~\{\{KEC\}\} ABUN~/TOKO ABUN/g;
$input =~ s/\{\{JL\}\} SIMPANG 3 ~\{\{KEL\}\} \{\{KEC\}\} \{\{KAB\}\} KETAPANG~/\{\{JL\}\} SIMPANG 3 KETAPANG/g;
$input =~ s/\{\{JL\}\} RAYA MAUK ~\{\{KEL\}\} SASAK~/\{\{JL\}\} RAYA MAUK SASAK/g;
$input =~ s/\{\{JL\}\} PONDOK JAGUNG~/\{\{JL\}\} PONDOK JAGUNG/g;
$input =~ s/\{\{POI\}\} PERUMAHAN TAMAN ~\{\{KEL\}\} WALET~/\{\{POI\}\} PERUMAHAN TAMAN WALET/g;
$input =~ s/\{\{JL\}\} \{\{POI\}\}/\{\{JL\}\}/g;
$input =~ s/~\{\{KEL\}\} KEBUN~ BESAR/KEBUN BESAR/g;
$input =~ s/PANTI ~\{\{KEL\}\} ASUHAN~/PANTI ASUHAN/g;
$input =~ s/MAN ~\{\{KEL\}\} \{\{KEC\}\} TAMBAK~/MAN TAMBAK/g;
$input =~ s/NUSA ~\{\{KEL\}\} KAMBANGAN~/NUSA KAMBANGAN/g;
$input =~ s/GN ~\{\{KEL\}\} MERAPI~/GN MERAPI/g;
$input =~ s/PULAU ~\{\{KEL\}\} \{\{KEC\}\} GALANG~/PULAU GALANG/g;
$input =~ s/TK ~\{\{KEL\}\} \{\{KEC\}\} \{\{KAB\}\} BATANG HARI~/TK BATANG HARI/g;
$input =~ s/SERMA ~\{\{KEL\}\} MADE~/SERMA MADE/g;
$input =~ s/TK ~\{\{KEL\}\} \{\{KEC\}\} MUSI~/TK MUSI/g;
$input =~ s/DN ~\{\{KAB\}\} POSO~/DN POSO/g;
$input =~ s/P ~\{\{KEL\}\} KAWE~/P KAWE/g;
$input =~ s/TK ~\{\{KEL\}\} \{\{KEC\}\} BANYUSARI~/TK BANYUSARI/g;
$input =~ s/P ~\{\{KEL\}\} SELAYAR~/P SELAYAR/g;
$input =~ s/BATAS ~\{\{KEL\}\} DUKUH SARI~/BATAS DUKUH SARI/g;
$input =~ s/PULAU ~\{\{KEL\}\} MOYO~/PULAU MOYO/g;
$input =~ s/GN ~\{\{KEL\}\} LEMPUYANG~/GN LEMPUYANG/g;
$input =~ s/KUBU ~\{\{KEL\}\} \{\{KEC\}\} ANYAR~/KUBU ANYAR/g;
}
if ($input =~ /PERUMAHAN LUMBUNG ~\{\{KEL\}\} LESTARI~ || PADANG ~\{\{KEL\}\} BAI~ || TAMAN ~\{\{KEL\}\} \{\{KEC\}\} MUTIARA~ || TUGU ~\{\{KEL\}\} PAHLAWAN~ || DEPAN WISMA ~\{\{KEL\}\} PANGERAN~ || SAMPING ~\{\{KEL\}\} KEDAI~ || KH ~\{\{KEC\}\} DEWANTARA~ || H ~\{\{KEL\}\} PERDANA~ KUSUMA || DR ~\{\{KEL\}\} \{\{KEC\}\} SETIA BUDI~ || RASA ~\{\{KEL\}\} SAYANG~ || ORANG ~\{\{KEL\}\} \{\{KEC\}\} KAYO~ || MAULANA ~\{\{KEL\}\} MALIK~ IBRAHIM || MPU ~\{\{KEL\}\} GANDRING~ || BASUKI ~\{\{KEL\}\} RAHMAT~ || LINTAS ~\{\{PROV\}\} JAMBI~ || TENGKU ~\{\{KEL\}\} UMAR~ || TPA ~\{\{KEL\}\} \{\{KEC\}\} TALANG~ || DEPATI ~\{\{KEC\}\} PURBA~ || KELAPA ~\{\{KEL\}\} \{\{KEC\}\} SAWIT~ || TP ~\{\{KEL\}\} SRIWIJAYA~ || PADAT ~\{\{KEL\}\} KARYA~ || TRI ~\{\{KEL\}\} \{\{KEC\}\} SAKTI~ || SEI ~\{\{KEL\}\} SIPAI~ || SEI ~\{\{KEL\}\} \{\{KEC\}\} SALAK~ || T ~\{\{KEL\}\} TILUNG~ || P ~\{\{KEL\}\} ANTASARI~ || PADAT ~\{\{KEL\}\} KARYA~ || KI H ~\{\{KEL\}\} UMAR~ || ADAM ~\{\{KEL\}\} MALIK~ || KALI ~\{\{KEL\}\} \{\{KEC\}\} PORONG~ || KEDUNG ~\{\{KEL\}\} \{\{KEC\}\} SUMBER~ || NURUL ~\{\{KEL\}\} \{\{KEC\}\} SALAM~ || KAMPUNG ~\{\{KEL\}\} \{\{KEC\}\} RAMBUTAN~ || RA ~\{\{KEL\}\} KARTINI~ || NU\{\{POI\}\} GRAHA/) {
$input =~ s/PERUMAHAN LUMBUNG ~\{\{KEL\}\} LESTARI~/PERUMAHAN LUMBUNG LESTARI/g;
$input =~ s/PADANG ~\{\{KEL\}\} BAI~/PADANG BAI/g;
$input =~ s/TAMAN ~\{\{KEL\}\} \{\{KEC\}\} MUTIARA~/TAMAN MUTIARA/g;
$input =~ s/TUGU ~\{\{KEL\}\} PAHLAWAN~/TUGU PAHLAWAN/g;
$input =~ s/DEPAN WISMA ~\{\{KEL\}\} PANGERAN~/DEPAN WISMA PANGERAN/g;
$input =~ s/SAMPING ~\{\{KEL\}\} KEDAI~/SAMPING KEDAI/g;
$input =~ s/KH ~\{\{KEC\}\} DEWANTARA~/KH DEWANTARA/g;
$input =~ s/H ~\{\{KEL\}\} PERDANA~ KUSUMA/H PERDANA KUSUMA/g;
$input =~ s/DR ~\{\{KEL\}\} \{\{KEC\}\} SETIA BUDI~/DR SETIA BUDI/g;
$input =~ s/RASA ~\{\{KEL\}\} SAYANG~/RASA SAYANG/g;
$input =~ s/ORANG ~\{\{KEL\}\} \{\{KEC\}\} KAYO~/ORANG KAYO/g;
$input =~ s/MAULANA ~\{\{KEL\}\} MALIK~ IBRAHIM/MAULANA MALIK IBRAHIM/g;
$input =~ s/MPU ~\{\{KEL\}\} GANDRING~/MPU GANDRING/g;
$input =~ s/BASUKI ~\{\{KEL\}\} RAHMAT~/BASUKI RAHMAT/g;
$input =~ s/LINTAS ~\{\{PROV\}\} JAMBI~/LINTAS JAMBI/g;
$input =~ s/TENGKU ~\{\{KEL\}\} UMAR~/TENGKU UMAR/g;
$input =~ s/TPA ~\{\{KEL\}\} \{\{KEC\}\} TALANG~/TPA TALANG/g;
$input =~ s/DEPATI ~\{\{KEC\}\} PURBA~/DEPATI PURBA/g;
$input =~ s/KELAPA ~\{\{KEL\}\} \{\{KEC\}\} SAWIT~/KELAPA SAWIT/g;
$input =~ s/TP ~\{\{KEL\}\} SRIWIJAYA~/TP SRIWIJAYA/g;
$input =~ s/PADAT ~\{\{KEL\}\} KARYA~/PADAT KARYA/g;
$input =~ s/TRI ~\{\{KEL\}\} \{\{KEC\}\} SAKTI~/TRI SAKTI/g;
$input =~ s/SEI ~\{\{KEL\}\} SIPAI~/SEI SIPAI/g;
$input =~ s/SEI ~\{\{KEL\}\} \{\{KEC\}\} SALAK~/SEI SALAK/g;
$input =~ s/T ~\{\{KEL\}\} TILUNG~/T TILUNG/g;
$input =~ s/P ~\{\{KEL\}\} ANTASARI~/P ANTASARI/g;
$input =~ s/KI H ~\{\{KEL\}\} UMAR~/KI H UMAR/g;
$input =~ s/ADAM ~\{\{KEL\}\} MALIK~/ADAM MALIK/g;
$input =~ s/KALI ~\{\{KEL\}\} \{\{KEC\}\} PORONG~/KALI PORONG/g;
$input =~ s/KEDUNG ~\{\{KEL\}\} \{\{KEC\}\} SUMBER~/KEDUNG SUMBER/g;
$input =~ s/NURUL ~\{\{KEL\}\} \{\{KEC\}\} SALAM~/NURUL SALAM/g;
$input =~ s/KAMPUNG ~\{\{KEL\}\} \{\{KEC\}\} RAMBUTAN~/KAMPUNG RAMBUTAN/g;
$input =~ s/RA ~\{\{KEL\}\} KARTINI~/RA KARTINI/g;
$input =~ s/NU\{\{POI\}\} GRAHA/NUGRAHA/g;
}
#GG/GANG/LOS/TOKO/TK/SIMP
if ($input =~ /\{\{JL\}\} ([A-Z]*)~ RAYA/) {
$input =~ s/~ RAYA/ RAYA/g;
}
print OUT9 $input;
close (OUT8);
close (OUT9);

#---- 3
#UNTUK MERAPIKAN HASIL OUTPUT DARI 'StringHasilAkhirBanget.txt'
#!C:/Perl64/bin/perl.exe -w
open (A1, "matching/StringHasil4.txt") or die "can't open";
open (A2, ">matching/StringHasil5.txt") or die "can't open";
@lines = <A1>;
$input = "@lines";
if ($input =~ /\s\s\s\s\s\*\s/) {
$input =~ s/\s\s\s\s\s\*\s//g;
}
if ($input =~ /\*\s/) {
$input =~ s/\*\s//g;
}
if ($input =~ /\s\s\s\s\s\n/) {
$input =~ s/\s\s\s\s\s\n//g;
}
if ($input =~ /\n\s\s\s\s\n/) {
$input =~ s/\n\s\s\s\s\n//g;
}
print A2 $input;
close (A1);
close (A2);

#---- 4
#UNTUK IMPORT HASIL PARSING KE DATABASE YANG ADA
#!/usr/bin/perl -w
use DBI;
open (OUT, 'matching/StringHasil5.txt') or die "can't open";
open (OUT2, 'matching/DokumenParsing.txt') or die "can't open";
@q = <OUT2>;
$qq = "@q";
foreach $aaa(<OUT>) {
@lines6 = split(/\|/, $aaa);
$a6 = $lines6[0];
$b6 = $lines6[1];
$user = "gis";
$pw = "Gis123.>";
$dsn = 'dbi:Pg:dbname=db_engine_geocode;host=192.168.5.11;port=5432';
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "insert into $qq values (?,?)";
$sth = $dbh->prepare($sql);
$sth->execute( $a6, $aaa ) or die "SQL Error: $DBI::errstr\n";
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
close (OUT);
close (OUT2);

#---- 5
#JOIN TABLE database_geocode DENGAN TABLE parsing UNTUK NGAMBIL NILAI PARSING
#!/usr/bin/perl -w
use DBI;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
open (OUT2, 'matching/DokumenParsing.txt') or die "can't open";
@q = <OUT2>;
$qq = "@q";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "update $tb set parsing = ? where id = ?";
$sth = $dbh->prepare($sql);
$sql2 = "select a.id, a.parsing from $qq as a left join $tb as b on a.id = b.id order by a.id";
$sth2 = $dbh->prepare($sql2);
$sth2->execute;
while (@data = $sth2->fetchrow_array()) {
    my $id = $data[0];
    my $parsing = $data[1];
    $sth->execute($parsing, $id);
    $sth->finish;
}
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
$sth2->finish;
close (OUT);
close (OUT2);

#---- 6
#PRINT KE LAYAR PERNYATAAN SELESAI
#!/usr/bin/perl -w
print "PROSES PARSING SELESAI DILAKUKAN :)";
print "\n";

#------------------------------------------------------------------------------------------------------------#

#CODE 2 (MENYELESAIKAN MASALAH MATCHING JALAN)
#---- 0
#SET KOLOM DI DALAM TB JADI NULL
#!/usr/bin/perl -w
use DBI;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "update $tb set match_jln = null, match_vi = null, match_su = null, match_di = null, match_pr = null, summary = null, summary_detail = null";
$sth = $dbh->prepare($sql);
$sth->execute;
$sth->finish;
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
close (OUT);

#---- 1
#UNTUK MENARIK DATA YANG DIBUTUHKAN DARI DATABASE
#SETELAH MENARIK DATA, MAKA DATA YANG ADA AKAN DIUBAH FORMATNYA SESUAI DENGAN YANG DIGUNAKAN PADA PROSES MATCHING DI TAHAP 2
#!C:/Perl/bin/perl.exe -w
use DBI;
use DBD::mysql;
open (OUT1, '>matching/StringMatchingConcat.txt') or die "can't open";
open (OUT2, '>matching/StringMatchingAwal.txt') or die "can't open";
open (OUT3, '>matching/StringMatchingReverse.txt') or die "can't open";
open (OUT, 'matching/Dokumen.txt') or die "can't open";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
$sql1 = "SELECT upper(concat('| 12345 ',ori_name,' ',ori_address,' ',ori_vi,' ',ori_su,' ',ori_di,' ',ori_pr,' ',' ^| 12345 ',google_address,' ')) FROM $tb where flag_geocode != 'Q' order by id";
$sql2 = "SELECT upper(concat('| 12345 ',ori_name,' ',ori_address,' ',ori_vi,' ',ori_su,' ',ori_di,' ',ori_pr,' ')) FROM $tb where flag_geocode != 'Q' order by id";
$sql3 = "SELECT upper(concat('| 12345 ',google_address,' ')) FROM $tb where flag_geocode != 'Q' order by id";
$sth1 = $dbh->prepare($sql1);
$sth2 = $dbh->prepare($sql2);
$sth3 = $dbh->prepare($sql3);
$sth1->execute or die "SQL Error: $DBI::errstr\n";
$sth2->execute or die "SQL Error: $DBI::errstr\n";
$sth3->execute or die "SQL Error: $DBI::errstr\n";
while (@row1 = $sth1->fetchrow_array) {
print OUT1 "@row1\n";
}
while (@row2 = $sth2->fetchrow_array) {
print OUT2 "@row2\n";
}
while (@row3 = $sth3->fetchrow_array) {
print OUT3 "@row3\n";
}
}
close (OUT1);
close (OUT2);
close (OUT3);
close (OUT);
open(FILE2, ">>matching/StringMatchingConcat.txt") or die "can't open";
open(FILE3, ">>matching/StringMatchingAwal.txt") or die "can't open";
open(FILE4, ">>matching/StringMatchingReverse.txt") or die "can't open";
print FILE2 "~ ";
print FILE3 "~ ";
print FILE4 "~ ";
close (FILE2);
close (FILE3);
close (FILE4);

#---- 2
#UNTUK MELAKUKAN PROSES MATCHING
#CODINGAN PART 1
#!C:/Perl/bin/perl.exe -w
open(FILE, "matching/DB_Singkatan.txt") or die "can't open";
open(FILE2, "matching/StringMatchingConcat.txt") or die "can't open";
open (OUT, '>matching/StringMatchingConcat1.txt') or die "can't open";
@aa = <FILE2>;
$aaa = "@aa";
foreach ($aaa =~ /\~ /) {
@listdata = split(/\~ /, $aaa);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
$listdata[$i] =~ tr/a-z/A-Z/;
$listdata[$i] =~ s/[.-]/ /g;
$listdata[$i] =~ s/[()]/ /g;
$listdata[$i] =~ s/["]/ /g;
$listdata[$i] =~ s/\/|\\|\:|\*|\+|\[|\]/ /g;
if ($listdata[$i] =~ /\,/) {
$listdata[$i] =~ s/\,/\, /g;
}
$listdata[$i] =~ s/   / /g;
$listdata[$i] =~ s/  / /g;
foreach $entitas(<FILE>) {
@lines = split(/,/, $entitas);
chomp @lines;
$a = $lines[0];
$b = $lines[1];
if ($listdata[$i] =~ /$a/) {
$listdata[$i] =~ s/$a/ $b /g;
}
}
if ($listdata[$i] =~ /;\n\s/) {
$listdata[$i] =~ s/;\n\s/\n/g;
}
$listdata[$i] =~ s/   / /g;
$listdata[$i] =~ s/  / /g;
print OUT $listdata[$i]."\n";
}
}
close (FILE);
close (FILE2);
close (OUT);

#CODINGAN PART 2
#!C:/Perl64/bin/perl.exe -w
open(FILE, "matching/DB_Singkatan.txt") or die "can't open";
open(FILE2, "matching/StringMatchingAwal.txt") or die "can't open";
open (OUT, '>matching/StringMatchingAwal1.txt') or die "can't open";
@aa = <FILE2>;
$aaa = "@aa";
foreach ($aaa =~ /\~ /) {
@listdata = split(/\~ /, $aaa);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
$listdata[$i] =~ tr/a-z/A-Z/;
$listdata[$i] =~ s/[.-]/ /g;
$listdata[$i] =~ s/[()]/ /g;
if ($listdata[$i] =~ /\,/) {
$listdata[$i] =~ s/\,/\, /g;
}
$listdata[$i] =~ s/   / /g;
$listdata[$i] =~ s/  / /g;
foreach $entitas(<FILE>) {
@lines = split(/,/, $entitas);
chomp @lines;
$a = $lines[0];
$b = $lines[1];
if ($listdata[$i] =~ /$a/) {
$listdata[$i] =~ s/$a/$b/g;
}
}
if ($listdata[$i] =~ /;\n\s/) {
$listdata[$i] =~ s/;\n\s/\n/g;
}
$listdata[$i] =~ s/   / /g;
$listdata[$i] =~ s/  / /g;
print OUT $listdata[$i]."\n";
}
}
close (FILE);
close (FILE2);
close (OUT);

#CODINGAN PART 3
#!C:/Perl64/bin/perl.exe -w
open(FILE, "matching/DB_Singkatan.txt") or die "can't open";
open(FILE2, "matching/StringMatchingReverse.txt") or die "can't open";
open (OUT, '>matching/StringMatchingReverse1.txt') or die "can't open";
@aa = <FILE2>;
$aaa = "@aa";
foreach ($aaa =~ /\~ /) {
@listdata = split(/\~ /, $aaa);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
$listdata[$i] =~ tr/a-z/A-Z/;
$listdata[$i] =~ s/[.-]/ /g;
$listdata[$i] =~ s/[()]/ /g;
if ($listdata[$i] =~ /\,/) {
$listdata[$i] =~ s/\,/\, /g;
}
$listdata[$i] =~ s/   / /g;
$listdata[$i] =~ s/  / /g;
foreach $entitas(<FILE>) {
@lines = split(/,/, $entitas);
chomp @lines;
$a = $lines[0];
$b = $lines[1];
if ($listdata[$i] =~ /$a/) {
$listdata[$i] =~ s/$a/$b/g;
}
}
if ($listdata[$i] =~ /;\n\s/) {
$listdata[$i] =~ s/;\n\s/\n/g;
}
$listdata[$i] =~ s/   / /g;
$listdata[$i] =~ s/  / /g;
print OUT $listdata[$i]."\n";
}
}
close (FILE);
close (FILE2);
close (OUT);

#CODINGAN PART 4
#!C:/Perl64/bin/perl.exe -w
open(FILE, "matching/StringMatchingConcat1.txt") or die "can't open";
open(OUT, ">matching/HasilStringMatching1.txt") or die "can't open";
foreach $entitas(<FILE>) {
@lines = split(/\^/, $entitas);
chomp @lines;
$a = $lines[0];
$b = $lines[1];
$a =~ tr/a-z/A-Z/;
$b =~ tr/a-z/A-Z/;
$a =~ s/[.-]/ /g;
$a =~ s/\,/ /g;
$b =~ s/[.-]/ /g;
$a =~ s/   / /g;
$b =~ s/   / /g;
$a =~ s/  / /g;
$b =~ s/  / /g;
foreach ($a =~ /\s/) {
@listdata = split(/\s/, $a);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
#print $listdata[$i]."\n";
#print "---------\n";
foreach $entitas2($b) {
@lines2 = split(/\,/, $entitas2);
if ($lines2[0] =~ / PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[1] =~ / JL / and $lines2[0] =~ /$listdata[$i]/ and $lines2[1] =~ /$listdata[$i]/) {
print OUT $listdata[$i]." ";
}
elsif ($lines2[0] =~ / PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[1] =~ / JL / and $lines2[1] =~ /$listdata[$i]/) {
print OUT $listdata[$i]." ";
}
elsif ($lines2[0] =~ / PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[2] =~ / JL / and $lines2[2] =~ /$listdata[$i]/) {
print OUT $listdata[$i]." ";
}
elsif ($lines2[2] =~ / PLAZA / and $lines2[4] =~ / JL / and $lines2[4] =~ /$listdata[$i]/) {
print OUT $listdata[$i]." ";
}
elsif ($lines2[2] =~ / RUKO / and $lines2[3] =~ / JL / and $lines2[3] =~ /$listdata[$i]/) {
print OUT $listdata[$i]." ";
}
elsif ($lines2[1] =~ / KOMPLEK | PASAR / and $lines2[2] =~ / JL / and $lines2[2] =~ /$listdata[$i]/) {
print OUT $listdata[$i]." ";
}
elsif ($lines2[1] =~ / PASAR / and $lines2[3] =~ / JL / and $lines2[3] =~ /$listdata[$i]/) {
print OUT $listdata[$i]." ";
}
elsif ($lines2[0] =~ / PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[0] =~ /$listdata[$i]/) {
print OUT $listdata[$i]." ";
}
elsif ($lines2[0] =~ / JL | UNNAMED / and $lines2[0] =~ /$listdata[$i]/) {
print OUT $listdata[$i]." ";
}
elsif ($lines2[0] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[1] =~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[1] =~ /$listdata[$i]/) {
print OUT $listdata[$i]." ";
}
elsif ($lines2[0] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[1] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[2] =~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[2] =~ /$listdata[$i]/) {
print OUT $listdata[$i]." ";
}
elsif ($lines2[0] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[1] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[2] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[3] =~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[3] =~ /$listdata[$i]/) {
print OUT $listdata[$i]." ";
}
elsif ($lines2[0] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[1] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[2] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[3] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[4] =~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[4] =~ /$listdata[$i]/) {
print OUT $listdata[$i]." ";
}
elsif ($lines2[0] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[1] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[2] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[3] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[4] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[5] =~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[5] =~ /$listdata[$i]/) {
print OUT $listdata[$i]." ";
}
elsif ($lines2[0] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[1] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[2] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[3] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[4] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[5] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[6] =~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[6] =~ /$listdata[$i]/) {
print OUT $listdata[$i]." ";
}
elsif ($lines2[0] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[1] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[2] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[3] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[4] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[5] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[6] !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN / and $lines2[0] =~ /$listdata[$i]/) {
print OUT $listdata[$i]." ";
}
else {
print OUT " ";
}
}
}
}
}
close (FILE);
close (OUT);

#CODINGAN PART 5
#!C:/Perl64/bin/perl.exe -w
open(FILE, "matching/HasilStringMatching1.txt") or die "can't open";
open(OUT, ">matching/HasilStringMatching2.txt") or die "can't open";
foreach $entitas(<FILE>) {
@listdata = split(/\| /, $entitas);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
$listdata[$i] =~ s/ JL JL / JL /g;
if ($listdata[$i] =~ / BLOK /) {
$listdata[$i] =~ s/ BLOK / /g;
}
if ($listdata[$i] =~ / [A-Z] /) {
$listdata[$i] =~ s/ [A-Z] / /g;
}
$listdata[$i] =~ s/ NO | BLK | RT | RW / /g;
$listdata[$i] =~ s/ [0-9] / /g;
$listdata[$i] =~ s/ [0-9]+ / /g;
$listdata[$i] =~ s/ [0-9][A-Z] / /g;
$listdata[$i] =~ s/ [A-Z][0-9] / /g;
$listdata[$i] =~ s/ [A-Z] [A-Z] / /g;
$listdata[$i] =~ s/   / /g;
$listdata[$i] =~ s/  / /g;
if ($listdata[$i] =~ /JL ([A-Z]+) ([A-Z]+) ([A-Z]+) ([A-Z]+)/) {
if ($1 eq $3 and $2 eq $4) {
$listdata[$i] =~ s/JL ([A-Z]+) ([A-Z]+) ([A-Z]+) ([A-Z]+)/JL $1 $2/g;
}
}
if ($listdata[$i] =~ /JL ([A-Z]+) ([A-Z]+)/) {
if ($1 eq $2) {
$listdata[$i] =~ s/JL ([A-Z]+) ([A-Z]+)/JL $1/g;
}
}
foreach ($listdata[$i] =~ /\s/) {
@listdata2 = split(/\s/, $listdata[$i]);
$totalaray2 = scalar(@listdata2);
if ($totalaray2 > 2 and $listdata[$i] !~ /JL JL/ and $listdata[$i] !~ /JL [0-9][0-9] /) {
print OUT $listdata[$i]."^ ADA_KEMUNGKINAN_SAMA ;\n";
}
elsif ($totalaray2 <= 2 and $listdata[$i] =~ /JL ([A-Z])/) {
print OUT $listdata[$i]."^ ADA_KEMUNGKINAN_SAMA ;\n";
}
else {
print OUT $listdata[$i]."^ TIDAK_ADA_KEMUNGKINAN_SAMA ;\n";
}
}
}
}
close (FILE);
close (OUT);

#CODINGAN PART 6
#!C:/Perl64/bin/perl.exe -w
open(FILE, "matching/StringMatchingAwal1.txt") or die "can't open";
open(FILE2, "matching/StringMatchingReverse1.txt") or die "can't open";
open(FILE3, "matching/HasilStringMatching2.txt") or die "can't open";
open(OUT, ">matching/HasilStringMatching3.txt") or die "can't open";
while ($line1 = <FILE> and $line2 = <FILE2> and $line3 = <FILE3>) {
chomp $line1;
chomp $line2;
chomp $line2;
$line1 =~ s/  / /g;
$line2 =~ s/  / /g;
if ($line3 =~ /  /) {
$line3 =~ s/  / /g;
}
@lines1 = split("\;", $line1);
@lines2 = split("\;", $line2);
@lines3 = split("\;", $line3);
$liness1 = "@lines1";
$liness2 = "@lines2";
$liness3 = "@lines3";
print OUT $liness1,"^ ".$liness2."^ ".$liness3;
}
close (FILE);
close (FILE2);
close (OUT);

#CODINGAN PART 7
#!C:/Perl64/bin/perl.exe -w
open(FILE, "matching/HasilStringMatching3.txt") or die "can't open";
open(OUT, ">matching/HasilStringMatching4.txt") or die "can't open";
foreach $entitas(<FILE>) {
@lines = split(/\^ /, $entitas);
chomp @lines;
$a = $lines[0];
$b = $lines[1];
$c = $lines[2];
$d = $lines[3];
$a =~ tr/a-z/A-Z/;
$b =~ tr/a-z/A-Z/;
$a =~ s/[.,-:]/ /g;
$b =~ s/[.-:]/ /g;
$a =~ s/\*/ /g;
$b =~ s/\*/ /g;
$a =~ s/  / /g;
$b =~ s/  / /g;
$c =~ s/\"/ /g;
if ($a =~ / [0-9] | [0-9]+ / or $a =~ / [0-9][A-Z] / or $a =~ / [A-Z][0-9] /) {
$a =~ s/ [0-9] / /g;
$a =~ s/ [0-9]+ / /g;
$a =~ s/ [0-9][A-Z] / /g;
$a =~ s/ [A-Z][0-9] / /g;
}
if ($c =~ / [0-9] | [0-9]+ / or $c =~ / [0-9][A-Z] / or $c =~ / [A-Z][0-9] /) {
$c =~ s/ [0-9] / /g;
$c =~ s/ [0-9]+ / /g;
$c =~ s/ [0-9][A-Z] / /g;
$c =~ s/ [A-Z][0-9] / /g;
}
if ($a =~ / NO / or $c =~ / NO /) {
$a =~ s/ NO / /g;
$c =~ s/ NO / /g;
}
if ($a =~ / KKO | PERSIL | KEC / or $c =~ /PASAR PULO GADUNG PULO GA/ or $c =~ /JL PRAMBANAN PIYUNGAN PRAMBANAN/ or $c =~ /JL IMOGIRI TIMUR KM TIMUR IMOGIRI/ or $c =~ /PASAR WALIKUKUN WALIKUKUN/ or $c =~ /JL LINTAS SUMATERA TIMUR/ or $c =~ /PASAR MINGGU PASAR MINGGU/ or $c =~ /PASAR WANGKAL WANGKAL/ or $c =~ /JL TANJUNG API API RT16 RW04/ or $c =~ /JL JATINEGARA JATINEGARA/ or $c =~ /JL JATINEGARA JATINE/ or $c =~ /JL PENDIDIKAN JL PENDIDIKAN/ or $c =~ /GADING GADIN GADING/ or $c =~ /JL OTTO ISKANDARDINATA CAWANG/ or $c =~ /JL CITRA CI/ or $c =~ /PULO NANGKA TENGAH PULO/ or $c =~ /JL KEBON KACANG KEBON/ or $c =~ /JL SADING SADING/ or $c =~ /JL MLARAK MLARAK/ or $c =~ /JL SUMOROTO SUMOROTO/ or $c =~ /JL TENTARA PELAJAR PALAGAN/ or $c =~ /JL PAKEM PAKEM/ or $c =~ /PASAR WONOCATUR WONOCATUR/ or $c =~ /JL NANGKA UTARA UTARA/ or $c =~ /JL SINGAPADU SINGAPADU/ or $c =~ /JL KELIKI KELIKI/ or $c =~ /JL BABAHAN BABAHAN/ or $c =~ /JL KAPAL KAPAL/ or $c =~ /JL SANGEH SANGEH/ or $c =~ /JL ANGANTAKA ANGANTAKA/ or $c =~ /JL GADON GADON/ or $c =~ /JL TUKAD BADUNG XVII/ or $c =~ /JL PEMOGAN PEMOGAN/ or $c =~ /JL GEL GEL GEL GEL/ or $c =~ /JL BURUAN BURUAN/ or $c =~ /JL PANTAI SABA SABA/ or $c =~ /JL MAUK MAUK/ or $c =~ /JL SERANG SERANG/ or $c =~ /JL CILEGON CILEGON/ or $c =~ /JL PONDOK KACANG PONDOK/ or $c =~ /JL CURUG CURUG/ or $c =~ /JL KRONJO KRONJO/ or $c =~ /JL CISOKA CISOKA CISOKA/) {
$a =~ s/ KKO | PERSIL | KEC / /g;
$c =~ s/PASAR PULO GADUNG PULO GA/PASAR PULO GADUNG/g;
$c =~ s/JL PRAMBANAN PIYUNGAN PRAMBANAN/JL PRAMBANAN PIYUNGAN/g;
$c =~ s/JL IMOGIRI TIMUR KM TIMUR IMOGIRI/JL IMOGIRI TIMUR KM/g;
$c =~ s/PASAR WALIKUKUN WALIKUKUN/PASAR WALIKUKUN/g;
$c =~ s/JL LINTAS SUMATERA TIMUR/JL LINTAS SUMATERA/g;
$c =~ s/PASAR MINGGU PASAR MINGGU/PASAR MINGGU/g;
$c =~ s/PASAR WANGKAL WANGKAL/PASAR WANGKAL/g;
$c =~ s/JL TANJUNG API API RT16 RW04/JL TANJUNG API API/g;
$c =~ s/JL JATINEGARA JATINEGARA/JL JATINEGARA/g;
$c =~ s/JL JATINEGARA JATINE/JL JATINEGARA/g;
$c =~ s/JL PENDIDIKAN JL PENDIDIKAN/JL PENDIDIKAN/g;
$c =~ s/GADING GADIN GADING/GADING/g;
$c =~ s/JL OTTO ISKANDARDINATA CAWANG/JL OTTO ISKANDARDINATA/g;
$c =~ s/JL CITRA CI/JL CITRA/g;
$c =~ s/PULO NANGKA TENGAH PULO/PULO NANGKA TENGAH/g;
$c =~ s/JL KEBON KACANG KEBON/JL KEBON KACANG/g;
$c =~ s/JL SADING SADING/JL SADING/g;
$c =~ s/JL MLARAK MLARAK/JL MLARAK/g;
$c =~ s/JL SUMOROTO SUMOROTO/JL SUMOROTO/g;
$c =~ s/JL TENTARA PELAJAR PALAGAN/JL TENTARA PELAJAR/g;
$c =~ s/JL PAKEM PAKEM/JL PAKEM/g;
$c =~ s/PASAR WONOCATUR WONOCATUR/PASAR WONOCATUR/g;
$c =~ s/JL NANGKA UTARA UTARA/JL NANGKA UTARA/g;
$c =~ s/JL SINGAPADU SINGAPADU/JL SINGAPADU/g;
$c =~ s/JL KELIKI KELIKI/JL KELIKI/g;
$c =~ s/JL BABAHAN BABAHAN/JL BABAHAN/g;
$c =~ s/JL KAPAL KAPAL/JL KAPAL/g;
$c =~ s/JL SANGEH SANGEH/JL SANGEH/g;
$c =~ s/JL ANGANTAKA ANGANTAKA/JL ANGANTAKA/g;
$c =~ s/JL GADON GADON/JL GADON/g;
$c =~ s/JL TUKAD BADUNG XVII/JL TUKAD BADUNG/g;
$c =~ s/JL PEMOGAN PEMOGAN/JL PEMOGAN/g;
$c =~ s/JL GEL GEL GEL GEL/JL GEL GEL/g;
$c =~ s/JL BURUAN BURUAN/JL BURUAN/g;
$c =~ s/JL PANTAI SABA SABA/JL PANTAI SABA/g;
$c =~ s/JL MAUK MAUK/JL MAUK/g;
$c =~ s/JL SERANG SERANG/JL SERANG/g;
$c =~ s/JL CILEGON CILEGON/JL CILEGON/g;
$c =~ s/JL PONDOK KACANG PONDOK/JL PONDOK KACANG/g;
$c =~ s/JL CURUG CURUG/JL CURUG/g;
$c =~ s/JL KRONJO KRONJO/JL KRONJO/g;
$c =~ s/JL CISOKA CISOKA CISOKA/JL CISOKA/g;
}
if ($c =~ /JL CISOKA CISOKA/ or $c =~ /PASAR MIJENEN/ or $c =~ /JL BAPING PULE/ or $c =~ /PASAR BESAR MADIUN MADIUN/ or $c =~ /JL DR SUTOMO TOKO/ or $c =~ /PASAR GEBANG SA GEBANG/ or $c =~ /PASAR DINOYO MOJOKERTO/ or $c =~ /JL BY PASS MANTRA KETEWEL SUKAWATI/ or $c =~ /JL PAYANGAN PA/ or $c =~ /JL NGABLAK NGABLAK/ or $c =~ /PASAR GUBUG BU GUBUG/ or $c =~ /PASAR MIJEN MIJEN MIJ/ or $c =~ /PASAR MIJEN MIJEN MIJEN SEMA/ or $c =~ /JL TUNTANG BERINGIN TUNTANG/ or $c =~ /PEDURUNGAN PASAR PEDURUNGAN/ or $c =~ /PASAR MIJEN SEMA/ or $c =~ /PERUMAHAN AHAN TAMAN ASRI/ or $c =~ /PASAR MIJEN MIJEN/ or $c =~ /JL PURWO SURADADI SURADADI/ or $c =~ /PASAR METESEH METESEH TEMBALANG/ or $c =~ /PASAR BABADAN UNGARAN/ or $c =~ /PASAR MERAKURAK TUBAN/ or $c =~ /PASAR BATANG PASAR/ or $c =~ /JL KEBON SIRIH WISMA MANDIRI/ or $c =~ /JL BY PASS MANTRA/ or $c =~ /JL AWIPARI AWIPARI/ or $c =~ /JL DATUK KABU PASAR AS/ or $c =~ /JL LINTAS TEBO BUNGO KM TEBO TEBO/ or $c =~ /JL BY PASS KEDIRI/ or $a =~ /FREFS MARKET/ or $a =~ /PASAR FRESH MARKET CIKUNIR/ or $a =~ /PERUMAHAN VILA NUSA INDAH BEKASI TLP/ or $c =~ /JL PONDOK TIMUR TIMUR/ or $c =~ /JL POROS GALESONG/ or $c =~ /PERUMAHAN MUTIARA CIKARANG/ or $c =~ /PASAR GROGOL BKS TOKO/ or $c =~ /JL SATELIT INDAH SATELIT/ or $a =~ /JLKALIERANG/ or $c =~ /JL ANTASARI TO/ or $c =~ /JL PURWOREJO MAGELANG KM TOKO/ or $c =~ /PASAR GODEAN GODEAN GODEAN GODEAN/ or $c =~ /JL BENDUNGAN PLERET BENDUNGAN/ or $c =~ /JL BANTUL KM BANTUL/ or $c =~ /JL KALIURANG KM GENTAN/) {
$c =~ s/JL CISOKA CISOKA/JL CISOKA/g;
$c =~ s/PASAR MIJENEN/PASAR MIJEN/g;
$c =~ s/JL BAPING PULE/JL BAPING/g;
$c =~ s/PASAR BESAR MADIUN MADIUN/PASAR BESAR MADIUN/g;
$c =~ s/JL DR SUTOMO TOKO/JL DR SUTOMO/g;
$c =~ s/PASAR GEBANG SA GEBANG/PASAR GEBANG/g;
$c =~ s/PASAR DINOYO MOJOKERTO/PASAR DINOYO/g;
$c =~ s/JL BY PASS MANTRA KETEWEL SUKAWATI/JL BY PASS/g;
$c =~ s/JL PAYANGAN PA/JL PAYANGAN/g;
$c =~ s/JL NGABLAK NGABLAK/JL NGABLAK/g;
$c =~ s/PASAR GUBUG BU GUBUG/PASAR GUBUG/g;
$c =~ s/PASAR MIJEN MIJEN MIJ/PASAR MIJEN/g;
$c =~ s/PASAR MIJEN MIJEN MIJEN SEMA/PASAR MIJEN/g;
$c =~ s/JL TUNTANG BERINGIN TUNTANG/JL TUNTANG BERINGIN/g;
$c =~ s/PEDURUNGAN PASAR PEDURUNGAN/PASAR PEDURUNGAN/g;
$c =~ s/PASAR MIJEN SEMA/PASAR MIJEN/g;
$c =~ s/PERUMAHAN AHAN TAMAN ASRI/PERUMAHAN TAMAN ASRI/g;
$c =~ s/PASAR MIJEN MIJEN/PASAR MIJEN/g;
$c =~ s/JL PURWO SURADADI SURADADI/JL PURWO SURADADI/g;
$c =~ s/PASAR METESEH METESEH TEMBALANG/PASAR METESEH/g;
$c =~ s/PASAR BABADAN UNGARAN/PASAR BABADAN/g;
$c =~ s/PASAR MERAKURAK TUBAN/PASAR MERAKURAK/g;
$c =~ s/PASAR BATANG PASAR/PASAR BATANG/g;
$c =~ s/JL KEBON SIRIH WISMA MANDIRI/JL KEBON SIRIH/g;
$c =~ s/JL BY PASS MANTRA/JL BY PASS/g;
$c =~ s/JL AWIPARI AWIPARI/JL AWIPARI/g;
$c =~ s/JL DATUK KABU PASAR AS/JL DATUK KABU/g;
$c =~ s/JL LINTAS TEBO BUNGO KM TEBO TEBO/JL LINTAS TEBO BUNGO KM/g;
$c =~ s/JL BY PASS KEDIRI/JL BY PASS/g;
$a =~ s/FREFS MARKET/FRESH MARKET/g;
$a =~ s/PASAR FRESH MARKET CIKUNIR/PASAR MARKET CIKUNIR/g;
$a =~ s/PERUMAHAN VILA NUSA INDAH BEKASI TLP/PERUMAHAN NUSA INDAH BEKASI TLP/g;
$c =~ s/JL PONDOK TIMUR TIMUR/JL PONDOK TIMUR/g;
$c =~ s/JL POROS GALESONG/JL POROS/g;
$c =~ s/PERUMAHAN MUTIARA CIKARANG/PERUMAHAN MUTIARA/g;
$c =~ s/PASAR GROGOL BKS TOKO/PASAR GROGOL BKS/g;
$c =~ s/JL SATELIT INDAH SATELIT/JL SATELIT INDAH/g;
$a =~ s/JLKALIERANG/JL KALIERANG/g;
$c =~ s/JL ANTASARI TO/JL ANTASARI/g;
$c =~ s/JL PURWOREJO MAGELANG KM TOKO/JL PURWOREJO MAGELANG KM/g;
$c =~ s/PASAR GODEAN GODEAN GODEAN GODEAN/PASAR GODEAN/g;
$c =~ s/JL BENDUNGAN PLERET BENDUNGAN/JL BENDUNGAN PLERET/g;
$c =~ s/JL BANTUL KM BANTUL/JL BANTUL KM/g;
$c =~ s/JL KALIURANG KM GENTAN/JL KALIURANG KM/g;
}
if ($c =~ /PASAR MIJENEN/ or $c =~ /JL KARACAK LEUWILIANG/ or $c =~ /JL MEDAN PEMATANG SIANTAR/ or $c =~ /JL RAWE PASAR MARTUBUNG/ or $c =~ /JL JENDERAL JL/ or $c =~ /SUPER MALL KARAWACI KARAWACI/ or $c =~ /PASAR MENTENG PULO PASAR MENTENG/ or $c =~ /JL PERINTIS KEMERDEKAAN JL/ or $c =~ /JL KATAMSO SIMP JL/ or $c =~ /PASAR PADARINCANG MASJID PADARINCANG/ or $c =~ /JL COMAL BODEH BODEH/ or $c =~ /JL POROS DESA/ or $c =~ /JL KATAMSO JL/ or $c =~ /JL MARELAN PASAR/ or $c =~ /JL LODAN SARANG/ or $c =~ /JL SAM RATULANGI RUKO SENTRA MENTENG BINTARO/ or $c =~ /PASAR ARJOSARI ARJOSARI PACITAN/ or $c =~ /JL KEMUNING TOKO/ or $c =~ /JL BOJONG RANCAMANYAR/ or $c =~ /PASAR RAWAKALONG SETIA MEKAR/ or $c =~ /PASAR ARJOSARI PACITAN/ or $c =~ /JL SAO LORONG/ or $c =~ /JL ADINEGORO LUBUK BUAYA/ or $c =~ /PASAR RAWAKALONG SETIA MEKA/ or $c =~ /JL LINGKAR II/ or $c =~ /JL NANGKA UJUNG NANGKA/ or $c =~ /JL BOULEVARD GADING SERPONG/ or $c =~ /JL DADAPAN KABAT/ or $c =~ /PASAR MIJEN SEMA/) {
$c =~ s/PASAR MIJENEN/PASAR MIJEN/g;
$c =~ s/JL KARACAK LEUWILIANG/JL KARACAK/g;
$c =~ s/JL MEDAN PEMATANG SIANTAR/JL MEDAN/g;
$c =~ s/JL RAWE PASAR MARTUBUNG/JL RAWE/g;
$c =~ s/JL JENDERAL JL/JL JENDERAL/g;
$c =~ s/SUPER MALL KARAWACI KARAWACI/SUPER MALL KARAWACI/g;
$c =~ s/PASAR MENTENG PULO PASAR MENTENG/PASAR MENTENG PULO/g;
$c =~ s/JL PERINTIS KEMERDEKAAN JL/JL PERINTIS/g;
$c =~ s/JL KATAMSO SIMP JL/JL KATAMSO/g;
$c =~ s/PASAR PADARINCANG MASJID PADARINCANG/PASAR PADARINCANG/g;
$c =~ s/JL COMAL BODEH BODEH/JL COMAL BODEH/g;
$c =~ s/JL POROS DESA/JL POROS/g;
$c =~ s/JL KATAMSO JL/JL KATAMSO/g;
$c =~ s/JL MARELAN PASAR/JL MARELAN/g;
$c =~ s/JL LODAN SARANG/JL LODAN/g;
$c =~ s/JL SAM RATULANGI RUKO SENTRA MENTENG BINTARO/JL SAM RATULANGI RUKO SENTRA MENTENG/g;
$c =~ s/PASAR ARJOSARI ARJOSARI PACITAN/PASAR ARJOSARI/g;
$c =~ s/JL KEMUNING TOKO/JL KEMUNING/g;
$c =~ s/JL BOJONG RANCAMANYAR/JL BOJONG/g;
$c =~ s/PASAR ARJOSARI PACITAN/PASAR ARJOSARI/g;
$c =~ s/JL SAO LORONG/JL SAO/g;
$c =~ s/JL ADINEGORO LUBUK BUAYA/JL ADINEGORO/g;
$c =~ s/PASAR RAWAKALONG SETIA MEKAR/PASAR RAWAKALONG/g;
$c =~ s/PASAR RAWAKALONG SETIA MEKA/PASAR RAWAKALONG/g;
$c =~ s/JL LINGKAR II/JL LINGKAR/g;
$c =~ s/JL NANGKA UJUNG NANGKA/JL NANGKA UJUNG/g;
$c =~ s/JL BOULEVARD GADING SERPONG/JL BOULEVARD GADING/g;
$c =~ s/JL DADAPAN KABAT/JL DADAPAN/g;
$c =~ s/PASAR MIJEN SEMA/PASAR MIJEN/g;
}
if ($c =~ /JL ([A-Z]+) ([A-Z]+) ([A-Z]+) ([A-Z]+)/) {
if ($1 eq $3 and $2 eq $4) {
$c =~ s/JL ([A-Z]+) ([A-Z]+) ([A-Z]+) ([A-Z]+)/JL $1 $2/g;
}
}
if ($c =~ /JL ([A-Z]+) JL/) {
$c =~ s/JL ([A-Z]+) JL/JL $1/g;
}
if ($c =~ /JL ([A-Z ]+)/) {
$c =~ s/JL ([A-Z ]+)/JL $1 $2/g;
}
if ($c =~ /JL ([A-Z]+) ([A-Z]+)/) {
if ($1 eq $2) {
$lc =~ s/JL ([A-Z]+) ([A-Z]+)/JL $1/g;
}
}
if ($c =~ /PASAR ([A-Z]+) ([A-Z]+)/) {
if ($1 eq $2) {
$c =~ s/PASAR ([A-Z]+) ([A-Z]+)/PASAR $1/g;
}
}
if ($c =~ /[A-Z] JL /) {
$c =~ s/[A-Z] JL / JL /g;
}
if ($c =~ / ([0-9])+[A-Z] /) {
$c =~ s/ ([0-9])+[A-Z] / /g;
}
if ($c =~ /([A-Z]+) JL /) {
$c =~ s/([A-Z]+) JL / JL /g;
}
if ($a =~ / BLOK | BLK / or $c =~ / BLOK | BLK /) {
$a =~ s/ BLOK | BLK / /g;
$c =~ s/ BLOK | BLK / /g;
}
if ($a =~ / RT / or $c =~ / RT /) {
$a =~ s/ RT / /g;
$c =~ s/ RT / /g;
}
if ($a =~ / RW / or $c =~ / RW /) {
$a =~ s/ RW / /g;
$c =~ s/ RW / /g;
}
if ($a =~ / [A-Z] [A-Z] / or $a =~ / [A-Z] /) {
$a =~ s/ [A-Z] [A-Z] / /g;
$a =~ s/ [A-Z] / /g;
}
if ($c =~ / [A-Z] [A-Z] / or $c =~ / [A-Z] /) {
$c =~ s/ [A-Z] [A-Z] / /g;
$c =~ s/ [A-Z] / /g;
}
if ($c =~ /[0-9][0-9][0-9][0-9][0-9][0-9][0-9]/) {
$c =~ s/[0-9][0-9][0-9][0-9][0-9][0-9][0-9]/ /g;
}
if ($c =~ /[0-9][0-9][0-9][0-9][0-9]+/) {
$c =~ s/[0-9][0-9][0-9][0-9][0-9]+/ /g;
}
if ($c =~ /[0-9][0-9][0-9][0-9]/) {
$c =~ s/[0-9][0-9][0-9][0-9]/ /g;
}
if ($a =~ /\s+/ or $b =~ /\s+/ or $c =~ /\s+/) {
$a =~ s/\s+/ /g;
$b =~ s/\s+/ /g;
$c =~ s/\s+/ /g;
}
if (length($c) <= 15) {
$c = $c;
}
if (length($c) > 15) {
$first_char = substr($c, 0, 15);
$c = $first_char;
}
if ($d eq "ADA_KEMUNGKINAN_SAMA  " and $a =~ $c and $c =~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN | JENDERAL/) {
print OUT $a."^".$b."^".$c."^MATCH\n";
}
elsif ($d eq "ADA_KEMUNGKINAN_SAMA  " and $a =~ $c and $c !~ / JL | UNNAMED | PASAR | PASAR| PERUMAHANVILLA | MALL | KOMPLEK | RUKO | PLAZA | PERUMAHAN | JENDERAL/) {
print OUT $a."^".$b."^".$c."^NOT MATCH\n";
}
else {
print OUT $a."^".$b."^".$c."^NOT MATCH\n";
}
}
close (FILE);
close (OUT);

#---- 3
#UNTUK MERAPIKAN HASIL OUTPUT DARI 'HasilStringMatchingAkhir.txt'
#!C:/Perl64/bin/perl.exe -w
open(FILE, "matching/HasilStringMatching4.txt") or die "can't open";
open(FILE2, "matching/StringHasil5.txt") or die "can't open";
open(OUT, ">matching/HasilStringMatching5.txt") or die "can't open";
while ($line1 = <FILE> and $line2 = <FILE2>) {
chomp $line1;
chomp $line2;
@lines1 = split('\^', $line1);
@lines2 = split('\|', $line2);
$liness1 = $lines1[3];
$liness2 = $lines2[0];
print OUT $liness2."^".$liness1."\n";
}
close (FILE);
close (FILE2);
close (OUT);

#---- 4
#UNTUK IMPORT HASIL PARSING KE DATABASE YANG ADA
#!/usr/bin/perl -w
use DBI;
open (OUT, 'matching/HasilStringMatching5.txt') or die "can't open";
open (OUT2, 'matching/DokumenMatchJalan.txt') or die "can't open";
@q = <OUT2>;
$qq = "@q";
foreach $aaa(<OUT>) {
@lines6 = split(/\^/, $aaa);
$a6 = $lines6[0];
$b6 = $lines6[1];
if ($b6 =~ /\n/) {
$b6 =~ s/\n//g;
}
$user = "gis";
$pw = "Gis123.>";
$dsn = 'dbi:Pg:dbname=db_engine_geocode;host=192.168.5.11;port=5432';
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "insert into $qq (id,keterangan) values (?,?)";
$sth = $dbh->prepare($sql);
$sth->execute($a6, $b6) or die "SQL Error: $DBI::errstr\n";
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
close (OUT);
close (OUT2);

#---- 5
#JOIN TABLE database_geocode DENGAN TABLE parsing UNTUK NGAMBIL NILAI PARSING
#!/usr/bin/perl -w
use DBI;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
open (OUT2, 'matching/DokumenMatchJalan.txt') or die "can't open";
@q = <OUT2>;
$qq = "@q";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "update $tb set match_jln = ? where id = ?";
$sth = $dbh->prepare($sql);
$sql2 = "select a.id, a.keterangan from $qq as a left join $tb as b on a.id = b.id order by a.id";
$sth2 = $dbh->prepare($sql2);
$sth2->execute;
while (@data = $sth2->fetchrow_array()) {
    my $id = $data[0];
    my $keterangan = $data[1];
    $sth->execute($keterangan, $id);
    $sth->finish;
}
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
$sth2->finish;
close (OUT);
close (OUT2);

#---- 6
#PROSES MATCHING JALAN DENGAN MENGGUNAKAN PLACE_NAME
#UNTUK MENARIK DATA YANG DIBUTUHKAN DARI DATABASE
#SETELAH MENARIK DATA, MAKA DATA YANG ADA AKAN DIUBAH FORMATNYA SESUAI DENGAN YANG DIGUNAKAN PADA PROSES SELANJUTNYA
#!C:/Perl/bin/perl.exe -w
use DBI;
use DBD::mysql;
open (OUT2, '>matching/StringPlaceName1.txt') or die "can't open";
open (OUT, 'matching/Dokumen.txt') or die "can't open";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
$sql = "SELECT upper(concat(id,' ^ ',ori_name,' , ',ori_address,' , ',ori_vi,' , ',ori_su,' , ',ori_di,' , ',ori_pr,' ^ ',place_name)) FROM $tb where match_jln = 'NOT MATCH' and flag_geocode != 'Q' order by id";
$sth = $dbh->prepare($sql);
$sth->execute or die "SQL Error: $DBI::errstr\n";
while (@row = $sth->fetchrow_array) {
print OUT2 "@row\n";
}
}
close (OUT);
close (OUT2);
open(FILE2, ">>matching/StringPlaceName1.txt") or die "can't open";
print FILE2 "~ ";
close (FILE2);

#---- 7
#UNTUK MERUBAH SINGKATAN-SINGKATAN TERUTAMA SINGKATAN ADM
#!C:/Perl/bin/perl.exe -w
open(FILE, "matching/DB_SingkatanPOI.txt") or die "can't open";
open(FILE2, "matching/StringPlaceName1.txt") or die "can't open";
open (OUT, '>matching/StringPlaceName2.txt') or die "can't open";
@aa = <FILE2>;
$aaa = "@aa";
foreach ($aaa =~ /\~ /) {
@listdata = split(/\~ /, $aaa);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
$listdata[$i] =~ s/[-]//g;
foreach $entitas(<FILE>) {
@lines = split(/,/, $entitas);
chomp @lines;
$a = $lines[0];
$b = $lines[1];
if ($listdata[$i] =~ / $a /) {
$listdata[$i] =~ s/ $a / $b /g;
}
}
$listdata[$i] =~ s/\s\n\s/\n/g;
$listdata[$i] =~ s/\n\s/\n/g;
print OUT $listdata[$i]."\n";
print OUT "~ ";
}
}
close (FILE);
close (FILE2);
close (OUT);

#---- 8
#UNTUK MENGHAPUS SPASI DAN SIMBOL2 TIDAK PENTING SERTA MERAPIKAN ISI FILE
#!C:/Perl/bin/perl.exe -w
open(FILE, "matching/StringPlaceName2.txt") or die "can't open";
open(OUT, ">matching/StringPlaceName3.txt") or die "can't open";
foreach $entitas(<FILE>) {
@listdata = split(/\~ /, $entitas);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
foreach ($listdata[$i] =~ /\^/) {
@listdata2 = split(/\^/, $listdata[$i]);
$id = $listdata2[0];
$add = $listdata2[1];
$kel = $listdata2[2];
$add =~ s/\s//g;
$add =~ s/[-]//g;
$add =~ s/\,\,\,\,/\,/g;
$add =~ s/\,\,\,/\,/g;
$add =~ s/\,\,/\,/g;
$kel =~ s/\s//g;
$kel =~ s/[-]//g;
print OUT $id."^".$add."^".$kel."\n";
}
}
}
close (FILE);
close (OUT);

#---- 9
#UNTUK MELAKUKAN PROSES MATCHING ADM UNTUK SETIAP LEVEL ADM
#!C:/Perl/bin/perl.exe -w
open(OUT1, "matching/StringPlaceName3.txt") or die "can't open";
open(OUT2, ">matching/StringPlaceName4.txt") or die "can't open";
foreach $entitas(<OUT1>) {
@listdata2 = split(/\^/, $entitas);
$id = $listdata2[0];
$add = $listdata2[1];
$kel = $listdata2[2];
$kel =~ s/\n//g;
if ($add =~ $kel) {
print OUT2 $id." ^ ".$kel." ^ MATCH\n";
}
elsif ($add !~ $kel) {
print OUT2 $id." ^ ".$kel." ^ NOT MATCH\n";
}
}
close (OUT1);
close (OUT2);

#---- 10
#UNTUK TRUNCATE TABLE MATCHING_JALAN SEBELUM DIINSERT VALUE
#!/usr/bin/perl -w
use DBI;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
open (OUT2, 'matching/DokumenMatchJalan.txt') or die "can't open";
@q = <OUT2>;
$qq = "@q";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "truncate $qq";
$sth = $dbh->prepare($sql);
$sth->execute or die "SQL Error: $DBI::errstr\n";
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
close (OUT);
close (OUT2);

#---- 11
#UNTUK IMPORT HASIL PARSING KE DATABASE YANG ADA
#!/usr/bin/perl -w
use DBI;
open (OUT2, 'matching/StringPlaceName4.txt') or die "can't open";
open (OUT3, 'matching/DokumenMatchJalan.txt') or die "can't open";
@q = <OUT3>;
$qq = "@q";
foreach $aaa(<OUT2>) {
@lines6 = split(/\s\^ /, $aaa);
$a6 = $lines6[0];
$b6 = $lines6[1];
$c6 = $lines6[2];
if ($c6 =~ /\n/) {
$c6 =~ s/\n//g;
}
$user = "gis";
$pw = "Gis123.>";
$dsn = 'dbi:Pg:dbname=db_engine_geocode;host=192.168.5.11;port=5432';
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "insert into $qq (id,keterangan) values (?,?)";
$sth = $dbh->prepare($sql);
$sth->execute($a6,$c6) or die "SQL Error: $DBI::errstr\n";
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
close (OUT2);
close (OUT3);

#---- 12
#JOIN TABLE database_geocode DENGAN TABLE parsing UNTUK NGAMBIL NILAI PARSING
#!/usr/bin/perl -w
use DBI;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
open (OUT2, 'matching/DokumenMatchJalan.txt') or die "can't open";
@q = <OUT2>;
$qq = "@q";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "update $tb set match_jln = ? where id = ?";
$sth = $dbh->prepare($sql);
$sql2 = "select a.id, a.keterangan from $qq as a left join $tb as b on a.id = b.id order by a.id";
$sth2 = $dbh->prepare($sql2);
$sth2->execute;
while (@data = $sth2->fetchrow_array()) {
    my $id = $data[0];
    my $matchvi = $data[1];
    $sth->execute($matchvi, $id);
    $sth->finish;
}
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
$sth2->finish;
close (OUT);
close (OUT2);

#---- 13
#PRINT KE LAYAR PERNYATAAN SELESAI
#!/usr/bin/perl -w
print "PROSES MATCHING JALAN SELESAI DILAKUKAN :)";
print "\n";

#------------------------------------------------------------------------------------------------------------#

#CODE 3 (MENYELESAIKAN MASALAH MATCHING ADM ANTARA ADM NFI DAN ADM INTERSECT DAN ADM GOOGLE)
#---- 1
#UNTUK MENARIK DATA YANG DIBUTUHKAN DARI DATABASE
#SETELAH MENARIK DATA, MAKA DATA YANG ADA AKAN DIUBAH FORMATNYA SESUAI DENGAN YANG DIGUNAKAN PADA PROSES SELANJUTNYA
#!C:/Perl/bin/perl.exe -w
use DBI;
use DBD::mysql;
open (OUT2, '>matching/StringConcat1.txt') or die "can't open";
open (OUT, 'matching/Dokumen.txt') or die "can't open";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
$sql = "SELECT upper(concat(id,' ^ ',ori_address,' , ',ori_vi,' , ',ori_su,' , ',ori_di,' , ',ori_pr,' ^ ',adm_vi,' ^ ',adm_su,' ^ ',adm_di,' ^ ',adm_pr)) FROM $tb where flag_geocode != 'Q'";
$sth = $dbh->prepare($sql);
$sth->execute or die "SQL Error: $DBI::errstr\n";
while (@row = $sth->fetchrow_array) {
print OUT2 "@row\n";
}
}
close (OUT);
close (OUT2);
open(FILE2, ">>matching/StringConcat1.txt") or die "can't open";
print FILE2 "~ ";
close (FILE2);

#---- 2
#UNTUK MERUBAH SINGKATAN-SINGKATAN TERUTAMA SINGKATAN ADM
#!C:/Perl/bin/perl.exe -w
open(FILE, "matching/DB4.txt") or die "can't open";
open(FILE2, "matching/StringConcat1.txt") or die "can't open";
open (OUT, '>matching/StringConcat2.txt') or die "can't open";
@aa = <FILE2>;
$aaa = "@aa";
foreach ($aaa =~ /\~ /) {
@listdata = split(/\~ /, $aaa);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
$listdata[$i] =~ s/[-]//g;
foreach $entitas(<FILE>) {
@lines = split(/,/, $entitas);
chomp @lines;
$a = $lines[0];
$b = $lines[1];
if ($listdata[$i] =~ / $a /) {
$listdata[$i] =~ s/ $a / $b /g;
}
}
if ($listdata[$i] =~ /DKI DKI JAKARTA|DKI JAKARTA BARAT|DKI JAKARTA TIMUR|DKI JAKARTA PUSAT|DKI JAKARTA UTARA|DKI JAKARTA SELATAN|DI DAERAH ISTIMEWA YOGYAKARTA|D I DAERAH ISTIMEWA YOGYAKARTA|POLDA ACEH|BATU PHAT|DPASAR|KELUNGKUNG| D E N P A S A R | PASR /) {
$listdata[$i] =~ s/DKI DKI JAKARTA/DKI JAKARTA/g;
$listdata[$i] =~ s/DKI JAKARTA BARAT/JAKARTA BARAT/g;
$listdata[$i] =~ s/DKI JAKARTA TIMUR/JAKARTA TIMUR/g;
$listdata[$i] =~ s/DKI JAKARTA PUSAT/JAKARTA PUSAT/g;
$listdata[$i] =~ s/DKI JAKARTA UTARA/JAKARTA UTARA/g;
$listdata[$i] =~ s/DKI JAKARTA SELATAN/JAKARTA SELATAN/g;
$listdata[$i] =~ s/DI DAERAH ISTIMEWA YOGYAKARTA/DAERAH ISTIMEWA YOGYAKARTA/g;
$listdata[$i] =~ s/D I DAERAH ISTIMEWA YOGYAKARTA/DAERAH ISTIMEWA YOGYAKARTA/g;
$listdata[$i] =~ s/POLDA ACEH/POLDA BANDA ACEH/g;
$listdata[$i] =~ s/BATU PHAT/BATU PHAT BARAT/g;
$listdata[$i] =~ s/BATU PHAT BARAT BARAT/BATU PHAT BARAT/g;
$listdata[$i] =~ s/BATU PHAT BARAT TIMUR/BATU PHAT TIMUR/g;
$listdata[$i] =~ s/DPASAR/DENPASAR/g;
$listdata[$i] =~ s/KELUNGKUNG/KLUNGKUNG/g;
$listdata[$i] =~ s/D E N P A S A R/DENPASAR/g;
$listdata[$i] =~ s/PASR/PASAR/g;
}
#mengubah format KOTA KOTA MEDAN menjadi KOTA MEDAN, DLL
if ($listdata[$i] =~ /TELUK KOTA MEDAN|TANJUNG KOTA MEDAN|TALANG KOTA MEDAN|SUKA KOTA MEDAN|SIMPANG KOTA KOTA MEDAN|SELAT TANJUNG KOTA MEDAN|RENAH KOTA MEDAN|PERKEBUNAN TANJUNG KOTA MEDAN|KOTA MEDAN TUNTUNGAN|KOTA MEDAN TIMUR|KOTA MEDAN TENGGARA|KOTA MEDAN TEMBUNG|KOTA MEDAN SUNGGAL|KOTA MEDAN SINEMBAH|KOTA MEDAN SERI RAMBAHAN|KOTA MEDAN SELAYANG|KOTA MEDAN SATRIA|KOTA MEDAN POLONIA|KOTA MEDAN PETISAH|KOTA MEDAN PERJUANGAN|KOTA MEDAN MARELAN|KOTA MEDAN MAIMUN|KOTA MEDAN LABUHAN|KOTA MEDAN KRIO|KOTA MEDAN KOTA BELAWAN|KOTA MEDAN KOTA|KOTA MEDAN JOHOR|KOTA MEDAN JAYA|KOTA MEDAN HELVETIA|KOTA MEDAN ESTATE|KOTA MEDAN DENAI|KOTA MEDAN DELI|KOTA MEDAN BARU|KOTA MEDAN BARAT|KOTA MEDAN AREA|KOTA MEDAN AMPLAS|KOTA KOTA MEDAN|KAMPUNG KOTA MEDAN|GUNUNG KOTA MEDAN/) {
$listdata[$i] =~ s/TELUK KOTA MEDAN/TELUK MEDAN/g;
$listdata[$i] =~ s/TANJUNG KOTA MEDAN/TANJUNG MEDAN/g;
$listdata[$i] =~ s/TALANG KOTA MEDAN/TALANG MEDAN/g;
$listdata[$i] =~ s/SUKA KOTA MEDAN/SUKA MEDAN/g;
$listdata[$i] =~ s/SIMPANG KOTA KOTA MEDAN/SIMPANG KOTA MEDAN/g;
$listdata[$i] =~ s/SELAT TANJUNG KOTA MEDAN/SELAT TANJUNG MEDAN/g;
$listdata[$i] =~ s/RENAH KOTA MEDAN/RENAH MEDAN/g;
$listdata[$i] =~ s/PERKEBUNAN TANJUNG KOTA MEDAN/PERKEBUNAN TANJUNG MEDAN/g;
$listdata[$i] =~ s/KOTA MEDAN TUNTUNGAN/MEDAN TUNTUNGAN/g;
$listdata[$i] =~ s/KOTA MEDAN TIMUR/MEDAN TIMUR/g;
$listdata[$i] =~ s/KOTA MEDAN TENGGARA/MEDAN TENGGARA/g;
$listdata[$i] =~ s/KOTA MEDAN TEMBUNG/MEDAN TEMBUNG/g;
$listdata[$i] =~ s/KOTA MEDAN SUNGGAL/MEDAN SUNGGAL/g;
$listdata[$i] =~ s/KOTA MEDAN SINEMBAH/MEDAN SINEMBAH/g;
$listdata[$i] =~ s/KOTA MEDAN SERI RAMBAHAN/MEDAN SERI RAMBAHAN/g;
$listdata[$i] =~ s/KOTA MEDAN SELAYANG/MEDAN SELAYANG/g;
$listdata[$i] =~ s/KOTA MEDAN SATRIA/MEDAN SATRIA/g;
$listdata[$i] =~ s/KOTA MEDAN POLONIA/MEDAN POLONIA/g;
$listdata[$i] =~ s/KOTA MEDAN PETISAH/MEDAN PETISAH/g;
$listdata[$i] =~ s/KOTA MEDAN PERJUANGAN/MEDAN PERJUANGAN/g;
$listdata[$i] =~ s/KOTA MEDAN MARELAN/MEDAN MARELAN/g;
$listdata[$i] =~ s/KOTA MEDAN MAIMUN/MEDAN MAIMUN/g;
$listdata[$i] =~ s/KOTA MEDAN LABUHAN/MEDAN LABUHAN/g;
$listdata[$i] =~ s/KOTA MEDAN KRIO/MEDAN KRIO/g;
$listdata[$i] =~ s/KOTA MEDAN KOTA BELAWAN/MEDAN KOTA BELAWAN/g;
$listdata[$i] =~ s/KOTA MEDAN KOTA/MEDAN KOTA/g;
$listdata[$i] =~ s/KOTA MEDAN JOHOR/MEDAN JOHOR/g;
$listdata[$i] =~ s/KOTA MEDAN JAYA/MEDAN JAYA/g;
$listdata[$i] =~ s/KOTA MEDAN HELVETIA/MEDAN HELVETIA/g;
$listdata[$i] =~ s/KOTA MEDAN ESTATE/MEDAN ESTATE/g;
$listdata[$i] =~ s/KOTA MEDAN DENAI/MEDAN DENAI/g;
$listdata[$i] =~ s/KOTA MEDAN DELI/MEDAN DELI/g;
$listdata[$i] =~ s/KOTA MEDAN BARU/MEDAN BARU/g;
$listdata[$i] =~ s/KOTA MEDAN BARAT/MEDAN BARAT/g;
$listdata[$i] =~ s/KOTA MEDAN AREA/MEDAN AREA/g;
$listdata[$i] =~ s/KOTA MEDAN AMPLAS/MEDAN AMPLAS/g;
$listdata[$i] =~ s/KOTA KOTA MEDAN/KOTA MEDAN/g;
$listdata[$i] =~ s/KAMPUNG KOTA MEDAN/KAMPUNG MEDAN/g;
$listdata[$i] =~ s/GUNUNG KOTA MEDAN/GUNUNG MEDAN/g;
}
if ($listdata[$i] =~ /TELUK KOTA BINJAI|TANJUNG KOTA BINJAI|SARING SUNGAI KOTA BINJAI|RAWANG KOTA BINJAI|PULAU KOTA BINJAI|PERADUAN KOTA BINJAI|PEKAN KOTA BINJAI|PADANG KOTA BINJAI|LUBUK KOTA BINJAI|KOTA KOTA BINJAI|KELURAHAN SUNGAI KOTA BINJAI|DARASAN KOTA BINJAI|KOTA BINJAI WANGI|KOTA BINJAI UTARA|KOTA BINJAI TIMUR|KOTA BINJAI TAPAN|KOTA BINJAI SERBANGAN|KOTA BINJAI SELATAN|KOTA BINJAI PUNGGAL|KOTA BINJAI PIRUA|KOTA BINJAI PEMANGKIH|KOTA BINJAI KOTA|KOTA BINJAI HULU|KOTA BINJAI HILIR|KOTA BINJAI ESTATE|KOTA BINJAI BARAT|KOTA BINJAI BAKUNG|KOTA BINJAI AGUNG|BANUA KOTA BINJAI/) {
$listdata[$i] =~ s/TELUK KOTA BINJAI/TELUK BINJAI/g;
$listdata[$i] =~ s/TANJUNG KOTA BINJAI/TANJUNG BINJAI/g;
$listdata[$i] =~ s/SARING SUNGAI KOTA BINJAI/SARING SUNGAI BINJAI/g;
$listdata[$i] =~ s/RAWANG KOTA BINJAI/RAWANG BINJAI/g;
$listdata[$i] =~ s/PULAU KOTA BINJAI/PULAU BINJAI/g;
$listdata[$i] =~ s/PERADUAN KOTA BINJAI/PERADUAN BINJAI/g;
$listdata[$i] =~ s/PEKAN KOTA BINJAI/PEKAN BINJAI/g;
$listdata[$i] =~ s/PADANG KOTA BINJAI/PADANG BINJAI/g;
$listdata[$i] =~ s/LUBUK KOTA BINJAI/LUBUK BINJAI/g;
$listdata[$i] =~ s/KOTA KOTA BINJAI/KOTA BINJAI/g;
$listdata[$i] =~ s/KELURAHAN SUNGAI KOTA BINJAI/KELURAHAN SUNGAI BINJAI/g;
$listdata[$i] =~ s/DARASAN KOTA BINJAI/DARASAN BINJAI/g;
$listdata[$i] =~ s/KOTA BINJAI WANGI/BINJAI WANGI/g;
$listdata[$i] =~ s/KOTA BINJAI UTARA/BINJAI UTARA/g;
$listdata[$i] =~ s/KOTA BINJAI TIMUR/BINJAI TIMUR/g;
$listdata[$i] =~ s/KOTA BINJAI TAPAN/BINJAI TAPAN/g;
$listdata[$i] =~ s/KOTA BINJAI SERBANGAN/BINJAI SERBANGAN/g;
$listdata[$i] =~ s/KOTA BINJAI SELATAN/BINJAI SELATAN/g;
$listdata[$i] =~ s/KOTA BINJAI PUNGGAL/BINJAI PUNGGAL/g;
$listdata[$i] =~ s/KOTA BINJAI PIRUA/BINJAI PIRUA/g;
$listdata[$i] =~ s/KOTA BINJAI PEMANGKIH/BINJAI PEMANGKIH/g;
$listdata[$i] =~ s/KOTA BINJAI KOTA/BINJAI KOTA/g;
$listdata[$i] =~ s/KOTA BINJAI HULU/BINJAI HULU/g;
$listdata[$i] =~ s/KOTA BINJAI HILIR/BINJAI HILIR/g;
$listdata[$i] =~ s/KOTA BINJAI ESTATE/BINJAI ESTATE/g;
$listdata[$i] =~ s/KOTA BINJAI BARAT/BINJAI BARAT/g;
$listdata[$i] =~ s/KOTA BINJAI BAKUNG/BINJAI BAKUNG/g;
$listdata[$i] =~ s/KOTA BINJAI AGUNG/BINJAI AGUNG/g;
$listdata[$i] =~ s/BANUA KOTA BINJAI/BANUA BINJAI/g;
}
$listdata[$i] =~ s/\s\n\s/\n/g;
$listdata[$i] =~ s/\n\s/\n/g;
print OUT $listdata[$i]."\n";
print OUT "~ ";
}
}
close (FILE);
close (FILE2);
close (OUT);

#---- 3
#UNTUK MENGHAPUS SPASI DAN SIMBOL2 TIDAK PENTING SERTA MERAPIKAN ISI FILE
#!C:/Perl/bin/perl.exe -w
open(FILE, "matching/StringConcat2.txt") or die "can't open";
open(OUT, ">matching/StringConcat3.txt") or die "can't open";
foreach $entitas(<FILE>) {
@listdata = split(/\~ /, $entitas);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
foreach ($listdata[$i] =~ /\^/) {
@listdata2 = split(/\^/, $listdata[$i]);
$id = $listdata2[0];
$add = $listdata2[1];
$kel = $listdata2[2];
$kec = $listdata2[3];
$kab = $listdata2[4];
$prov = $listdata2[5];
$add =~ s/\s//g;
$add =~ s/[-]//g;
$add =~ s/\,\,\,\,/\,/g;
$add =~ s/\,\,\,/\,/g;
$add =~ s/\,\,/\,/g;
$kel =~ s/\s//g;
$kel =~ s/[-]//g;
$kel =~ s/[(]//g;
$kel =~ s/[)]//g;
$kec =~ s/\s//g;
$kec =~ s/[-]//g;
$kec =~ s/[(]//g;
$kec =~ s/[)]//g;
$kab =~ s/\s//g;
$kab =~ s/[-]//g;
$kab =~ s/[(]//g;
$kab =~ s/[)]//g;
$prov =~ s/\s//g;
$prov =~ s/[-]//g;
$prov =~ s/[(]//g;
$prov =~ s/[)]//g;
print OUT $id."^".$add."^".$kel."^".$kec."^".$kab."^".$prov."\n";
}
}
}
close (FILE);
close (OUT);

#---- 4
#UNTUK MELAKUKAN PROSES MATCHING ADM UNTUK SETIAP LEVEL ADM
#!C:/Perl/bin/perl.exe -w
open(OUT1, "matching/StringConcat3.txt") or die "can't open";
open(OUT2, ">matching/StringConcatKel.txt") or die "can't open";
open(OUT3, ">matching/StringConcatKec.txt") or die "can't open";
open(OUT4, ">matching/StringConcatKab.txt") or die "can't open";
open(OUT5, ">matching/StringConcatProv.txt") or die "can't open";
foreach $entitas(<OUT1>) {
@listdata2 = split(/\^/, $entitas);
$id = $listdata2[0];
$add = $listdata2[1];
$kel = $listdata2[2];
$kec = $listdata2[3];
$kab = $listdata2[4];
$prov = $listdata2[5];
$prov =~ s/\n//g;
if ($add =~ $kel) {
print OUT2 $id." ^ ".$kel." ^ MATCH\n";
}
elsif ($add !~ $kel) {
print OUT2 $id." ^ ".$kel." ^ NOT MATCH\n";
}
if ($add =~ $kec) {
print OUT3 $id." ^ ".$kec." ^ MATCH\n";
}
elsif ($add !~ $kec) {
print OUT3 $id." ^ ".$kec." ^ NOT MATCH\n";
}
if ($add =~ $kab) {
print OUT4 $id." ^ ".$kab." ^ MATCH\n";
}
elsif ($add !~ $kab) {
print OUT4 $id." ^ ".$kab." ^ NOT MATCH\n";
}
if ($add =~ $prov) {
print OUT5 $id." ^ ".$prov." ^ MATCH\n";
}
elsif ($add !~ $prov) {
print OUT5 $id." ^ ".$prov." ^ NOT MATCH\n";
}
}
close (OUT1);
close (OUT2);
close (OUT3);
close (OUT4);
close (OUT5);

#---- 5
#UNTUK MERAPIKAN HASIL MATCHING ADM UNTUK SETIAP LEVEL ADM KE DALAM 1 FILE YANG SAMA
#!C:/Perl/bin/perl.exe -w
open(OUT2, "matching/StringConcatKel.txt") or die "can't open";
open(OUT3, "matching/StringConcatKec.txt") or die "can't open";
open(OUT4, "matching/StringConcatKab.txt") or die "can't open";
open(OUT5, "matching/StringConcatProv.txt") or die "can't open";
open(OUT6, ">matching/StringConcatGabung.txt") or die "can't open";
while ($line1 = <OUT2> and $line2 = <OUT3> and $line3 = <OUT4> and $line4 = <OUT5>) {
chomp $line1;
chomp $line2;
chomp $line3;
chomp $line4;
@lines1 = split('\^', $line1);
@lines2 = split('\^', $line2);
@lines3 = split('\^', $line3);
@lines4 = split('\^', $line4);
if ($lines1[0] == $lines2[0] and $lines3[0] and $lines4[0]) {
print OUT6 $lines1[0]." ^ ".$lines1[2]." ^ ".$lines2[2]." ^ ".$lines3[2]." ^ ".$lines4[2]."\n";
}
}
close (OUT2);
close (OUT3);
close (OUT4);
close (OUT5);
close (OUT6);

#---- 6
#UNTUK IMPORT HASIL PARSING KE DATABASE YANG ADA
#!/usr/bin/perl -w
use DBI;
open (OUT2, 'matching/StringConcatGabung.txt') or die "can't open";
open (OUT3, 'matching/DokumenMatchAdm.txt') or die "can't open";
@q = <OUT3>;
$qq = "@q";
foreach $aaa(<OUT2>) {
@lines6 = split(/\s\^  /, $aaa);
$a6 = $lines6[0];
$b6 = $lines6[1];
$c6 = $lines6[2];
$d6 = $lines6[3];
$e6 = $lines6[4];
if ($e6 =~ /\n/) {
$e6 =~ s/\n//g;
}
$user = "gis";
$pw = "Gis123.>";
$dsn = 'dbi:Pg:dbname=db_engine_geocode;host=192.168.5.11;port=5432';
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "insert into $qq values (?,?,?,?,?)";
$sth = $dbh->prepare($sql);
$sth->execute($a6,$b6,$c6,$d6,$e6) or die "SQL Error: $DBI::errstr\n";
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
close (OUT2);
close (OUT3);

#---- 7
#JOIN TABLE database_geocode DENGAN TABLE parsing UNTUK NGAMBIL NILAI PARSING
#!/usr/bin/perl -w
use DBI;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
open (OUT2, 'matching/DokumenMatchAdm.txt') or die "can't open";
@q = <OUT2>;
$qq = "@q";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "update $tb set match_vi = ?, match_su = ?, match_di = ?, match_pr = ? where id = ?";
$sth = $dbh->prepare($sql);
$sql2 = "select a.id, a.match_vi, a.match_su, a.match_di, a.match_pr from $qq as a left join $tb as b on a.id = b.id order by a.id";
$sth2 = $dbh->prepare($sql2);
$sth2->execute;
while (@data = $sth2->fetchrow_array()) {
    my $id = $data[0];
    my $matchvi = $data[1];
    my $matchsu = $data[2];
    my $matchdi = $data[3];
    my $matchpr = $data[4];
    $sth->execute($matchvi, $matchsu, $matchdi, $matchpr, $id);
    $sth->finish;
}
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
$sth2->finish;
close (OUT);
close (OUT2);

#---- 8
#JIKA TIDAK MATCH ADM DENGAN HASIL INTERSECT, MAKA COBA HAPUS KATA "KOTA","KEL","KEC" DARI STRING YANG ADA
#UNTUK MENARIK DATA YANG DIBUTUHKAN DARI DATABASE
#SETELAH MENARIK DATA, MAKA DATA YANG ADA AKAN DIUBAH FORMATNYA SESUAI DENGAN YANG DIGUNAKAN PADA PROSES SELANJUTNYA
#!C:/Perl/bin/perl.exe -w
use DBI;
use DBD::mysql;
open (OUT2, '>matching/StringConcatKota0.txt') or die "can't open";
open (OUT, 'matching/Dokumen.txt') or die "can't open";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
$sql = "SELECT upper(concat(id,' ^ ',ori_address,' , ',ori_vi,' , ',ori_su,' , ',ori_di,' , ',ori_pr,' ^ ',adm_vi,' ^ ',adm_su,' ^ ',adm_di,' ^ ',adm_pr)) FROM $tb where match_di = 'NOT MATCH' and flag_geocode != 'Q'";
$sth = $dbh->prepare($sql);
$sth->execute or die "SQL Error: $DBI::errstr\n";
while (@row = $sth->fetchrow_array) {
print OUT2 "@row\n";
}
}
close (OUT);
close (OUT2);
open(FILE2, ">>matching/StringConcatKota0.txt") or die "can't open";
print FILE2 "~ ";
close (FILE2);
#UNTUK MERUBAH SINGKATAN-SINGKATAN TERUTAMA SINGKATAN ADM
#!C:/Perl/bin/perl.exe -w
open(FILE, "matching/DB6.txt") or die "can't open";
open(FILE2, "matching/StringConcatKota0.txt") or die "can't open";
open (OUT, '>matching/StringConcatKota1.txt') or die "can't open";
@aa = <FILE2>;
$aaa = "@aa";
foreach ($aaa =~ /\~ /) {
@listdata = split(/\~ /, $aaa);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
$listdata[$i] =~ s/[-]//g;
foreach $entitas(<FILE>) {
@lines = split(/,/, $entitas);
chomp @lines;
$a = $lines[0];
$b = $lines[1];
if ($listdata[$i] =~ / $a /) {
$listdata[$i] =~ s/ $a / $b /g;
}
}
if ($listdata[$i] =~ /DKI DKI JAKARTA|DKI JAKARTA BARAT|DKI JAKARTA TIMUR|DKI JAKARTA PUSAT|DKI JAKARTA UTARA|DKI JAKARTA SELATAN|DI DAERAH ISTIMEWA YOGYAKARTA|D I DAERAH ISTIMEWA YOGYAKARTA|POLDA ACEH|BATU PHAT|DPASAR|KELUNGKUNG| D E N P A S A R | PASR /) {
$listdata[$i] =~ s/DKI DKI JAKARTA/DKI JAKARTA/g;
$listdata[$i] =~ s/DKI JAKARTA BARAT/JAKARTA BARAT/g;
$listdata[$i] =~ s/DKI JAKARTA TIMUR/JAKARTA TIMUR/g;
$listdata[$i] =~ s/DKI JAKARTA PUSAT/JAKARTA PUSAT/g;
$listdata[$i] =~ s/DKI JAKARTA UTARA/JAKARTA UTARA/g;
$listdata[$i] =~ s/DKI JAKARTA SELATAN/JAKARTA SELATAN/g;
$listdata[$i] =~ s/DI DAERAH ISTIMEWA YOGYAKARTA/DAERAH ISTIMEWA YOGYAKARTA/g;
$listdata[$i] =~ s/D I DAERAH ISTIMEWA YOGYAKARTA/DAERAH ISTIMEWA YOGYAKARTA/g;
$listdata[$i] =~ s/POLDA ACEH/POLDA BANDA ACEH/g;
$listdata[$i] =~ s/BATU PHAT/BATU PHAT BARAT/g;
$listdata[$i] =~ s/BATU PHAT BARAT BARAT/BATU PHAT BARAT/g;
$listdata[$i] =~ s/BATU PHAT BARAT TIMUR/BATU PHAT TIMUR/g;
$listdata[$i] =~ s/DPASAR/DENPASAR/g;
$listdata[$i] =~ s/KELUNGKUNG/KLUNGKUNG/g;
$listdata[$i] =~ s/D E N P A S A R/DENPASAR/g;
$listdata[$i] =~ s/PASR/PASAR/g;
}
#mengubah format KOTA KOTA MEDAN menjadi KOTA MEDAN, DLL
if ($listdata[$i] =~ /TELUK KOTA MEDAN|TANJUNG KOTA MEDAN|TALANG KOTA MEDAN|SUKA KOTA MEDAN|SIMPANG KOTA KOTA MEDAN|SELAT TANJUNG KOTA MEDAN|RENAH KOTA MEDAN|PERKEBUNAN TANJUNG KOTA MEDAN|KOTA MEDAN TUNTUNGAN|KOTA MEDAN TIMUR|KOTA MEDAN TENGGARA|KOTA MEDAN TEMBUNG|KOTA MEDAN SUNGGAL|KOTA MEDAN SINEMBAH|KOTA MEDAN SERI RAMBAHAN|KOTA MEDAN SELAYANG|KOTA MEDAN SATRIA|KOTA MEDAN POLONIA|KOTA MEDAN PETISAH|KOTA MEDAN PERJUANGAN|KOTA MEDAN MARELAN|KOTA MEDAN MAIMUN|KOTA MEDAN LABUHAN|KOTA MEDAN KRIO|KOTA MEDAN KOTA BELAWAN|KOTA MEDAN KOTA|KOTA MEDAN JOHOR|KOTA MEDAN JAYA|KOTA MEDAN HELVETIA|KOTA MEDAN ESTATE|KOTA MEDAN DENAI|KOTA MEDAN DELI|KOTA MEDAN BARU|KOTA MEDAN BARAT|KOTA MEDAN AREA|KOTA MEDAN AMPLAS|KOTA KOTA MEDAN|KAMPUNG KOTA MEDAN|GUNUNG KOTA MEDAN/) {
$listdata[$i] =~ s/TELUK KOTA MEDAN/TELUK MEDAN/g;
$listdata[$i] =~ s/TANJUNG KOTA MEDAN/TANJUNG MEDAN/g;
$listdata[$i] =~ s/TALANG KOTA MEDAN/TALANG MEDAN/g;
$listdata[$i] =~ s/SUKA KOTA MEDAN/SUKA MEDAN/g;
$listdata[$i] =~ s/SIMPANG KOTA KOTA MEDAN/SIMPANG KOTA MEDAN/g;
$listdata[$i] =~ s/SELAT TANJUNG KOTA MEDAN/SELAT TANJUNG MEDAN/g;
$listdata[$i] =~ s/RENAH KOTA MEDAN/RENAH MEDAN/g;
$listdata[$i] =~ s/PERKEBUNAN TANJUNG KOTA MEDAN/PERKEBUNAN TANJUNG MEDAN/g;
$listdata[$i] =~ s/KOTA MEDAN TUNTUNGAN/MEDAN TUNTUNGAN/g;
$listdata[$i] =~ s/KOTA MEDAN TIMUR/MEDAN TIMUR/g;
$listdata[$i] =~ s/KOTA MEDAN TENGGARA/MEDAN TENGGARA/g;
$listdata[$i] =~ s/KOTA MEDAN TEMBUNG/MEDAN TEMBUNG/g;
$listdata[$i] =~ s/KOTA MEDAN SUNGGAL/MEDAN SUNGGAL/g;
$listdata[$i] =~ s/KOTA MEDAN SINEMBAH/MEDAN SINEMBAH/g;
$listdata[$i] =~ s/KOTA MEDAN SERI RAMBAHAN/MEDAN SERI RAMBAHAN/g;
$listdata[$i] =~ s/KOTA MEDAN SELAYANG/MEDAN SELAYANG/g;
$listdata[$i] =~ s/KOTA MEDAN SATRIA/MEDAN SATRIA/g;
$listdata[$i] =~ s/KOTA MEDAN POLONIA/MEDAN POLONIA/g;
$listdata[$i] =~ s/KOTA MEDAN PETISAH/MEDAN PETISAH/g;
$listdata[$i] =~ s/KOTA MEDAN PERJUANGAN/MEDAN PERJUANGAN/g;
$listdata[$i] =~ s/KOTA MEDAN MARELAN/MEDAN MARELAN/g;
$listdata[$i] =~ s/KOTA MEDAN MAIMUN/MEDAN MAIMUN/g;
$listdata[$i] =~ s/KOTA MEDAN LABUHAN/MEDAN LABUHAN/g;
$listdata[$i] =~ s/KOTA MEDAN KRIO/MEDAN KRIO/g;
$listdata[$i] =~ s/KOTA MEDAN KOTA BELAWAN/MEDAN KOTA BELAWAN/g;
$listdata[$i] =~ s/KOTA MEDAN KOTA/MEDAN KOTA/g;
$listdata[$i] =~ s/KOTA MEDAN JOHOR/MEDAN JOHOR/g;
$listdata[$i] =~ s/KOTA MEDAN JAYA/MEDAN JAYA/g;
$listdata[$i] =~ s/KOTA MEDAN HELVETIA/MEDAN HELVETIA/g;
$listdata[$i] =~ s/KOTA MEDAN ESTATE/MEDAN ESTATE/g;
$listdata[$i] =~ s/KOTA MEDAN DENAI/MEDAN DENAI/g;
$listdata[$i] =~ s/KOTA MEDAN DELI/MEDAN DELI/g;
$listdata[$i] =~ s/KOTA MEDAN BARU/MEDAN BARU/g;
$listdata[$i] =~ s/KOTA MEDAN BARAT/MEDAN BARAT/g;
$listdata[$i] =~ s/KOTA MEDAN AREA/MEDAN AREA/g;
$listdata[$i] =~ s/KOTA MEDAN AMPLAS/MEDAN AMPLAS/g;
$listdata[$i] =~ s/KOTA KOTA MEDAN/KOTA MEDAN/g;
$listdata[$i] =~ s/KAMPUNG KOTA MEDAN/KAMPUNG MEDAN/g;
$listdata[$i] =~ s/GUNUNG KOTA MEDAN/GUNUNG MEDAN/g;
}
if ($listdata[$i] =~ /TELUK KOTA BINJAI|TANJUNG KOTA BINJAI|SARING SUNGAI KOTA BINJAI|RAWANG KOTA BINJAI|PULAU KOTA BINJAI|PERADUAN KOTA BINJAI|PEKAN KOTA BINJAI|PADANG KOTA BINJAI|LUBUK KOTA BINJAI|KOTA KOTA BINJAI|KELURAHAN SUNGAI KOTA BINJAI|DARASAN KOTA BINJAI|KOTA BINJAI WANGI|KOTA BINJAI UTARA|KOTA BINJAI TIMUR|KOTA BINJAI TAPAN|KOTA BINJAI SERBANGAN|KOTA BINJAI SELATAN|KOTA BINJAI PUNGGAL|KOTA BINJAI PIRUA|KOTA BINJAI PEMANGKIH|KOTA BINJAI KOTA|KOTA BINJAI HULU|KOTA BINJAI HILIR|KOTA BINJAI ESTATE|KOTA BINJAI BARAT|KOTA BINJAI BAKUNG|KOTA BINJAI AGUNG|BANUA KOTA BINJAI/) {
$listdata[$i] =~ s/TELUK KOTA BINJAI/TELUK BINJAI/g;
$listdata[$i] =~ s/TANJUNG KOTA BINJAI/TANJUNG BINJAI/g;
$listdata[$i] =~ s/SARING SUNGAI KOTA BINJAI/SARING SUNGAI BINJAI/g;
$listdata[$i] =~ s/RAWANG KOTA BINJAI/RAWANG BINJAI/g;
$listdata[$i] =~ s/PULAU KOTA BINJAI/PULAU BINJAI/g;
$listdata[$i] =~ s/PERADUAN KOTA BINJAI/PERADUAN BINJAI/g;
$listdata[$i] =~ s/PEKAN KOTA BINJAI/PEKAN BINJAI/g;
$listdata[$i] =~ s/PADANG KOTA BINJAI/PADANG BINJAI/g;
$listdata[$i] =~ s/LUBUK KOTA BINJAI/LUBUK BINJAI/g;
$listdata[$i] =~ s/KOTA KOTA BINJAI/KOTA BINJAI/g;
$listdata[$i] =~ s/KELURAHAN SUNGAI KOTA BINJAI/KELURAHAN SUNGAI BINJAI/g;
$listdata[$i] =~ s/DARASAN KOTA BINJAI/DARASAN BINJAI/g;
$listdata[$i] =~ s/KOTA BINJAI WANGI/BINJAI WANGI/g;
$listdata[$i] =~ s/KOTA BINJAI UTARA/BINJAI UTARA/g;
$listdata[$i] =~ s/KOTA BINJAI TIMUR/BINJAI TIMUR/g;
$listdata[$i] =~ s/KOTA BINJAI TAPAN/BINJAI TAPAN/g;
$listdata[$i] =~ s/KOTA BINJAI SERBANGAN/BINJAI SERBANGAN/g;
$listdata[$i] =~ s/KOTA BINJAI SELATAN/BINJAI SELATAN/g;
$listdata[$i] =~ s/KOTA BINJAI PUNGGAL/BINJAI PUNGGAL/g;
$listdata[$i] =~ s/KOTA BINJAI PIRUA/BINJAI PIRUA/g;
$listdata[$i] =~ s/KOTA BINJAI PEMANGKIH/BINJAI PEMANGKIH/g;
$listdata[$i] =~ s/KOTA BINJAI KOTA/BINJAI KOTA/g;
$listdata[$i] =~ s/KOTA BINJAI HULU/BINJAI HULU/g;
$listdata[$i] =~ s/KOTA BINJAI HILIR/BINJAI HILIR/g;
$listdata[$i] =~ s/KOTA BINJAI ESTATE/BINJAI ESTATE/g;
$listdata[$i] =~ s/KOTA BINJAI BARAT/BINJAI BARAT/g;
$listdata[$i] =~ s/KOTA BINJAI BAKUNG/BINJAI BAKUNG/g;
$listdata[$i] =~ s/KOTA BINJAI AGUNG/BINJAI AGUNG/g;
$listdata[$i] =~ s/BANUA KOTA BINJAI/BANUA BINJAI/g;
}
$listdata[$i] =~ s/\s\n\s/\n/g;
$listdata[$i] =~ s/\n\s/\n/g;
print OUT $listdata[$i]."\n";
print OUT "~ ";
}
}
close (FILE);
close (FILE2);
close (OUT);

#---- 9
#UNTUK MENGHAPUS SPASI DAN SIMBOL2 TIDAK PENTING SERTA MERAPIKAN ISI FILE
#!C:/Perl/bin/perl.exe -w
open(FILE, "matching/StringConcatKota1.txt") or die "can't open";
open(OUT, ">matching/StringConcatKota2.txt") or die "can't open";
foreach $entitas(<FILE>) {
@listdata = split(/\~ /, $entitas);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
foreach ($listdata[$i] =~ /\^/) {
@listdata2 = split(/\^/, $listdata[$i]);
$id = $listdata2[0];
$add = $listdata2[1];
$kel = $listdata2[2];
$kec = $listdata2[3];
$kab = $listdata2[4];
$prov = $listdata2[5];
$add =~ s/\s//g;
$add =~ s/[-]//g;
$add =~ s/\,\,\,\,/\,/g;
$add =~ s/\,\,\,/\,/g;
$add =~ s/\,\,/\,/g;
$kel =~ s/\s//g;
$kel =~ s/[-]//g;
$kec =~ s/\s//g;
$kec =~ s/[-]//g;
$kab =~ s/\s//g;
$kab =~ s/[-]//g;
$prov =~ s/\s//g;
$prov =~ s/[-]//g;
print OUT $id."^".$add."^".$kel."^".$kec."^".$kab."^".$prov."\n";
}
}
}
close (FILE);
close (OUT);

#---- 10
#UNTUK MELAKUKAN PROSES MATCHING ADM UNTUK SETIAP LEVEL ADM
#!C:/Perl/bin/perl.exe -w
open(OUT1, "matching/StringConcatKota2.txt") or die "can't open";
open(OUT2, ">matching/StringConcatKotaKel.txt") or die "can't open";
open(OUT3, ">matching/StringConcatKotaKec.txt") or die "can't open";
open(OUT4, ">matching/StringConcatKotaKab.txt") or die "can't open";
open(OUT5, ">matching/StringConcatKotaProv.txt") or die "can't open";
foreach $entitas(<OUT1>) {
@listdata2 = split(/\^/, $entitas);
$id = $listdata2[0];
$add = $listdata2[1];
$kel = $listdata2[2];
$kec = $listdata2[3];
$kab = $listdata2[4];
$prov = $listdata2[5];
$prov =~ s/\n//g;
if ($add =~ $kel) {
print OUT2 $id." ^ ".$kel." ^ MATCH\n";
}
elsif ($add !~ $kel) {
print OUT2 $id." ^ ".$kel." ^ NOT MATCH\n";
}
if ($add =~ $kec) {
print OUT3 $id." ^ ".$kec." ^ MATCH\n";
}
elsif ($add !~ $kec) {
print OUT3 $id." ^ ".$kec." ^ NOT MATCH\n";
}
if ($add =~ $kab) {
print OUT4 $id." ^ ".$kab." ^ MATCH\n";
}
elsif ($add !~ $kab) {
print OUT4 $id." ^ ".$kab." ^ NOT MATCH\n";
}
if ($add =~ $prov) {
print OUT5 $id." ^ ".$prov." ^ MATCH\n";
}
elsif ($add !~ $prov) {
print OUT5 $id." ^ ".$prov." ^ NOT MATCH\n";
}
}
close (OUT1);
close (OUT2);
close (OUT3);
close (OUT4);
close (OUT5);

#---- 11
#UNTUK MERAPIKAN HASIL MATCHING ADM UNTUK SETIAP LEVEL ADM KE DALAM 1 FILE YANG SAMA
#!C:/Perl/bin/perl.exe -w
open(OUT2, "matching/StringConcatKotaKel.txt") or die "can't open";
open(OUT3, "matching/StringConcatKotaKec.txt") or die "can't open";
open(OUT4, "matching/StringConcatKotaKab.txt") or die "can't open";
open(OUT5, "matching/StringConcatKotaProv.txt") or die "can't open";
open(OUT6, ">matching/StringConcatKotaGabung.txt") or die "can't open";
while ($line1 = <OUT2> and $line2 = <OUT3> and $line3 = <OUT4> and $line4 = <OUT5>) {
chomp $line1;
chomp $line2;
chomp $line3;
chomp $line4;
@lines1 = split('\^', $line1);
@lines2 = split('\^', $line2);
@lines3 = split('\^', $line3);
@lines4 = split('\^', $line4);
if ($lines1[0] == $lines2[0] and $lines3[0] and $lines4[0]) {
print OUT6 $lines1[0]." ^ ".$lines1[2]." ^ ".$lines2[2]." ^ ".$lines3[2]." ^ ".$lines4[2]."\n";
}
}
close (OUT2);
close (OUT3);
close (OUT4);
close (OUT5);
close (OUT6);

#---- 12
#UNTUK TRUNCATE TABLE MATCHING_ADM SEBELUM DIINSERT VALUE DAN IMPORT DATA KE DB YANG DIGUNAKAN
#!/usr/bin/perl -w
use DBI;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
open (OUT2, 'matching/DokumenMatchAdm.txt') or die "can't open";
@q = <OUT2>;
$qq = "@q";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "truncate $qq";
$sth = $dbh->prepare($sql);
$sth->execute or die "SQL Error: $DBI::errstr\n";
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
close (OUT);
close (OUT2);

#---- 13
#UNTUK IMPORT HASIL PARSING KE DATABASE YANG ADA
#!/usr/bin/perl -w
use DBI;
open (OUT2, 'matching/StringConcatKotaGabung.txt') or die "can't open";
open (OUT3, 'matching/DokumenMatchAdm.txt') or die "can't open";
@q = <OUT3>;
$qq = "@q";
foreach $aaa(<OUT2>) {
@lines6 = split(/\s\^  /, $aaa);
$a6 = $lines6[0];
$b6 = $lines6[1];
$c6 = $lines6[2];
$d6 = $lines6[3];
$e6 = $lines6[4];
if ($e6 =~ /\n/) {
$e6 =~ s/\n//g;
}
$user = "gis";
$pw = "Gis123.>";
$dsn = 'dbi:Pg:dbname=db_engine_geocode;host=192.168.5.11;port=5432';
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "insert into $qq values (?,?,?,?,?)";
$sth = $dbh->prepare($sql);
$sth->execute($a6,$b6,$c6,$d6,$e6) or die "SQL Error: $DBI::errstr\n";
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
close (OUT2);
close (OUT3);

#---- 14
#JOIN TABLE database_geocode DENGAN TABLE parsing UNTUK NGAMBIL NILAI PARSING
#!/usr/bin/perl -w
use DBI;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
open (OUT2, 'matching/DokumenMatchAdm.txt') or die "can't open";
@q = <OUT2>;
$qq = "@q";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "update $tb set match_vi = ?, match_su = ?, match_di = ?, match_pr = ? where id = ?";
$sth = $dbh->prepare($sql);
$sql2 = "select a.id, a.match_vi, a.match_su, a.match_di, a.match_pr from $qq as a left join $tb as b on a.id = b.id order by a.id";
$sth2 = $dbh->prepare($sql2);
$sth2->execute;
while (@data = $sth2->fetchrow_array()) {
    my $id = $data[0];
    my $matchvi = $data[1];
    my $matchsu = $data[2];
    my $matchdi = $data[3];
    my $matchpr = $data[4];
    $sth->execute($matchvi, $matchsu, $matchdi, $matchpr, $id);
    $sth->finish;
}
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
$sth2->finish;
close (OUT);
close (OUT2);

#---- 15
#JIKA HASIL MATCH ADM TIDAK MATCH MAKA DI MATCHING ULANG KE ADM GOOGLE
#!C:/Perl/bin/perl.exe -w
use DBI;
use DBD::mysql;
open (OUT2, '>matching/StringGoogleVi.txt') or die "can't open";
open (OUT3, '>matching/StringGoogleSu.txt') or die "can't open";
open (OUT4, '>matching/StringGoogleDi.txt') or die "can't open";
open (OUT5, '>matching/StringGooglePr.txt') or die "can't open";
open (OUT, 'matching/Dokumen.txt') or die "can't open";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
$sqlVi = "SELECT upper(concat(id,' ^ ',ori_address,' , ',ori_vi,' , ',ori_su,' , ',ori_di,' , ',ori_pr,' ^ ',google_vi)) FROM $tb where match_vi = 'NOT MATCH' and flag_geocode != 'Q' order by id";
$sqlSu = "SELECT upper(concat(id,' ^ ',ori_address,' , ',ori_vi,' , ',ori_su,' , ',ori_di,' , ',ori_pr,' ^ ',google_su)) FROM $tb where match_su = 'NOT MATCH' and flag_geocode != 'Q' order by id";
$sqlDi = "SELECT upper(concat(id,' ^ ',ori_address,' , ',ori_vi,' , ',ori_su,' , ',ori_di,' , ',ori_pr,' ^ ',google_di)) FROM $tb where match_di = 'NOT MATCH' and flag_geocode != 'Q' order by id";
$sqlPr = "SELECT upper(concat(id,' ^ ',ori_address,' , ',ori_vi,' , ',ori_su,' , ',ori_di,' , ',ori_pr,' ^ ',google_pr)) FROM $tb where match_pr = 'NOT MATCH' and flag_geocode != 'Q' order by id";
$sthVi = $dbh->prepare($sqlVi);
$sthSu = $dbh->prepare($sqlSu);
$sthDi = $dbh->prepare($sqlDi);
$sthPr = $dbh->prepare($sqlPr);
$sthVi->execute or die "SQL Error: $DBI::errstr\n";
$sthSu->execute or die "SQL Error: $DBI::errstr\n";
$sthDi->execute or die "SQL Error: $DBI::errstr\n";
$sthPr->execute or die "SQL Error: $DBI::errstr\n";
while (@row1 = $sthVi->fetchrow_array) {
print OUT2 "@row1\n";
}
while (@row2 = $sthSu->fetchrow_array) {
print OUT3 "@row2\n";
}
while (@row3 = $sthDi->fetchrow_array) {
print OUT4 "@row3\n";
}
while (@row4 = $sthPr->fetchrow_array) {
print OUT5 "@row4\n";
}
}
close (OUT);
close (OUT2);
close (OUT3);
close (OUT4);
close (OUT5);
open(FILE2, ">>matching/StringGoogleVi.txt") or die "can't open";
open(FILE3, ">>matching/StringGoogleSu.txt") or die "can't open";
open(FILE4, ">>matching/StringGoogleDi.txt") or die "can't open";
open(FILE5, ">>matching/StringGooglePr.txt") or die "can't open";
print FILE2 "~ ";
print FILE3 "~ ";
print FILE4 "~ ";
print FILE5 "~ ";
close (FILE2);
close (FILE3);
close (FILE4);
close (FILE5);

#---- 16
#UNTUK MERUBAH SINGKATAN-SINGKATAN TERUTAMA SINGKATAN ADM
#!C:/Perl/bin/perl.exe -w
open(FILE, "matching/DB4.txt") or die "can't open";
open(FILE2, "matching/StringGoogleVi.txt") or die "can't open";
open (OUT, '>matching/StringGoogleVi1.txt') or die "can't open";
@aa = <FILE2>;
$aaa = "@aa";
foreach ($aaa =~ /\~ /) {
@listdata = split(/\~ /, $aaa);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
$listdata[$i] =~ s/[-]//g;
foreach $entitas(<FILE>) {
@lines = split(/,/, $entitas);
chomp @lines;
$a = $lines[0];
$b = $lines[1];
if ($listdata[$i] =~ / $a /) {
$listdata[$i] =~ s/ $a / $b /g;
}
}
if ($listdata[$i] =~ /DKI DKI JAKARTA|DKI JAKARTA BARAT|DKI JAKARTA TIMUR|DKI JAKARTA PUSAT|DKI JAKARTA UTARA|DKI JAKARTA SELATAN|DI DAERAH ISTIMEWA YOGYAKARTA|D I DAERAH ISTIMEWA YOGYAKARTA|POLDA ACEH|BATU PHAT|DPASAR|KELUNGKUNG| D E N P A S A R | PASR /) {
$listdata[$i] =~ s/DKI DKI JAKARTA/DKI JAKARTA/g;
$listdata[$i] =~ s/DKI JAKARTA BARAT/JAKARTA BARAT/g;
$listdata[$i] =~ s/DKI JAKARTA TIMUR/JAKARTA TIMUR/g;
$listdata[$i] =~ s/DKI JAKARTA PUSAT/JAKARTA PUSAT/g;
$listdata[$i] =~ s/DKI JAKARTA UTARA/JAKARTA UTARA/g;
$listdata[$i] =~ s/DKI JAKARTA SELATAN/JAKARTA SELATAN/g;
$listdata[$i] =~ s/DI DAERAH ISTIMEWA YOGYAKARTA/DAERAH ISTIMEWA YOGYAKARTA/g;
$listdata[$i] =~ s/D I DAERAH ISTIMEWA YOGYAKARTA/DAERAH ISTIMEWA YOGYAKARTA/g;
$listdata[$i] =~ s/POLDA ACEH/POLDA BANDA ACEH/g;
$listdata[$i] =~ s/BATU PHAT/BATU PHAT BARAT/g;
$listdata[$i] =~ s/BATU PHAT BARAT BARAT/BATU PHAT BARAT/g;
$listdata[$i] =~ s/BATU PHAT BARAT TIMUR/BATU PHAT TIMUR/g;
$listdata[$i] =~ s/DPASAR/DENPASAR/g;
$listdata[$i] =~ s/KELUNGKUNG/KLUNGKUNG/g;
$listdata[$i] =~ s/D E N P A S A R/DENPASAR/g;
$listdata[$i] =~ s/PASR/PASAR/g;
}
#mengubah format KOTA KOTA MEDAN menjadi KOTA MEDAN, DLL
if ($listdata[$i] =~ /TELUK KOTA MEDAN|TANJUNG KOTA MEDAN|TALANG KOTA MEDAN|SUKA KOTA MEDAN|SIMPANG KOTA KOTA MEDAN|SELAT TANJUNG KOTA MEDAN|RENAH KOTA MEDAN|PERKEBUNAN TANJUNG KOTA MEDAN|KOTA MEDAN TUNTUNGAN|KOTA MEDAN TIMUR|KOTA MEDAN TENGGARA|KOTA MEDAN TEMBUNG|KOTA MEDAN SUNGGAL|KOTA MEDAN SINEMBAH|KOTA MEDAN SERI RAMBAHAN|KOTA MEDAN SELAYANG|KOTA MEDAN SATRIA|KOTA MEDAN POLONIA|KOTA MEDAN PETISAH|KOTA MEDAN PERJUANGAN|KOTA MEDAN MARELAN|KOTA MEDAN MAIMUN|KOTA MEDAN LABUHAN|KOTA MEDAN KRIO|KOTA MEDAN KOTA BELAWAN|KOTA MEDAN KOTA|KOTA MEDAN JOHOR|KOTA MEDAN JAYA|KOTA MEDAN HELVETIA|KOTA MEDAN ESTATE|KOTA MEDAN DENAI|KOTA MEDAN DELI|KOTA MEDAN BARU|KOTA MEDAN BARAT|KOTA MEDAN AREA|KOTA MEDAN AMPLAS|KOTA KOTA MEDAN|KAMPUNG KOTA MEDAN|GUNUNG KOTA MEDAN/) {
$listdata[$i] =~ s/TELUK KOTA MEDAN/TELUK MEDAN/g;
$listdata[$i] =~ s/TANJUNG KOTA MEDAN/TANJUNG MEDAN/g;
$listdata[$i] =~ s/TALANG KOTA MEDAN/TALANG MEDAN/g;
$listdata[$i] =~ s/SUKA KOTA MEDAN/SUKA MEDAN/g;
$listdata[$i] =~ s/SIMPANG KOTA KOTA MEDAN/SIMPANG KOTA MEDAN/g;
$listdata[$i] =~ s/SELAT TANJUNG KOTA MEDAN/SELAT TANJUNG MEDAN/g;
$listdata[$i] =~ s/RENAH KOTA MEDAN/RENAH MEDAN/g;
$listdata[$i] =~ s/PERKEBUNAN TANJUNG KOTA MEDAN/PERKEBUNAN TANJUNG MEDAN/g;
$listdata[$i] =~ s/KOTA MEDAN TUNTUNGAN/MEDAN TUNTUNGAN/g;
$listdata[$i] =~ s/KOTA MEDAN TIMUR/MEDAN TIMUR/g;
$listdata[$i] =~ s/KOTA MEDAN TENGGARA/MEDAN TENGGARA/g;
$listdata[$i] =~ s/KOTA MEDAN TEMBUNG/MEDAN TEMBUNG/g;
$listdata[$i] =~ s/KOTA MEDAN SUNGGAL/MEDAN SUNGGAL/g;
$listdata[$i] =~ s/KOTA MEDAN SINEMBAH/MEDAN SINEMBAH/g;
$listdata[$i] =~ s/KOTA MEDAN SERI RAMBAHAN/MEDAN SERI RAMBAHAN/g;
$listdata[$i] =~ s/KOTA MEDAN SELAYANG/MEDAN SELAYANG/g;
$listdata[$i] =~ s/KOTA MEDAN SATRIA/MEDAN SATRIA/g;
$listdata[$i] =~ s/KOTA MEDAN POLONIA/MEDAN POLONIA/g;
$listdata[$i] =~ s/KOTA MEDAN PETISAH/MEDAN PETISAH/g;
$listdata[$i] =~ s/KOTA MEDAN PERJUANGAN/MEDAN PERJUANGAN/g;
$listdata[$i] =~ s/KOTA MEDAN MARELAN/MEDAN MARELAN/g;
$listdata[$i] =~ s/KOTA MEDAN MAIMUN/MEDAN MAIMUN/g;
$listdata[$i] =~ s/KOTA MEDAN LABUHAN/MEDAN LABUHAN/g;
$listdata[$i] =~ s/KOTA MEDAN KRIO/MEDAN KRIO/g;
$listdata[$i] =~ s/KOTA MEDAN KOTA BELAWAN/MEDAN KOTA BELAWAN/g;
$listdata[$i] =~ s/KOTA MEDAN KOTA/MEDAN KOTA/g;
$listdata[$i] =~ s/KOTA MEDAN JOHOR/MEDAN JOHOR/g;
$listdata[$i] =~ s/KOTA MEDAN JAYA/MEDAN JAYA/g;
$listdata[$i] =~ s/KOTA MEDAN HELVETIA/MEDAN HELVETIA/g;
$listdata[$i] =~ s/KOTA MEDAN ESTATE/MEDAN ESTATE/g;
$listdata[$i] =~ s/KOTA MEDAN DENAI/MEDAN DENAI/g;
$listdata[$i] =~ s/KOTA MEDAN DELI/MEDAN DELI/g;
$listdata[$i] =~ s/KOTA MEDAN BARU/MEDAN BARU/g;
$listdata[$i] =~ s/KOTA MEDAN BARAT/MEDAN BARAT/g;
$listdata[$i] =~ s/KOTA MEDAN AREA/MEDAN AREA/g;
$listdata[$i] =~ s/KOTA MEDAN AMPLAS/MEDAN AMPLAS/g;
$listdata[$i] =~ s/KOTA KOTA MEDAN/KOTA MEDAN/g;
$listdata[$i] =~ s/KAMPUNG KOTA MEDAN/KAMPUNG MEDAN/g;
$listdata[$i] =~ s/GUNUNG KOTA MEDAN/GUNUNG MEDAN/g;
}
if ($listdata[$i] =~ /TELUK KOTA BINJAI|TANJUNG KOTA BINJAI|SARING SUNGAI KOTA BINJAI|RAWANG KOTA BINJAI|PULAU KOTA BINJAI|PERADUAN KOTA BINJAI|PEKAN KOTA BINJAI|PADANG KOTA BINJAI|LUBUK KOTA BINJAI|KOTA KOTA BINJAI|KELURAHAN SUNGAI KOTA BINJAI|DARASAN KOTA BINJAI|KOTA BINJAI WANGI|KOTA BINJAI UTARA|KOTA BINJAI TIMUR|KOTA BINJAI TAPAN|KOTA BINJAI SERBANGAN|KOTA BINJAI SELATAN|KOTA BINJAI PUNGGAL|KOTA BINJAI PIRUA|KOTA BINJAI PEMANGKIH|KOTA BINJAI KOTA|KOTA BINJAI HULU|KOTA BINJAI HILIR|KOTA BINJAI ESTATE|KOTA BINJAI BARAT|KOTA BINJAI BAKUNG|KOTA BINJAI AGUNG|BANUA KOTA BINJAI/) {
$listdata[$i] =~ s/TELUK KOTA BINJAI/TELUK BINJAI/g;
$listdata[$i] =~ s/TANJUNG KOTA BINJAI/TANJUNG BINJAI/g;
$listdata[$i] =~ s/SARING SUNGAI KOTA BINJAI/SARING SUNGAI BINJAI/g;
$listdata[$i] =~ s/RAWANG KOTA BINJAI/RAWANG BINJAI/g;
$listdata[$i] =~ s/PULAU KOTA BINJAI/PULAU BINJAI/g;
$listdata[$i] =~ s/PERADUAN KOTA BINJAI/PERADUAN BINJAI/g;
$listdata[$i] =~ s/PEKAN KOTA BINJAI/PEKAN BINJAI/g;
$listdata[$i] =~ s/PADANG KOTA BINJAI/PADANG BINJAI/g;
$listdata[$i] =~ s/LUBUK KOTA BINJAI/LUBUK BINJAI/g;
$listdata[$i] =~ s/KOTA KOTA BINJAI/KOTA BINJAI/g;
$listdata[$i] =~ s/KELURAHAN SUNGAI KOTA BINJAI/KELURAHAN SUNGAI BINJAI/g;
$listdata[$i] =~ s/DARASAN KOTA BINJAI/DARASAN BINJAI/g;
$listdata[$i] =~ s/KOTA BINJAI WANGI/BINJAI WANGI/g;
$listdata[$i] =~ s/KOTA BINJAI UTARA/BINJAI UTARA/g;
$listdata[$i] =~ s/KOTA BINJAI TIMUR/BINJAI TIMUR/g;
$listdata[$i] =~ s/KOTA BINJAI TAPAN/BINJAI TAPAN/g;
$listdata[$i] =~ s/KOTA BINJAI SERBANGAN/BINJAI SERBANGAN/g;
$listdata[$i] =~ s/KOTA BINJAI SELATAN/BINJAI SELATAN/g;
$listdata[$i] =~ s/KOTA BINJAI PUNGGAL/BINJAI PUNGGAL/g;
$listdata[$i] =~ s/KOTA BINJAI PIRUA/BINJAI PIRUA/g;
$listdata[$i] =~ s/KOTA BINJAI PEMANGKIH/BINJAI PEMANGKIH/g;
$listdata[$i] =~ s/KOTA BINJAI KOTA/BINJAI KOTA/g;
$listdata[$i] =~ s/KOTA BINJAI HULU/BINJAI HULU/g;
$listdata[$i] =~ s/KOTA BINJAI HILIR/BINJAI HILIR/g;
$listdata[$i] =~ s/KOTA BINJAI ESTATE/BINJAI ESTATE/g;
$listdata[$i] =~ s/KOTA BINJAI BARAT/BINJAI BARAT/g;
$listdata[$i] =~ s/KOTA BINJAI BAKUNG/BINJAI BAKUNG/g;
$listdata[$i] =~ s/KOTA BINJAI AGUNG/BINJAI AGUNG/g;
$listdata[$i] =~ s/BANUA KOTA BINJAI/BANUA BINJAI/g;
}
$listdata[$i] =~ s/\s\n\s/\n/g;
$listdata[$i] =~ s/\n\s/\n/g;
print OUT $listdata[$i]."\n";
print OUT "~ ";
}
}
close (FILE);
close (FILE2);
close (OUT);
#-----#
open(FILE, "matching/DB4.txt") or die "can't open";
open(FILE2, "matching/StringGoogleSu.txt") or die "can't open";
open (OUT, '>matching/StringGoogleSu1.txt') or die "can't open";
@aa = <FILE2>;
$aaa = "@aa";
foreach ($aaa =~ /\~ /) {
@listdata = split(/\~ /, $aaa);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
$listdata[$i] =~ s/[-]//g;
foreach $entitas(<FILE>) {
@lines = split(/,/, $entitas);
chomp @lines;
$a = $lines[0];
$b = $lines[1];
if ($listdata[$i] =~ / $a /) {
$listdata[$i] =~ s/ $a / $b /g;
}
}
if ($listdata[$i] =~ /DKI DKI JAKARTA|DKI JAKARTA BARAT|DKI JAKARTA TIMUR|DKI JAKARTA PUSAT|DKI JAKARTA UTARA|DKI JAKARTA SELATAN|DI DAERAH ISTIMEWA YOGYAKARTA|D I DAERAH ISTIMEWA YOGYAKARTA|POLDA ACEH|BATU PHAT|DPASAR|KELUNGKUNG| D E N P A S A R | PASR /) {
$listdata[$i] =~ s/DKI DKI JAKARTA/DKI JAKARTA/g;
$listdata[$i] =~ s/DKI JAKARTA BARAT/JAKARTA BARAT/g;
$listdata[$i] =~ s/DKI JAKARTA TIMUR/JAKARTA TIMUR/g;
$listdata[$i] =~ s/DKI JAKARTA PUSAT/JAKARTA PUSAT/g;
$listdata[$i] =~ s/DKI JAKARTA UTARA/JAKARTA UTARA/g;
$listdata[$i] =~ s/DKI JAKARTA SELATAN/JAKARTA SELATAN/g;
$listdata[$i] =~ s/DI DAERAH ISTIMEWA YOGYAKARTA/DAERAH ISTIMEWA YOGYAKARTA/g;
$listdata[$i] =~ s/D I DAERAH ISTIMEWA YOGYAKARTA/DAERAH ISTIMEWA YOGYAKARTA/g;
$listdata[$i] =~ s/POLDA ACEH/POLDA BANDA ACEH/g;
$listdata[$i] =~ s/BATU PHAT/BATU PHAT BARAT/g;
$listdata[$i] =~ s/BATU PHAT BARAT BARAT/BATU PHAT BARAT/g;
$listdata[$i] =~ s/BATU PHAT BARAT TIMUR/BATU PHAT TIMUR/g;
$listdata[$i] =~ s/DPASAR/DENPASAR/g;
$listdata[$i] =~ s/KELUNGKUNG/KLUNGKUNG/g;
$listdata[$i] =~ s/D E N P A S A R/DENPASAR/g;
$listdata[$i] =~ s/PASR/PASAR/g;
}
#mengubah format KOTA KOTA MEDAN menjadi KOTA MEDAN, DLL
if ($listdata[$i] =~ /TELUK KOTA MEDAN|TANJUNG KOTA MEDAN|TALANG KOTA MEDAN|SUKA KOTA MEDAN|SIMPANG KOTA KOTA MEDAN|SELAT TANJUNG KOTA MEDAN|RENAH KOTA MEDAN|PERKEBUNAN TANJUNG KOTA MEDAN|KOTA MEDAN TUNTUNGAN|KOTA MEDAN TIMUR|KOTA MEDAN TENGGARA|KOTA MEDAN TEMBUNG|KOTA MEDAN SUNGGAL|KOTA MEDAN SINEMBAH|KOTA MEDAN SERI RAMBAHAN|KOTA MEDAN SELAYANG|KOTA MEDAN SATRIA|KOTA MEDAN POLONIA|KOTA MEDAN PETISAH|KOTA MEDAN PERJUANGAN|KOTA MEDAN MARELAN|KOTA MEDAN MAIMUN|KOTA MEDAN LABUHAN|KOTA MEDAN KRIO|KOTA MEDAN KOTA BELAWAN|KOTA MEDAN KOTA|KOTA MEDAN JOHOR|KOTA MEDAN JAYA|KOTA MEDAN HELVETIA|KOTA MEDAN ESTATE|KOTA MEDAN DENAI|KOTA MEDAN DELI|KOTA MEDAN BARU|KOTA MEDAN BARAT|KOTA MEDAN AREA|KOTA MEDAN AMPLAS|KOTA KOTA MEDAN|KAMPUNG KOTA MEDAN|GUNUNG KOTA MEDAN/) {
$listdata[$i] =~ s/TELUK KOTA MEDAN/TELUK MEDAN/g;
$listdata[$i] =~ s/TANJUNG KOTA MEDAN/TANJUNG MEDAN/g;
$listdata[$i] =~ s/TALANG KOTA MEDAN/TALANG MEDAN/g;
$listdata[$i] =~ s/SUKA KOTA MEDAN/SUKA MEDAN/g;
$listdata[$i] =~ s/SIMPANG KOTA KOTA MEDAN/SIMPANG KOTA MEDAN/g;
$listdata[$i] =~ s/SELAT TANJUNG KOTA MEDAN/SELAT TANJUNG MEDAN/g;
$listdata[$i] =~ s/RENAH KOTA MEDAN/RENAH MEDAN/g;
$listdata[$i] =~ s/PERKEBUNAN TANJUNG KOTA MEDAN/PERKEBUNAN TANJUNG MEDAN/g;
$listdata[$i] =~ s/KOTA MEDAN TUNTUNGAN/MEDAN TUNTUNGAN/g;
$listdata[$i] =~ s/KOTA MEDAN TIMUR/MEDAN TIMUR/g;
$listdata[$i] =~ s/KOTA MEDAN TENGGARA/MEDAN TENGGARA/g;
$listdata[$i] =~ s/KOTA MEDAN TEMBUNG/MEDAN TEMBUNG/g;
$listdata[$i] =~ s/KOTA MEDAN SUNGGAL/MEDAN SUNGGAL/g;
$listdata[$i] =~ s/KOTA MEDAN SINEMBAH/MEDAN SINEMBAH/g;
$listdata[$i] =~ s/KOTA MEDAN SERI RAMBAHAN/MEDAN SERI RAMBAHAN/g;
$listdata[$i] =~ s/KOTA MEDAN SELAYANG/MEDAN SELAYANG/g;
$listdata[$i] =~ s/KOTA MEDAN SATRIA/MEDAN SATRIA/g;
$listdata[$i] =~ s/KOTA MEDAN POLONIA/MEDAN POLONIA/g;
$listdata[$i] =~ s/KOTA MEDAN PETISAH/MEDAN PETISAH/g;
$listdata[$i] =~ s/KOTA MEDAN PERJUANGAN/MEDAN PERJUANGAN/g;
$listdata[$i] =~ s/KOTA MEDAN MARELAN/MEDAN MARELAN/g;
$listdata[$i] =~ s/KOTA MEDAN MAIMUN/MEDAN MAIMUN/g;
$listdata[$i] =~ s/KOTA MEDAN LABUHAN/MEDAN LABUHAN/g;
$listdata[$i] =~ s/KOTA MEDAN KRIO/MEDAN KRIO/g;
$listdata[$i] =~ s/KOTA MEDAN KOTA BELAWAN/MEDAN KOTA BELAWAN/g;
$listdata[$i] =~ s/KOTA MEDAN KOTA/MEDAN KOTA/g;
$listdata[$i] =~ s/KOTA MEDAN JOHOR/MEDAN JOHOR/g;
$listdata[$i] =~ s/KOTA MEDAN JAYA/MEDAN JAYA/g;
$listdata[$i] =~ s/KOTA MEDAN HELVETIA/MEDAN HELVETIA/g;
$listdata[$i] =~ s/KOTA MEDAN ESTATE/MEDAN ESTATE/g;
$listdata[$i] =~ s/KOTA MEDAN DENAI/MEDAN DENAI/g;
$listdata[$i] =~ s/KOTA MEDAN DELI/MEDAN DELI/g;
$listdata[$i] =~ s/KOTA MEDAN BARU/MEDAN BARU/g;
$listdata[$i] =~ s/KOTA MEDAN BARAT/MEDAN BARAT/g;
$listdata[$i] =~ s/KOTA MEDAN AREA/MEDAN AREA/g;
$listdata[$i] =~ s/KOTA MEDAN AMPLAS/MEDAN AMPLAS/g;
$listdata[$i] =~ s/KOTA KOTA MEDAN/KOTA MEDAN/g;
$listdata[$i] =~ s/KAMPUNG KOTA MEDAN/KAMPUNG MEDAN/g;
$listdata[$i] =~ s/GUNUNG KOTA MEDAN/GUNUNG MEDAN/g;
}
if ($listdata[$i] =~ /TELUK KOTA BINJAI|TANJUNG KOTA BINJAI|SARING SUNGAI KOTA BINJAI|RAWANG KOTA BINJAI|PULAU KOTA BINJAI|PERADUAN KOTA BINJAI|PEKAN KOTA BINJAI|PADANG KOTA BINJAI|LUBUK KOTA BINJAI|KOTA KOTA BINJAI|KELURAHAN SUNGAI KOTA BINJAI|DARASAN KOTA BINJAI|KOTA BINJAI WANGI|KOTA BINJAI UTARA|KOTA BINJAI TIMUR|KOTA BINJAI TAPAN|KOTA BINJAI SERBANGAN|KOTA BINJAI SELATAN|KOTA BINJAI PUNGGAL|KOTA BINJAI PIRUA|KOTA BINJAI PEMANGKIH|KOTA BINJAI KOTA|KOTA BINJAI HULU|KOTA BINJAI HILIR|KOTA BINJAI ESTATE|KOTA BINJAI BARAT|KOTA BINJAI BAKUNG|KOTA BINJAI AGUNG|BANUA KOTA BINJAI/) {
$listdata[$i] =~ s/TELUK KOTA BINJAI/TELUK BINJAI/g;
$listdata[$i] =~ s/TANJUNG KOTA BINJAI/TANJUNG BINJAI/g;
$listdata[$i] =~ s/SARING SUNGAI KOTA BINJAI/SARING SUNGAI BINJAI/g;
$listdata[$i] =~ s/RAWANG KOTA BINJAI/RAWANG BINJAI/g;
$listdata[$i] =~ s/PULAU KOTA BINJAI/PULAU BINJAI/g;
$listdata[$i] =~ s/PERADUAN KOTA BINJAI/PERADUAN BINJAI/g;
$listdata[$i] =~ s/PEKAN KOTA BINJAI/PEKAN BINJAI/g;
$listdata[$i] =~ s/PADANG KOTA BINJAI/PADANG BINJAI/g;
$listdata[$i] =~ s/LUBUK KOTA BINJAI/LUBUK BINJAI/g;
$listdata[$i] =~ s/KOTA KOTA BINJAI/KOTA BINJAI/g;
$listdata[$i] =~ s/KELURAHAN SUNGAI KOTA BINJAI/KELURAHAN SUNGAI BINJAI/g;
$listdata[$i] =~ s/DARASAN KOTA BINJAI/DARASAN BINJAI/g;
$listdata[$i] =~ s/KOTA BINJAI WANGI/BINJAI WANGI/g;
$listdata[$i] =~ s/KOTA BINJAI UTARA/BINJAI UTARA/g;
$listdata[$i] =~ s/KOTA BINJAI TIMUR/BINJAI TIMUR/g;
$listdata[$i] =~ s/KOTA BINJAI TAPAN/BINJAI TAPAN/g;
$listdata[$i] =~ s/KOTA BINJAI SERBANGAN/BINJAI SERBANGAN/g;
$listdata[$i] =~ s/KOTA BINJAI SELATAN/BINJAI SELATAN/g;
$listdata[$i] =~ s/KOTA BINJAI PUNGGAL/BINJAI PUNGGAL/g;
$listdata[$i] =~ s/KOTA BINJAI PIRUA/BINJAI PIRUA/g;
$listdata[$i] =~ s/KOTA BINJAI PEMANGKIH/BINJAI PEMANGKIH/g;
$listdata[$i] =~ s/KOTA BINJAI KOTA/BINJAI KOTA/g;
$listdata[$i] =~ s/KOTA BINJAI HULU/BINJAI HULU/g;
$listdata[$i] =~ s/KOTA BINJAI HILIR/BINJAI HILIR/g;
$listdata[$i] =~ s/KOTA BINJAI ESTATE/BINJAI ESTATE/g;
$listdata[$i] =~ s/KOTA BINJAI BARAT/BINJAI BARAT/g;
$listdata[$i] =~ s/KOTA BINJAI BAKUNG/BINJAI BAKUNG/g;
$listdata[$i] =~ s/KOTA BINJAI AGUNG/BINJAI AGUNG/g;
$listdata[$i] =~ s/BANUA KOTA BINJAI/BANUA BINJAI/g;
}
$listdata[$i] =~ s/\s\n\s/\n/g;
$listdata[$i] =~ s/\n\s/\n/g;
print OUT $listdata[$i]."\n";
print OUT "~ ";
}
}
close (FILE);
close (FILE2);
close (OUT);
#-----#
open(FILE, "matching/DB4.txt") or die "can't open";
open(FILE2, "matching/StringGoogleDi.txt") or die "can't open";
open (OUT, '>matching/StringGoogleDi1.txt') or die "can't open";
@aa = <FILE2>;
$aaa = "@aa";
foreach ($aaa =~ /\~ /) {
@listdata = split(/\~ /, $aaa);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
$listdata[$i] =~ s/[-]//g;
foreach $entitas(<FILE>) {
@lines = split(/,/, $entitas);
chomp @lines;
$a = $lines[0];
$b = $lines[1];
if ($listdata[$i] =~ / $a /) {
$listdata[$i] =~ s/ $a / $b /g;
}
}
if ($listdata[$i] =~ /DKI DKI JAKARTA|DKI JAKARTA BARAT|DKI JAKARTA TIMUR|DKI JAKARTA PUSAT|DKI JAKARTA UTARA|DKI JAKARTA SELATAN|DI DAERAH ISTIMEWA YOGYAKARTA|D I DAERAH ISTIMEWA YOGYAKARTA|POLDA ACEH|BATU PHAT|DPASAR|KELUNGKUNG| D E N P A S A R | PASR /) {
$listdata[$i] =~ s/DKI DKI JAKARTA/DKI JAKARTA/g;
$listdata[$i] =~ s/DKI JAKARTA BARAT/JAKARTA BARAT/g;
$listdata[$i] =~ s/DKI JAKARTA TIMUR/JAKARTA TIMUR/g;
$listdata[$i] =~ s/DKI JAKARTA PUSAT/JAKARTA PUSAT/g;
$listdata[$i] =~ s/DKI JAKARTA UTARA/JAKARTA UTARA/g;
$listdata[$i] =~ s/DKI JAKARTA SELATAN/JAKARTA SELATAN/g;
$listdata[$i] =~ s/DI DAERAH ISTIMEWA YOGYAKARTA/DAERAH ISTIMEWA YOGYAKARTA/g;
$listdata[$i] =~ s/D I DAERAH ISTIMEWA YOGYAKARTA/DAERAH ISTIMEWA YOGYAKARTA/g;
$listdata[$i] =~ s/POLDA ACEH/POLDA BANDA ACEH/g;
$listdata[$i] =~ s/BATU PHAT/BATU PHAT BARAT/g;
$listdata[$i] =~ s/BATU PHAT BARAT BARAT/BATU PHAT BARAT/g;
$listdata[$i] =~ s/BATU PHAT BARAT TIMUR/BATU PHAT TIMUR/g;
$listdata[$i] =~ s/DPASAR/DENPASAR/g;
$listdata[$i] =~ s/KELUNGKUNG/KLUNGKUNG/g;
$listdata[$i] =~ s/D E N P A S A R/DENPASAR/g;
$listdata[$i] =~ s/PASR/PASAR/g;
}
#mengubah format KOTA KOTA MEDAN menjadi KOTA MEDAN, DLL
if ($listdata[$i] =~ /TELUK KOTA MEDAN|TANJUNG KOTA MEDAN|TALANG KOTA MEDAN|SUKA KOTA MEDAN|SIMPANG KOTA KOTA MEDAN|SELAT TANJUNG KOTA MEDAN|RENAH KOTA MEDAN|PERKEBUNAN TANJUNG KOTA MEDAN|KOTA MEDAN TUNTUNGAN|KOTA MEDAN TIMUR|KOTA MEDAN TENGGARA|KOTA MEDAN TEMBUNG|KOTA MEDAN SUNGGAL|KOTA MEDAN SINEMBAH|KOTA MEDAN SERI RAMBAHAN|KOTA MEDAN SELAYANG|KOTA MEDAN SATRIA|KOTA MEDAN POLONIA|KOTA MEDAN PETISAH|KOTA MEDAN PERJUANGAN|KOTA MEDAN MARELAN|KOTA MEDAN MAIMUN|KOTA MEDAN LABUHAN|KOTA MEDAN KRIO|KOTA MEDAN KOTA BELAWAN|KOTA MEDAN KOTA|KOTA MEDAN JOHOR|KOTA MEDAN JAYA|KOTA MEDAN HELVETIA|KOTA MEDAN ESTATE|KOTA MEDAN DENAI|KOTA MEDAN DELI|KOTA MEDAN BARU|KOTA MEDAN BARAT|KOTA MEDAN AREA|KOTA MEDAN AMPLAS|KOTA KOTA MEDAN|KAMPUNG KOTA MEDAN|GUNUNG KOTA MEDAN/) {
$listdata[$i] =~ s/TELUK KOTA MEDAN/TELUK MEDAN/g;
$listdata[$i] =~ s/TANJUNG KOTA MEDAN/TANJUNG MEDAN/g;
$listdata[$i] =~ s/TALANG KOTA MEDAN/TALANG MEDAN/g;
$listdata[$i] =~ s/SUKA KOTA MEDAN/SUKA MEDAN/g;
$listdata[$i] =~ s/SIMPANG KOTA KOTA MEDAN/SIMPANG KOTA MEDAN/g;
$listdata[$i] =~ s/SELAT TANJUNG KOTA MEDAN/SELAT TANJUNG MEDAN/g;
$listdata[$i] =~ s/RENAH KOTA MEDAN/RENAH MEDAN/g;
$listdata[$i] =~ s/PERKEBUNAN TANJUNG KOTA MEDAN/PERKEBUNAN TANJUNG MEDAN/g;
$listdata[$i] =~ s/KOTA MEDAN TUNTUNGAN/MEDAN TUNTUNGAN/g;
$listdata[$i] =~ s/KOTA MEDAN TIMUR/MEDAN TIMUR/g;
$listdata[$i] =~ s/KOTA MEDAN TENGGARA/MEDAN TENGGARA/g;
$listdata[$i] =~ s/KOTA MEDAN TEMBUNG/MEDAN TEMBUNG/g;
$listdata[$i] =~ s/KOTA MEDAN SUNGGAL/MEDAN SUNGGAL/g;
$listdata[$i] =~ s/KOTA MEDAN SINEMBAH/MEDAN SINEMBAH/g;
$listdata[$i] =~ s/KOTA MEDAN SERI RAMBAHAN/MEDAN SERI RAMBAHAN/g;
$listdata[$i] =~ s/KOTA MEDAN SELAYANG/MEDAN SELAYANG/g;
$listdata[$i] =~ s/KOTA MEDAN SATRIA/MEDAN SATRIA/g;
$listdata[$i] =~ s/KOTA MEDAN POLONIA/MEDAN POLONIA/g;
$listdata[$i] =~ s/KOTA MEDAN PETISAH/MEDAN PETISAH/g;
$listdata[$i] =~ s/KOTA MEDAN PERJUANGAN/MEDAN PERJUANGAN/g;
$listdata[$i] =~ s/KOTA MEDAN MARELAN/MEDAN MARELAN/g;
$listdata[$i] =~ s/KOTA MEDAN MAIMUN/MEDAN MAIMUN/g;
$listdata[$i] =~ s/KOTA MEDAN LABUHAN/MEDAN LABUHAN/g;
$listdata[$i] =~ s/KOTA MEDAN KRIO/MEDAN KRIO/g;
$listdata[$i] =~ s/KOTA MEDAN KOTA BELAWAN/MEDAN KOTA BELAWAN/g;
$listdata[$i] =~ s/KOTA MEDAN KOTA/MEDAN KOTA/g;
$listdata[$i] =~ s/KOTA MEDAN JOHOR/MEDAN JOHOR/g;
$listdata[$i] =~ s/KOTA MEDAN JAYA/MEDAN JAYA/g;
$listdata[$i] =~ s/KOTA MEDAN HELVETIA/MEDAN HELVETIA/g;
$listdata[$i] =~ s/KOTA MEDAN ESTATE/MEDAN ESTATE/g;
$listdata[$i] =~ s/KOTA MEDAN DENAI/MEDAN DENAI/g;
$listdata[$i] =~ s/KOTA MEDAN DELI/MEDAN DELI/g;
$listdata[$i] =~ s/KOTA MEDAN BARU/MEDAN BARU/g;
$listdata[$i] =~ s/KOTA MEDAN BARAT/MEDAN BARAT/g;
$listdata[$i] =~ s/KOTA MEDAN AREA/MEDAN AREA/g;
$listdata[$i] =~ s/KOTA MEDAN AMPLAS/MEDAN AMPLAS/g;
$listdata[$i] =~ s/KOTA KOTA MEDAN/KOTA MEDAN/g;
$listdata[$i] =~ s/KAMPUNG KOTA MEDAN/KAMPUNG MEDAN/g;
$listdata[$i] =~ s/GUNUNG KOTA MEDAN/GUNUNG MEDAN/g;
}
if ($listdata[$i] =~ /TELUK KOTA BINJAI|TANJUNG KOTA BINJAI|SARING SUNGAI KOTA BINJAI|RAWANG KOTA BINJAI|PULAU KOTA BINJAI|PERADUAN KOTA BINJAI|PEKAN KOTA BINJAI|PADANG KOTA BINJAI|LUBUK KOTA BINJAI|KOTA KOTA BINJAI|KELURAHAN SUNGAI KOTA BINJAI|DARASAN KOTA BINJAI|KOTA BINJAI WANGI|KOTA BINJAI UTARA|KOTA BINJAI TIMUR|KOTA BINJAI TAPAN|KOTA BINJAI SERBANGAN|KOTA BINJAI SELATAN|KOTA BINJAI PUNGGAL|KOTA BINJAI PIRUA|KOTA BINJAI PEMANGKIH|KOTA BINJAI KOTA|KOTA BINJAI HULU|KOTA BINJAI HILIR|KOTA BINJAI ESTATE|KOTA BINJAI BARAT|KOTA BINJAI BAKUNG|KOTA BINJAI AGUNG|BANUA KOTA BINJAI/) {
$listdata[$i] =~ s/TELUK KOTA BINJAI/TELUK BINJAI/g;
$listdata[$i] =~ s/TANJUNG KOTA BINJAI/TANJUNG BINJAI/g;
$listdata[$i] =~ s/SARING SUNGAI KOTA BINJAI/SARING SUNGAI BINJAI/g;
$listdata[$i] =~ s/RAWANG KOTA BINJAI/RAWANG BINJAI/g;
$listdata[$i] =~ s/PULAU KOTA BINJAI/PULAU BINJAI/g;
$listdata[$i] =~ s/PERADUAN KOTA BINJAI/PERADUAN BINJAI/g;
$listdata[$i] =~ s/PEKAN KOTA BINJAI/PEKAN BINJAI/g;
$listdata[$i] =~ s/PADANG KOTA BINJAI/PADANG BINJAI/g;
$listdata[$i] =~ s/LUBUK KOTA BINJAI/LUBUK BINJAI/g;
$listdata[$i] =~ s/KOTA KOTA BINJAI/KOTA BINJAI/g;
$listdata[$i] =~ s/KELURAHAN SUNGAI KOTA BINJAI/KELURAHAN SUNGAI BINJAI/g;
$listdata[$i] =~ s/DARASAN KOTA BINJAI/DARASAN BINJAI/g;
$listdata[$i] =~ s/KOTA BINJAI WANGI/BINJAI WANGI/g;
$listdata[$i] =~ s/KOTA BINJAI UTARA/BINJAI UTARA/g;
$listdata[$i] =~ s/KOTA BINJAI TIMUR/BINJAI TIMUR/g;
$listdata[$i] =~ s/KOTA BINJAI TAPAN/BINJAI TAPAN/g;
$listdata[$i] =~ s/KOTA BINJAI SERBANGAN/BINJAI SERBANGAN/g;
$listdata[$i] =~ s/KOTA BINJAI SELATAN/BINJAI SELATAN/g;
$listdata[$i] =~ s/KOTA BINJAI PUNGGAL/BINJAI PUNGGAL/g;
$listdata[$i] =~ s/KOTA BINJAI PIRUA/BINJAI PIRUA/g;
$listdata[$i] =~ s/KOTA BINJAI PEMANGKIH/BINJAI PEMANGKIH/g;
$listdata[$i] =~ s/KOTA BINJAI KOTA/BINJAI KOTA/g;
$listdata[$i] =~ s/KOTA BINJAI HULU/BINJAI HULU/g;
$listdata[$i] =~ s/KOTA BINJAI HILIR/BINJAI HILIR/g;
$listdata[$i] =~ s/KOTA BINJAI ESTATE/BINJAI ESTATE/g;
$listdata[$i] =~ s/KOTA BINJAI BARAT/BINJAI BARAT/g;
$listdata[$i] =~ s/KOTA BINJAI BAKUNG/BINJAI BAKUNG/g;
$listdata[$i] =~ s/KOTA BINJAI AGUNG/BINJAI AGUNG/g;
$listdata[$i] =~ s/BANUA KOTA BINJAI/BANUA BINJAI/g;
}
$listdata[$i] =~ s/\s\n\s/\n/g;
$listdata[$i] =~ s/\n\s/\n/g;
print OUT $listdata[$i]."\n";
print OUT "~ ";
}
}
close (FILE);
close (FILE2);
close (OUT);
#-----#
open(FILE, "matching/DB4.txt") or die "can't open";
open(FILE2, "matching/StringGooglePr.txt") or die "can't open";
open (OUT, '>matching/StringGooglePr1.txt') or die "can't open";
@aa = <FILE2>;
$aaa = "@aa";
foreach ($aaa =~ /\~ /) {
@listdata = split(/\~ /, $aaa);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
$listdata[$i] =~ s/[-]//g;
foreach $entitas(<FILE>) {
@lines = split(/,/, $entitas);
chomp @lines;
$a = $lines[0];
$b = $lines[1];
if ($listdata[$i] =~ / $a /) {
$listdata[$i] =~ s/ $a / $b /g;
}
}
if ($listdata[$i] =~ /DKI DKI JAKARTA|DKI JAKARTA BARAT|DKI JAKARTA TIMUR|DKI JAKARTA PUSAT|DKI JAKARTA UTARA|DKI JAKARTA SELATAN|DI DAERAH ISTIMEWA YOGYAKARTA|D I DAERAH ISTIMEWA YOGYAKARTA|POLDA ACEH|BATU PHAT|DPASAR|KELUNGKUNG| D E N P A S A R | PASR /) {
$listdata[$i] =~ s/DKI DKI JAKARTA/DKI JAKARTA/g;
$listdata[$i] =~ s/DKI JAKARTA BARAT/JAKARTA BARAT/g;
$listdata[$i] =~ s/DKI JAKARTA TIMUR/JAKARTA TIMUR/g;
$listdata[$i] =~ s/DKI JAKARTA PUSAT/JAKARTA PUSAT/g;
$listdata[$i] =~ s/DKI JAKARTA UTARA/JAKARTA UTARA/g;
$listdata[$i] =~ s/DKI JAKARTA SELATAN/JAKARTA SELATAN/g;
$listdata[$i] =~ s/DI DAERAH ISTIMEWA YOGYAKARTA/DAERAH ISTIMEWA YOGYAKARTA/g;
$listdata[$i] =~ s/D I DAERAH ISTIMEWA YOGYAKARTA/DAERAH ISTIMEWA YOGYAKARTA/g;
$listdata[$i] =~ s/POLDA ACEH/POLDA BANDA ACEH/g;
$listdata[$i] =~ s/BATU PHAT/BATU PHAT BARAT/g;
$listdata[$i] =~ s/BATU PHAT BARAT BARAT/BATU PHAT BARAT/g;
$listdata[$i] =~ s/BATU PHAT BARAT TIMUR/BATU PHAT TIMUR/g;
$listdata[$i] =~ s/DPASAR/DENPASAR/g;
$listdata[$i] =~ s/KELUNGKUNG/KLUNGKUNG/g;
$listdata[$i] =~ s/D E N P A S A R/DENPASAR/g;
$listdata[$i] =~ s/PASR/PASAR/g;
}
#mengubah format KOTA KOTA MEDAN menjadi KOTA MEDAN, DLL
if ($listdata[$i] =~ /TELUK KOTA MEDAN|TANJUNG KOTA MEDAN|TALANG KOTA MEDAN|SUKA KOTA MEDAN|SIMPANG KOTA KOTA MEDAN|SELAT TANJUNG KOTA MEDAN|RENAH KOTA MEDAN|PERKEBUNAN TANJUNG KOTA MEDAN|KOTA MEDAN TUNTUNGAN|KOTA MEDAN TIMUR|KOTA MEDAN TENGGARA|KOTA MEDAN TEMBUNG|KOTA MEDAN SUNGGAL|KOTA MEDAN SINEMBAH|KOTA MEDAN SERI RAMBAHAN|KOTA MEDAN SELAYANG|KOTA MEDAN SATRIA|KOTA MEDAN POLONIA|KOTA MEDAN PETISAH|KOTA MEDAN PERJUANGAN|KOTA MEDAN MARELAN|KOTA MEDAN MAIMUN|KOTA MEDAN LABUHAN|KOTA MEDAN KRIO|KOTA MEDAN KOTA BELAWAN|KOTA MEDAN KOTA|KOTA MEDAN JOHOR|KOTA MEDAN JAYA|KOTA MEDAN HELVETIA|KOTA MEDAN ESTATE|KOTA MEDAN DENAI|KOTA MEDAN DELI|KOTA MEDAN BARU|KOTA MEDAN BARAT|KOTA MEDAN AREA|KOTA MEDAN AMPLAS|KOTA KOTA MEDAN|KAMPUNG KOTA MEDAN|GUNUNG KOTA MEDAN/) {
$listdata[$i] =~ s/TELUK KOTA MEDAN/TELUK MEDAN/g;
$listdata[$i] =~ s/TANJUNG KOTA MEDAN/TANJUNG MEDAN/g;
$listdata[$i] =~ s/TALANG KOTA MEDAN/TALANG MEDAN/g;
$listdata[$i] =~ s/SUKA KOTA MEDAN/SUKA MEDAN/g;
$listdata[$i] =~ s/SIMPANG KOTA KOTA MEDAN/SIMPANG KOTA MEDAN/g;
$listdata[$i] =~ s/SELAT TANJUNG KOTA MEDAN/SELAT TANJUNG MEDAN/g;
$listdata[$i] =~ s/RENAH KOTA MEDAN/RENAH MEDAN/g;
$listdata[$i] =~ s/PERKEBUNAN TANJUNG KOTA MEDAN/PERKEBUNAN TANJUNG MEDAN/g;
$listdata[$i] =~ s/KOTA MEDAN TUNTUNGAN/MEDAN TUNTUNGAN/g;
$listdata[$i] =~ s/KOTA MEDAN TIMUR/MEDAN TIMUR/g;
$listdata[$i] =~ s/KOTA MEDAN TENGGARA/MEDAN TENGGARA/g;
$listdata[$i] =~ s/KOTA MEDAN TEMBUNG/MEDAN TEMBUNG/g;
$listdata[$i] =~ s/KOTA MEDAN SUNGGAL/MEDAN SUNGGAL/g;
$listdata[$i] =~ s/KOTA MEDAN SINEMBAH/MEDAN SINEMBAH/g;
$listdata[$i] =~ s/KOTA MEDAN SERI RAMBAHAN/MEDAN SERI RAMBAHAN/g;
$listdata[$i] =~ s/KOTA MEDAN SELAYANG/MEDAN SELAYANG/g;
$listdata[$i] =~ s/KOTA MEDAN SATRIA/MEDAN SATRIA/g;
$listdata[$i] =~ s/KOTA MEDAN POLONIA/MEDAN POLONIA/g;
$listdata[$i] =~ s/KOTA MEDAN PETISAH/MEDAN PETISAH/g;
$listdata[$i] =~ s/KOTA MEDAN PERJUANGAN/MEDAN PERJUANGAN/g;
$listdata[$i] =~ s/KOTA MEDAN MARELAN/MEDAN MARELAN/g;
$listdata[$i] =~ s/KOTA MEDAN MAIMUN/MEDAN MAIMUN/g;
$listdata[$i] =~ s/KOTA MEDAN LABUHAN/MEDAN LABUHAN/g;
$listdata[$i] =~ s/KOTA MEDAN KRIO/MEDAN KRIO/g;
$listdata[$i] =~ s/KOTA MEDAN KOTA BELAWAN/MEDAN KOTA BELAWAN/g;
$listdata[$i] =~ s/KOTA MEDAN KOTA/MEDAN KOTA/g;
$listdata[$i] =~ s/KOTA MEDAN JOHOR/MEDAN JOHOR/g;
$listdata[$i] =~ s/KOTA MEDAN JAYA/MEDAN JAYA/g;
$listdata[$i] =~ s/KOTA MEDAN HELVETIA/MEDAN HELVETIA/g;
$listdata[$i] =~ s/KOTA MEDAN ESTATE/MEDAN ESTATE/g;
$listdata[$i] =~ s/KOTA MEDAN DENAI/MEDAN DENAI/g;
$listdata[$i] =~ s/KOTA MEDAN DELI/MEDAN DELI/g;
$listdata[$i] =~ s/KOTA MEDAN BARU/MEDAN BARU/g;
$listdata[$i] =~ s/KOTA MEDAN BARAT/MEDAN BARAT/g;
$listdata[$i] =~ s/KOTA MEDAN AREA/MEDAN AREA/g;
$listdata[$i] =~ s/KOTA MEDAN AMPLAS/MEDAN AMPLAS/g;
$listdata[$i] =~ s/KOTA KOTA MEDAN/KOTA MEDAN/g;
$listdata[$i] =~ s/KAMPUNG KOTA MEDAN/KAMPUNG MEDAN/g;
$listdata[$i] =~ s/GUNUNG KOTA MEDAN/GUNUNG MEDAN/g;
}
if ($listdata[$i] =~ /TELUK KOTA BINJAI|TANJUNG KOTA BINJAI|SARING SUNGAI KOTA BINJAI|RAWANG KOTA BINJAI|PULAU KOTA BINJAI|PERADUAN KOTA BINJAI|PEKAN KOTA BINJAI|PADANG KOTA BINJAI|LUBUK KOTA BINJAI|KOTA KOTA BINJAI|KELURAHAN SUNGAI KOTA BINJAI|DARASAN KOTA BINJAI|KOTA BINJAI WANGI|KOTA BINJAI UTARA|KOTA BINJAI TIMUR|KOTA BINJAI TAPAN|KOTA BINJAI SERBANGAN|KOTA BINJAI SELATAN|KOTA BINJAI PUNGGAL|KOTA BINJAI PIRUA|KOTA BINJAI PEMANGKIH|KOTA BINJAI KOTA|KOTA BINJAI HULU|KOTA BINJAI HILIR|KOTA BINJAI ESTATE|KOTA BINJAI BARAT|KOTA BINJAI BAKUNG|KOTA BINJAI AGUNG|BANUA KOTA BINJAI/) {
$listdata[$i] =~ s/TELUK KOTA BINJAI/TELUK BINJAI/g;
$listdata[$i] =~ s/TANJUNG KOTA BINJAI/TANJUNG BINJAI/g;
$listdata[$i] =~ s/SARING SUNGAI KOTA BINJAI/SARING SUNGAI BINJAI/g;
$listdata[$i] =~ s/RAWANG KOTA BINJAI/RAWANG BINJAI/g;
$listdata[$i] =~ s/PULAU KOTA BINJAI/PULAU BINJAI/g;
$listdata[$i] =~ s/PERADUAN KOTA BINJAI/PERADUAN BINJAI/g;
$listdata[$i] =~ s/PEKAN KOTA BINJAI/PEKAN BINJAI/g;
$listdata[$i] =~ s/PADANG KOTA BINJAI/PADANG BINJAI/g;
$listdata[$i] =~ s/LUBUK KOTA BINJAI/LUBUK BINJAI/g;
$listdata[$i] =~ s/KOTA KOTA BINJAI/KOTA BINJAI/g;
$listdata[$i] =~ s/KELURAHAN SUNGAI KOTA BINJAI/KELURAHAN SUNGAI BINJAI/g;
$listdata[$i] =~ s/DARASAN KOTA BINJAI/DARASAN BINJAI/g;
$listdata[$i] =~ s/KOTA BINJAI WANGI/BINJAI WANGI/g;
$listdata[$i] =~ s/KOTA BINJAI UTARA/BINJAI UTARA/g;
$listdata[$i] =~ s/KOTA BINJAI TIMUR/BINJAI TIMUR/g;
$listdata[$i] =~ s/KOTA BINJAI TAPAN/BINJAI TAPAN/g;
$listdata[$i] =~ s/KOTA BINJAI SERBANGAN/BINJAI SERBANGAN/g;
$listdata[$i] =~ s/KOTA BINJAI SELATAN/BINJAI SELATAN/g;
$listdata[$i] =~ s/KOTA BINJAI PUNGGAL/BINJAI PUNGGAL/g;
$listdata[$i] =~ s/KOTA BINJAI PIRUA/BINJAI PIRUA/g;
$listdata[$i] =~ s/KOTA BINJAI PEMANGKIH/BINJAI PEMANGKIH/g;
$listdata[$i] =~ s/KOTA BINJAI KOTA/BINJAI KOTA/g;
$listdata[$i] =~ s/KOTA BINJAI HULU/BINJAI HULU/g;
$listdata[$i] =~ s/KOTA BINJAI HILIR/BINJAI HILIR/g;
$listdata[$i] =~ s/KOTA BINJAI ESTATE/BINJAI ESTATE/g;
$listdata[$i] =~ s/KOTA BINJAI BARAT/BINJAI BARAT/g;
$listdata[$i] =~ s/KOTA BINJAI BAKUNG/BINJAI BAKUNG/g;
$listdata[$i] =~ s/KOTA BINJAI AGUNG/BINJAI AGUNG/g;
$listdata[$i] =~ s/BANUA KOTA BINJAI/BANUA BINJAI/g;
}
$listdata[$i] =~ s/\s\n\s/\n/g;
$listdata[$i] =~ s/\n\s/\n/g;
print OUT $listdata[$i]."\n";
print OUT "~ ";
}
}
close (FILE);
close (FILE2);
close (OUT);

#---- 17
#UNTUK MENGHAPUS SPASI DAN SIMBOL2 TIDAK PENTING SERTA MERAPIKAN ISI FILE
#!C:/Perl/bin/perl.exe -w
open(FILE, "matching/StringGoogleVi1.txt") or die "can't open";
open(OUT, ">matching/StringGoogleVi2.txt") or die "can't open";
foreach $entitas(<FILE>) {
@listdata = split(/\~ /, $entitas);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
foreach ($listdata[$i] =~ /\^/) {
@listdata2 = split(/\^/, $listdata[$i]);
$id = $listdata2[0];
$add = $listdata2[1];
$kel = $listdata2[2];
$add =~ s/\s//g;
$add =~ s/[-]//g;
$add =~ s/\,\,\,\,/\,/g;
$add =~ s/\,\,\,/\,/g;
$add =~ s/\,\,/\,/g;
$kel =~ s/\s//g;
$kel =~ s/[-]//g;
print OUT $id."^".$add."^".$kel."\n";
}
}
}
close (FILE);
close (OUT);
open(FILE, "matching/StringGoogleSu1.txt") or die "can't open";
open(OUT, ">matching/StringGoogleSu2.txt") or die "can't open";
foreach $entitas(<FILE>) {
@listdata = split(/\~ /, $entitas);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
foreach ($listdata[$i] =~ /\^/) {
@listdata2 = split(/\^/, $listdata[$i]);
$id = $listdata2[0];
$add = $listdata2[1];
$kel = $listdata2[2];
$add =~ s/\s//g;
$add =~ s/[-]//g;
$add =~ s/\,\,\,\,/\,/g;
$add =~ s/\,\,\,/\,/g;
$add =~ s/\,\,/\,/g;
$kel =~ s/\s//g;
$kel =~ s/[-]//g;
print OUT $id."^".$add."^".$kel."\n";
}
}
}
close (FILE);
close (OUT);
open(FILE, "matching/StringGoogleDi1.txt") or die "can't open";
open(OUT, ">matching/StringGoogleDi2.txt") or die "can't open";
foreach $entitas(<FILE>) {
@listdata = split(/\~ /, $entitas);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
foreach ($listdata[$i] =~ /\^/) {
@listdata2 = split(/\^/, $listdata[$i]);
$id = $listdata2[0];
$add = $listdata2[1];
$kel = $listdata2[2];
$add =~ s/\s//g;
$add =~ s/[-]//g;
$add =~ s/\,\,\,\,/\,/g;
$add =~ s/\,\,\,/\,/g;
$add =~ s/\,\,/\,/g;
$kel =~ s/\s//g;
$kel =~ s/[-]//g;
print OUT $id."^".$add."^".$kel."\n";
}
}
}
close (FILE);
close (OUT);
open(FILE, "matching/StringGooglePr1.txt") or die "can't open";
open(OUT, ">matching/StringGooglePr2.txt") or die "can't open";
foreach $entitas(<FILE>) {
@listdata = split(/\~ /, $entitas);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
foreach ($listdata[$i] =~ /\^/) {
@listdata2 = split(/\^/, $listdata[$i]);
$id = $listdata2[0];
$add = $listdata2[1];
$kel = $listdata2[2];
$add =~ s/\s//g;
$add =~ s/[-]//g;
$add =~ s/\,\,\,\,/\,/g;
$add =~ s/\,\,\,/\,/g;
$add =~ s/\,\,/\,/g;
$kel =~ s/\s//g;
$kel =~ s/[-]//g;
print OUT $id."^".$add."^".$kel."\n";
}
}
}
close (FILE);
close (OUT);

#---- 18
#UNTUK MELAKUKAN PROSES MATCHING ADM UNTUK SETIAP LEVEL ADM
#!C:/Perl/bin/perl.exe -w
open(OUT1, "matching/StringGoogleVi2.txt") or die "can't open";
open(OUT2, ">matching/StringGoogleKel.txt") or die "can't open";
foreach $entitas(<OUT1>) {
@listdata2 = split(/\^/, $entitas);
$id = $listdata2[0];
$add = $listdata2[1];
$kel = $listdata2[2];
$kel =~ s/\n//g;
if ($add =~ $kel) {
print OUT2 $id." ^ ".$kel." ^ MATCH\n";
}
elsif ($add !~ $kel) {
print OUT2 $id." ^ ".$kel." ^ NOT MATCH\n";
}
}
close (OUT1);
close (OUT2);
open(OUT1, "matching/StringGoogleSu2.txt") or die "can't open";
open(OUT2, ">matching/StringGoogleKec.txt") or die "can't open";
foreach $entitas(<OUT1>) {
@listdata2 = split(/\^/, $entitas);
$id = $listdata2[0];
$add = $listdata2[1];
$kel = $listdata2[2];
$kel =~ s/\n//g;
if ($add =~ $kel) {
print OUT2 $id." ^ ".$kel." ^ MATCH\n";
}
elsif ($add !~ $kel) {
print OUT2 $id." ^ ".$kel." ^ NOT MATCH\n";
}
}
close (OUT1);
close (OUT2);
open(OUT1, "matching/StringGoogleDi2.txt") or die "can't open";
open(OUT2, ">matching/StringGoogleKab.txt") or die "can't open";
foreach $entitas(<OUT1>) {
@listdata2 = split(/\^/, $entitas);
$id = $listdata2[0];
$add = $listdata2[1];
$kel = $listdata2[2];
$kel =~ s/\n//g;
if ($add =~ $kel) {
print OUT2 $id." ^ ".$kel." ^ MATCH\n";
}
elsif ($add !~ $kel) {
print OUT2 $id." ^ ".$kel." ^ NOT MATCH\n";
}
}
close (OUT1);
close (OUT2);
open(OUT1, "matching/StringGooglePr2.txt") or die "can't open";
open(OUT2, ">matching/StringGoogleProv.txt") or die "can't open";
foreach $entitas(<OUT1>) {
@listdata2 = split(/\^/, $entitas);
$id = $listdata2[0];
$add = $listdata2[1];
$kel = $listdata2[2];
$kel =~ s/\n//g;
if ($add =~ $kel) {
print OUT2 $id." ^ ".$kel." ^ MATCH\n";
}
elsif ($add !~ $kel) {
print OUT2 $id." ^ ".$kel." ^ NOT MATCH\n";
}
}
close (OUT1);
close (OUT2);

#---- 19
#UNTUK TRUNCATE TABLE MATCHING_JALAN SEBELUM DIINSERT VALUE DAN IMPORT DATA KE DB YANG DIGUNAKAN
#!/usr/bin/perl -w
use DBI;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
open (OUT2, 'matching/DokumenMatchAdm.txt') or die "can't open";
@q = <OUT2>;
$qq = "@q";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "truncate $qq";
$sth = $dbh->prepare($sql);
$sth->execute or die "SQL Error: $DBI::errstr\n";
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
close (OUT);
close (OUT2);
use DBI;
open (OUT2, 'matching/StringGoogleKel.txt') or die "can't open";
open (OUT3, 'matching/DokumenMatchAdm.txt') or die "can't open";
@q = <OUT3>;
$qq = "@q";
foreach $aaa(<OUT2>) {
@lines6 = split(/\s\^ /, $aaa);
$a6 = $lines6[0];
$b6 = $lines6[1];
$c6 = $lines6[2];
if ($c6 =~ /\n/) {
$c6 =~ s/\n//g;
}
$user = "gis";
$pw = "Gis123.>";
$dsn = 'dbi:Pg:dbname=db_engine_geocode;host=192.168.5.11;port=5432';
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "insert into $qq(id, match_vi) values (?,?)";
$sth = $dbh->prepare($sql);
$sth->execute($a6,$c6) or die "SQL Error: $DBI::errstr\n";
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
close (OUT2);
close (OUT3);
use DBI;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
open (OUT2, 'matching/DokumenMatchAdm.txt') or die "can't open";
@q = <OUT2>;
$qq = "@q";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "update $tb set match_vi = ? where id = ?";
$sth = $dbh->prepare($sql);
$sql2 = "select a.id, a.match_vi from $qq as a left join $tb as b on a.id = b.id order by a.id";
$sth2 = $dbh->prepare($sql2);
$sth2->execute;
while (@data = $sth2->fetchrow_array()) {
    my $id = $data[0];
    my $matchvi = $data[1];
    $sth->execute($matchvi, $id);
    $sth->finish;
}
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
$sth2->finish;
close (OUT);
close (OUT2);
#-----#
use DBI;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
open (OUT2, 'matching/DokumenMatchAdm.txt') or die "can't open";
@q = <OUT2>;
$qq = "@q";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "truncate $qq";
$sth = $dbh->prepare($sql);
$sth->execute or die "SQL Error: $DBI::errstr\n";
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
close (OUT);
close (OUT2);
use DBI;
open (OUT2, 'matching/StringGoogleKec.txt') or die "can't open";
open (OUT3, 'matching/DokumenMatchAdm.txt') or die "can't open";
@q = <OUT3>;
$qq = "@q";
foreach $aaa(<OUT2>) {
@lines6 = split(/\s\^ /, $aaa);
$a6 = $lines6[0];
$b6 = $lines6[1];
$c6 = $lines6[2];
if ($c6 =~ /\n/) {
$c6 =~ s/\n//g;
}
$user = "gis";
$pw = "Gis123.>";
$dsn = 'dbi:Pg:dbname=db_engine_geocode;host=192.168.5.11;port=5432';
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "insert into $qq(id, match_su) values (?,?)";
$sth = $dbh->prepare($sql);
$sth->execute($a6,$c6) or die "SQL Error: $DBI::errstr\n";
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
close (OUT2);
close (OUT3);
use DBI;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
open (OUT2, 'matching/DokumenMatchAdm.txt') or die "can't open";
@q = <OUT2>;
$qq = "@q";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "update $tb set match_su = ? where id = ?";
$sth = $dbh->prepare($sql);
$sql2 = "select a.id, a.match_su from $qq as a left join $tb as b on a.id = b.id order by a.id";
$sth2 = $dbh->prepare($sql2);
$sth2->execute;
while (@data = $sth2->fetchrow_array()) {
    my $id = $data[0];
    my $matchsu = $data[1];
    $sth->execute($matchsu, $id);
    $sth->finish;
}
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
$sth2->finish;
close (OUT);
close (OUT2);
#-----#
use DBI;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
open (OUT2, 'matching/DokumenMatchAdm.txt') or die "can't open";
@q = <OUT2>;
$qq ="@q";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "truncate $qq";
$sth = $dbh->prepare($sql);
$sth->execute or die "SQL Error: $DBI::errstr\n";
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
close (OUT);
close (OUT2);
use DBI;
open (OUT2, 'matching/StringGoogleKab.txt') or die "can't open";
open (OUT3, 'matching/DokumenMatchAdm.txt') or die "can't open";
@q = <OUT3>;
$qq ="@q";
foreach $aaa(<OUT2>) {
@lines6 = split(/\s\^ /, $aaa);
$a6 = $lines6[0];
$b6 = $lines6[1];
$c6 = $lines6[2];
if ($c6 =~ /\n/) {
$c6 =~ s/\n//g;
}
$user = "gis";
$pw = "Gis123.>";
$dsn = 'dbi:Pg:dbname=db_engine_geocode;host=192.168.5.11;port=5432';
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "insert into $qq(id, match_di) values (?,?)";
$sth = $dbh->prepare($sql);
$sth->execute($a6,$c6) or die "SQL Error: $DBI::errstr\n";
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
close (OUT2);
close (OUT3);
use DBI;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
open (OUT2, 'matching/DokumenMatchAdm.txt') or die "can't open";
@q = <OUT2>;
$qq ="@q";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "update $tb set match_di = ? where id = ?";
$sth = $dbh->prepare($sql);
$sql2 = "select a.id, a.match_di from $qq as a left join $tb as b on a.id = b.id order by a.id";
$sth2 = $dbh->prepare($sql2);
$sth2->execute;
while (@data = $sth2->fetchrow_array()) {
    my $id = $data[0];
    my $matchdi = $data[1];
    $sth->execute($matchdi, $id);
    $sth->finish;
}
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
$sth2->finish;
close (OUT);
close (OUT2);
#-----#
use DBI;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
open (OUT2, 'matching/DokumenMatchAdm.txt') or die "can't open";
@q = <OUT2>;
$qq ="@q";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "truncate $qq";
$sth = $dbh->prepare($sql);
$sth->execute or die "SQL Error: $DBI::errstr\n";
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
close (OUT);
close (OUT2);
use DBI;
open (OUT2, 'matching/StringGoogleProv.txt') or die "can't open";
open (OUT3, 'matching/DokumenMatchAdm.txt') or die "can't open";
@q = <OUT3>;
$qq ="@q";
foreach $aaa(<OUT2>) {
@lines6 = split(/\s\^ /, $aaa);
$a6 = $lines6[0];
$b6 = $lines6[1];
$c6 = $lines6[2];
if ($c6 =~ /\n/) {
$c6 =~ s/\n//g;
}
$user = "gis";
$pw = "Gis123.>";
$dsn = 'dbi:Pg:dbname=db_engine_geocode;host=192.168.5.11;port=5432';
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "insert into $qq(id, match_pr) values (?,?)";
$sth = $dbh->prepare($sql);
$sth->execute($a6,$c6) or die "SQL Error: $DBI::errstr\n";
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
close (OUT2);
close (OUT3);
use DBI;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
open (OUT2, 'matching/DokumenMatchAdm.txt') or die "can't open";
@q = <OUT2>;
$qq ="@q";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "update $tb set match_pr = ? where id = ?";
$sth = $dbh->prepare($sql);
$sql2 = "select a.id, a.match_pr from $qq as a left join $tb as b on a.id = b.id order by a.id";
$sth2 = $dbh->prepare($sql2);
$sth2->execute;
while (@data = $sth2->fetchrow_array()) {
    my $id = $data[0];
    my $matchpr = $data[1];
    $sth->execute($matchpr, $id);
    $sth->finish;
}
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
$sth2->finish;
close (OUT);
close (OUT2);

#---- 20
#UNTUK MENARIK DATA YANG DIBUTUHKAN DARI DATABASE (ori_address dan adm)
#SETELAH MENARIK DATA, MAKA DATA YANG ADA AKAN DIUBAH FORMATNYA SESUAI DENGAN YANG DIGUNAKAN PADA PROSES SELANJUTNYA
#!C:/Perl/bin/perl.exe -w
use DBI;
use DBD::mysql;
open (OUT, '>matching/StringKodepos1.txt') or die "can't open";
open (OUT2, 'matching/Dokumen.txt') or die "can't open";
foreach $aaa (<OUT2>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
$sth = $dbh->prepare(qq{SELECT upper(concat(id,' ^ ',ori_address,' , ',ori_vi,', ',ori_su,', ',ori_di,', ',ori_pr,' ^ ',adm_vi,', ',adm_su,', ',adm_di,', ',adm_pr,' ; ')) FROM $tb where match_vi = 'NOT MATCH' and match_su = 'NOT MATCH' and match_di = 'NOT MATCH' and match_pr = 'NOT MATCH' and flag_geocode != 'Q' order by id});
$sth->execute or die "SQL Error: $DBI::errstr\n";
while (@row = $sth->fetchrow_array) {
print OUT "@row\n";
}
}
print OUT "~ ";
close (OUT2);
close (OUT);

#---- 20a
#UNTUK MERUBAH SINGKATAN-SINGKATAN TERUTAMA SINGKATAN ADM
#!C:/Perl/bin/perl.exe -w
open(FILE, "matching/DB6.txt") or die "can't open";
open(FILE2, "matching/StringKodepos1.txt") or die "can't open";
open (OUT, '>matching/StringKodepos1a.txt') or die "can't open";
@aa = <FILE2>;
$aaa = "@aa";
foreach ($aaa =~ /\~ /) {
@listdata = split(/\~ /, $aaa);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
$listdata[$i] =~ s/[-]//g;
foreach $entitas(<FILE>) {
@lines = split(/,/, $entitas);
chomp @lines;
$a = $lines[0];
$b = $lines[1];
if ($listdata[$i] =~ / $a /) {
$listdata[$i] =~ s/ $a / $b /g;
}
}
if ($listdata[$i] =~ /DKI DKI JAKARTA|DKI JAKARTA BARAT|DKI JAKARTA TIMUR|DKI JAKARTA PUSAT|DKI JAKARTA UTARA|DKI JAKARTA SELATAN|DI DAERAH ISTIMEWA YOGYAKARTA|D I DAERAH ISTIMEWA YOGYAKARTA|POLDA ACEH|BATU PHAT|DPASAR|KELUNGKUNG| D E N P A S A R | PASR /) {
$listdata[$i] =~ s/DKI DKI JAKARTA/DKI JAKARTA/g;
$listdata[$i] =~ s/DKI JAKARTA BARAT/JAKARTA BARAT/g;
$listdata[$i] =~ s/DKI JAKARTA TIMUR/JAKARTA TIMUR/g;
$listdata[$i] =~ s/DKI JAKARTA PUSAT/JAKARTA PUSAT/g;
$listdata[$i] =~ s/DKI JAKARTA UTARA/JAKARTA UTARA/g;
$listdata[$i] =~ s/DKI JAKARTA SELATAN/JAKARTA SELATAN/g;
$listdata[$i] =~ s/DI DAERAH ISTIMEWA YOGYAKARTA/DAERAH ISTIMEWA YOGYAKARTA/g;
$listdata[$i] =~ s/D I DAERAH ISTIMEWA YOGYAKARTA/DAERAH ISTIMEWA YOGYAKARTA/g;
$listdata[$i] =~ s/POLDA ACEH/POLDA BANDA ACEH/g;
$listdata[$i] =~ s/BATU PHAT/BATU PHAT BARAT/g;
$listdata[$i] =~ s/BATU PHAT BARAT BARAT/BATU PHAT BARAT/g;
$listdata[$i] =~ s/BATU PHAT BARAT TIMUR/BATU PHAT TIMUR/g;
$listdata[$i] =~ s/DPASAR/DENPASAR/g;
$listdata[$i] =~ s/KELUNGKUNG/KLUNGKUNG/g;
$listdata[$i] =~ s/D E N P A S A R/DENPASAR/g;
$listdata[$i] =~ s/PASR/PASAR/g;
}
#mengubah format KOTA KOTA MEDAN menjadi KOTA MEDAN, DLL
if ($listdata[$i] =~ /TELUK KOTA MEDAN|TANJUNG KOTA MEDAN|TALANG KOTA MEDAN|SUKA KOTA MEDAN|SIMPANG KOTA KOTA MEDAN|SELAT TANJUNG KOTA MEDAN|RENAH KOTA MEDAN|PERKEBUNAN TANJUNG KOTA MEDAN|KOTA MEDAN TUNTUNGAN|KOTA MEDAN TIMUR|KOTA MEDAN TENGGARA|KOTA MEDAN TEMBUNG|KOTA MEDAN SUNGGAL|KOTA MEDAN SINEMBAH|KOTA MEDAN SERI RAMBAHAN|KOTA MEDAN SELAYANG|KOTA MEDAN SATRIA|KOTA MEDAN POLONIA|KOTA MEDAN PETISAH|KOTA MEDAN PERJUANGAN|KOTA MEDAN MARELAN|KOTA MEDAN MAIMUN|KOTA MEDAN LABUHAN|KOTA MEDAN KRIO|KOTA MEDAN KOTA BELAWAN|KOTA MEDAN KOTA|KOTA MEDAN JOHOR|KOTA MEDAN JAYA|KOTA MEDAN HELVETIA|KOTA MEDAN ESTATE|KOTA MEDAN DENAI|KOTA MEDAN DELI|KOTA MEDAN BARU|KOTA MEDAN BARAT|KOTA MEDAN AREA|KOTA MEDAN AMPLAS|KOTA KOTA MEDAN|KAMPUNG KOTA MEDAN|GUNUNG KOTA MEDAN/) {
$listdata[$i] =~ s/TELUK KOTA MEDAN/TELUK MEDAN/g;
$listdata[$i] =~ s/TANJUNG KOTA MEDAN/TANJUNG MEDAN/g;
$listdata[$i] =~ s/TALANG KOTA MEDAN/TALANG MEDAN/g;
$listdata[$i] =~ s/SUKA KOTA MEDAN/SUKA MEDAN/g;
$listdata[$i] =~ s/SIMPANG KOTA KOTA MEDAN/SIMPANG KOTA MEDAN/g;
$listdata[$i] =~ s/SELAT TANJUNG KOTA MEDAN/SELAT TANJUNG MEDAN/g;
$listdata[$i] =~ s/RENAH KOTA MEDAN/RENAH MEDAN/g;
$listdata[$i] =~ s/PERKEBUNAN TANJUNG KOTA MEDAN/PERKEBUNAN TANJUNG MEDAN/g;
$listdata[$i] =~ s/KOTA MEDAN TUNTUNGAN/MEDAN TUNTUNGAN/g;
$listdata[$i] =~ s/KOTA MEDAN TIMUR/MEDAN TIMUR/g;
$listdata[$i] =~ s/KOTA MEDAN TENGGARA/MEDAN TENGGARA/g;
$listdata[$i] =~ s/KOTA MEDAN TEMBUNG/MEDAN TEMBUNG/g;
$listdata[$i] =~ s/KOTA MEDAN SUNGGAL/MEDAN SUNGGAL/g;
$listdata[$i] =~ s/KOTA MEDAN SINEMBAH/MEDAN SINEMBAH/g;
$listdata[$i] =~ s/KOTA MEDAN SERI RAMBAHAN/MEDAN SERI RAMBAHAN/g;
$listdata[$i] =~ s/KOTA MEDAN SELAYANG/MEDAN SELAYANG/g;
$listdata[$i] =~ s/KOTA MEDAN SATRIA/MEDAN SATRIA/g;
$listdata[$i] =~ s/KOTA MEDAN POLONIA/MEDAN POLONIA/g;
$listdata[$i] =~ s/KOTA MEDAN PETISAH/MEDAN PETISAH/g;
$listdata[$i] =~ s/KOTA MEDAN PERJUANGAN/MEDAN PERJUANGAN/g;
$listdata[$i] =~ s/KOTA MEDAN MARELAN/MEDAN MARELAN/g;
$listdata[$i] =~ s/KOTA MEDAN MAIMUN/MEDAN MAIMUN/g;
$listdata[$i] =~ s/KOTA MEDAN LABUHAN/MEDAN LABUHAN/g;
$listdata[$i] =~ s/KOTA MEDAN KRIO/MEDAN KRIO/g;
$listdata[$i] =~ s/KOTA MEDAN KOTA BELAWAN/MEDAN KOTA BELAWAN/g;
$listdata[$i] =~ s/KOTA MEDAN KOTA/MEDAN KOTA/g;
$listdata[$i] =~ s/KOTA MEDAN JOHOR/MEDAN JOHOR/g;
$listdata[$i] =~ s/KOTA MEDAN JAYA/MEDAN JAYA/g;
$listdata[$i] =~ s/KOTA MEDAN HELVETIA/MEDAN HELVETIA/g;
$listdata[$i] =~ s/KOTA MEDAN ESTATE/MEDAN ESTATE/g;
$listdata[$i] =~ s/KOTA MEDAN DENAI/MEDAN DENAI/g;
$listdata[$i] =~ s/KOTA MEDAN DELI/MEDAN DELI/g;
$listdata[$i] =~ s/KOTA MEDAN BARU/MEDAN BARU/g;
$listdata[$i] =~ s/KOTA MEDAN BARAT/MEDAN BARAT/g;
$listdata[$i] =~ s/KOTA MEDAN AREA/MEDAN AREA/g;
$listdata[$i] =~ s/KOTA MEDAN AMPLAS/MEDAN AMPLAS/g;
$listdata[$i] =~ s/KOTA KOTA MEDAN/KOTA MEDAN/g;
$listdata[$i] =~ s/KAMPUNG KOTA MEDAN/KAMPUNG MEDAN/g;
$listdata[$i] =~ s/GUNUNG KOTA MEDAN/GUNUNG MEDAN/g;
}
if ($listdata[$i] =~ /TELUK KOTA BINJAI|TANJUNG KOTA BINJAI|SARING SUNGAI KOTA BINJAI|RAWANG KOTA BINJAI|PULAU KOTA BINJAI|PERADUAN KOTA BINJAI|PEKAN KOTA BINJAI|PADANG KOTA BINJAI|LUBUK KOTA BINJAI|KOTA KOTA BINJAI|KELURAHAN SUNGAI KOTA BINJAI|DARASAN KOTA BINJAI|KOTA BINJAI WANGI|KOTA BINJAI UTARA|KOTA BINJAI TIMUR|KOTA BINJAI TAPAN|KOTA BINJAI SERBANGAN|KOTA BINJAI SELATAN|KOTA BINJAI PUNGGAL|KOTA BINJAI PIRUA|KOTA BINJAI PEMANGKIH|KOTA BINJAI KOTA|KOTA BINJAI HULU|KOTA BINJAI HILIR|KOTA BINJAI ESTATE|KOTA BINJAI BARAT|KOTA BINJAI BAKUNG|KOTA BINJAI AGUNG|BANUA KOTA BINJAI/) {
$listdata[$i] =~ s/TELUK KOTA BINJAI/TELUK BINJAI/g;
$listdata[$i] =~ s/TANJUNG KOTA BINJAI/TANJUNG BINJAI/g;
$listdata[$i] =~ s/SARING SUNGAI KOTA BINJAI/SARING SUNGAI BINJAI/g;
$listdata[$i] =~ s/RAWANG KOTA BINJAI/RAWANG BINJAI/g;
$listdata[$i] =~ s/PULAU KOTA BINJAI/PULAU BINJAI/g;
$listdata[$i] =~ s/PERADUAN KOTA BINJAI/PERADUAN BINJAI/g;
$listdata[$i] =~ s/PEKAN KOTA BINJAI/PEKAN BINJAI/g;
$listdata[$i] =~ s/PADANG KOTA BINJAI/PADANG BINJAI/g;
$listdata[$i] =~ s/LUBUK KOTA BINJAI/LUBUK BINJAI/g;
$listdata[$i] =~ s/KOTA KOTA BINJAI/KOTA BINJAI/g;
$listdata[$i] =~ s/KELURAHAN SUNGAI KOTA BINJAI/KELURAHAN SUNGAI BINJAI/g;
$listdata[$i] =~ s/DARASAN KOTA BINJAI/DARASAN BINJAI/g;
$listdata[$i] =~ s/KOTA BINJAI WANGI/BINJAI WANGI/g;
$listdata[$i] =~ s/KOTA BINJAI UTARA/BINJAI UTARA/g;
$listdata[$i] =~ s/KOTA BINJAI TIMUR/BINJAI TIMUR/g;
$listdata[$i] =~ s/KOTA BINJAI TAPAN/BINJAI TAPAN/g;
$listdata[$i] =~ s/KOTA BINJAI SERBANGAN/BINJAI SERBANGAN/g;
$listdata[$i] =~ s/KOTA BINJAI SELATAN/BINJAI SELATAN/g;
$listdata[$i] =~ s/KOTA BINJAI PUNGGAL/BINJAI PUNGGAL/g;
$listdata[$i] =~ s/KOTA BINJAI PIRUA/BINJAI PIRUA/g;
$listdata[$i] =~ s/KOTA BINJAI PEMANGKIH/BINJAI PEMANGKIH/g;
$listdata[$i] =~ s/KOTA BINJAI KOTA/BINJAI KOTA/g;
$listdata[$i] =~ s/KOTA BINJAI HULU/BINJAI HULU/g;
$listdata[$i] =~ s/KOTA BINJAI HILIR/BINJAI HILIR/g;
$listdata[$i] =~ s/KOTA BINJAI ESTATE/BINJAI ESTATE/g;
$listdata[$i] =~ s/KOTA BINJAI BARAT/BINJAI BARAT/g;
$listdata[$i] =~ s/KOTA BINJAI BAKUNG/BINJAI BAKUNG/g;
$listdata[$i] =~ s/KOTA BINJAI AGUNG/BINJAI AGUNG/g;
$listdata[$i] =~ s/BANUA KOTA BINJAI/BANUA BINJAI/g;
}
$listdata[$i] =~ s/\s\n\s/\n/g;
$listdata[$i] =~ s/\n\s/\n/g;
$listdata[$i] =~ s/\s\s\s/ /g;
print OUT $listdata[$i];
print OUT "~ ";
}
}
close (FILE);
close (FILE2);
close (OUT);

#---- 21
#UNTUK MERAPIKAN FORMAT StringKodepos1a.txt
#!C:/Perl/bin/perl.exe -w
open (OUT, 'matching/StringKodepos1a.txt') or die "can't open";
open (OUT2, '>matching/StringKodepos1b.txt') or die "can't open";
@a = <OUT>;
$aa = "@a";
chomp $aa;
$aa =~ s/[~]//g;
$aa =~ s/\n\s\s//g;
$aa =~ s/\n\s/\n/g;
print OUT2 $aa;
close(OUT);
close(OUT2);

#---- 22
#UNTUK MENGAMBIL NAMA ADM YANG SESUAI DENGAN KODEPOS
#!C:/Perl/bin/perl.exe -w
open(FILE3, "matching/DB_Kodepos.txt") or die "can't open";
open (OUT2, 'matching/StringKodepos1a.txt') or die "can't open";
open (OUT3, '>matching/StringKodepos2.txt') or die "can't open";
@lines = <OUT2>;
$input = "@lines";
chomp $input;
foreach ($input =~ /\~ /) {
@listdata = split(/\~ /, $input);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
foreach $entitas4(<FILE3>) {
@lines4 = split(/\^/, $entitas4);
$a4 = $lines4[0];
$b4 = $lines4[1];
chomp $b4;
if ($listdata[$i] =~ / $a4/) {
print OUT3 $a4."^".$b4."\n";
}
}
}
}
close(FILE3);
close(OUT2);
close(OUT3);

#---- 23
#UNTUK MERAPIKAN FORMAT StringKodepos2.txt
#!C:/Perl/bin/perl.exe -w
open (OUT, 'matching/StringKodepos2.txt') or die "can't open";
open (OUT2, '>matching/StringKodepos2a.txt') or die "can't open";
@a = <OUT>;
$aa = "@a";
chomp $aa;
$aa =~ s/\n\s/\n/g;
print OUT2 $aa;
close(OUT);
close(OUT2);

#---- 24
#UNTUK MENCOCOKKAN ADM KODEPOS DENGAN ADM DARI ADDRESS
#!C:/Perl/bin/perl.exe -w
open (OUT, 'matching/StringKodepos1b.txt') or die "can't open";
open (OUT3, 'matching/StringKodepos2a.txt') or die "can't open";
open (OUT4, '>matching/StringKodepos3.txt') or die "can't open";
@lines = <OUT>;
$input = "@lines";
foreach $entitas4(<OUT3>) {
@lines4 = split(/\^/, $entitas4);
$id = $lines4[0];
$adm = $lines4[1];
$adm =~ s/\n//g;
foreach ($input =~ /\;/) {
@listdata = split(/\;/, $input);
$totalaray = scalar(@listdata)-1;
for($i=0;$i<=$totalaray;$i++){
@temp1 = $listdata[$i];
if ($listdata[$i] =~ /$id/ and $listdata[$i] =~ /$adm/) {
print OUT4 $listdata[$i]."^".$adm."^ MATCH\n";
}
else {
print OUT4 $listdata[$i]."^".$adm."^ NOT MATCH\n";
}
}
}
}
close(OUT);
close(OUT3);
close(OUT4);

#---- 25
#UNTUK MERAPIKAN FORMAT StringKodepos3.txt
#!C:/Perl/bin/perl.exe -w
open (OUT, 'matching/StringKodepos3.txt') or die "can't open";
open (OUT2, '>matching/StringKodepos3a.txt') or die "can't open";
@a = <OUT>;
$aa = "@a";
chomp $aa;
$aa =~ s/\n\n/\n/g;
$aa =~ s/\s\n\s\s//g;
$aa =~ s/\n\s/\n/g;
print OUT2 $aa;
close(OUT);
close(OUT2);

#---- 26
#UNTUK NGAMBIL YANG HASILNYA MATCH SAJA
#!C:/Perl/bin/perl.exe -w
open (OUT2, 'matching/StringKodepos3a.txt') or die "can't open";
open (OUT3, '>matching/StringKodepos4.txt') or die "can't open";
foreach $entitas4(<OUT2>) {
@lines4 = split(/\^/, $entitas4);
$a0 = $lines4[0];
$a1 = $lines4[1];
$a2 = $lines4[2];
$a3 = $lines4[3];
$a4 = $lines4[4];
$a4 =~ s/\n//g;
if ($a4 eq " MATCH") {
print OUT3 $a0."^MATCH^MATCH^MATCH^MATCH\n";
}
}
close(OUT2);
close(OUT3);

#---- 27
#UNTUK UPDATE HASIL KE DB YANG DIGUNAKAN
#!C:/Perl/bin/perl.exe -w
use DBI;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
open (OUT2, 'matching/DokumenMatchAdm.txt') or die "can't open";
@q = <OUT2>;
$qq ="@q";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "truncate $qq";
$sth = $dbh->prepare($sql);
$sth->execute or die "SQL Error: $DBI::errstr\n";
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
close (OUT);
close (OUT2);

#---- 28
#UNTUK INSERT HASIL KE DB YANG DIGUNAKAN
#!C:/Perl/bin/perl.exe -w
use DBI;
open (OUT2, 'matching/StringKodepos4.txt') or die "can't open";
open (OUT3, 'matching/DokumenMatchAdm.txt') or die "can't open";
@q = <OUT3>;
$qq ="@q";
foreach $aaa(<OUT2>) {
@lines6 = split(/\^/, $aaa);
$a6 = $lines6[0];
$b6 = $lines6[1];
$c6 = $lines6[2];
$d6 = $lines6[3];
$e6 = $lines6[4];
if ($e6 =~ /\n/) {
$e6 =~ s/\n//g;
}
$user = "gis";
$pw = "Gis123.>";
$dsn = 'dbi:Pg:dbname=db_engine_geocode;host=192.168.5.11;port=5432';
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "insert into $qq(id, match_vi, match_su, match_di, match_pr) values (?,?,?,?,?)";
$sth = $dbh->prepare($sql);
$sth->execute($a6,$b6,$c6,$d6,$e6) or die "SQL Error: $DBI::errstr\n";
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
close (OUT2);
close (OUT3);

#---- 29
#UNTUK JOIN HASIL KE DB YANG DIGUNAKAN
#!C:/Perl/bin/perl.exe -w
use DBI;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
open (OUT2, 'matching/DokumenMatchAdm.txt') or die "can't open";
@q = <OUT2>;
$qq ="@q";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql = "update $tb set match_vi = ?, match_su = ?, match_di = ?, match_pr = ? where id = ?";
$sth = $dbh->prepare($sql);
$sql2 = "select a.id, a.match_vi, a.match_su, a.match_di, a.match_pr from $qq as a left join $tb as b on a.id = b.id order by a.id";
$sth2 = $dbh->prepare($sql2);
$sth2->execute;
while (@data = $sth2->fetchrow_array()) {
    my $id = $data[0];
    my $matchvi = $data[1];
    my $matchsu = $data[2];
    my $matchdi = $data[3];
    my $matchpr = $data[4];
    $sth->execute($matchvi,$matchsu,$matchdi,$matchpr,$id);
    $sth->finish;
}
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
$sth2->finish;
close (OUT);
close (OUT2);

#---- 30
#PRINT KE LAYAR PERNYATAAN SELESAI
#!/usr/bin/perl -w
print "PROSES MATCHING ADM SELESAI DILAKUKAN :)";
print "\n";

#------------------------------------------------------------------------------------------------------------#

#CODE 4 (MEMBUAT SUMMARY DAN SUMMARY DETAIL)
#---- 1
#UNTUK MENGUPDATE KOLOM SUMMARY DAN SUMMARY_DETAIL YANG ADA PADA TABLE YANG DIGUNAKAN
#!C:/Perl/bin/perl.exe -w
use DBI;
open (OUT, 'matching/Dokumen.txt') or die "can't open";
foreach $aaa (<OUT>) {
@listdata = split(/\;/, $aaa);
$db = $listdata[0];
$host = $listdata[1];
$port = $listdata[2];
$tb = $listdata[3];
$user = $listdata[4];
$pw = $listdata[5];
$dsn = 'dbi:Pg:dbname='.$db.';host='.$host.';port='.$port;
$dbh = DBI->connect($dsn, $user, $pw) or die "Connection Error: $DBI::errstr\n";
eval{
$dbh->{AutoCommit} = 0;
$sql1 = "UPDATE $tb set summary_detail = 'MATCH JALAN ONLY', summary = 'LOW' where match_vi = 'MATCH' and match_su = 'NOT MATCH' and match_di = 'NOT MATCH' and match_jln = 'MATCH' and (keterangan != 'CENTROID' or keterangan is null or keterangan = 'GOOGLE MAPS GEOCODING' or keterangan = 'GOOGLE PLACE')";
$sql2 = "UPDATE $tb set summary_detail = 'MATCH JALAN ONLY', summary = 'LOW' where match_vi = 'NOT MATCH' and match_su = 'MATCH' and match_di = 'NOT MATCH' and match_jln = 'MATCH' and (keterangan != 'CENTROID' or keterangan is null or keterangan = 'GOOGLE MAPS GEOCODING' or keterangan = 'GOOGLE PLACE')";
$sql3 = "UPDATE $tb set summary_detail = 'MATCH JALAN, MATCH KAB', summary = 'HIGH' where match_vi = 'NOT MATCH' and match_su = 'NOT MATCH' and match_di = 'MATCH' and match_jln = 'MATCH' and (keterangan != 'CENTROID' or keterangan is null or keterangan = 'GOOGLE MAPS GEOCODING' or keterangan = 'GOOGLE PLACE')";
$sql4 = "UPDATE $tb set summary_detail = 'MATCH JALAN, MATCH KEL', summary = 'HIGH' where match_vi = 'MATCH' and match_su = 'MATCH' and match_di = 'NOT MATCH' and match_jln = 'MATCH' and (keterangan != 'CENTROID' or keterangan is null or keterangan = 'GOOGLE MAPS GEOCODING' or keterangan = 'GOOGLE PLACE')";
$sql5 = "UPDATE $tb set summary_detail = 'MATCH JALAN, MATCH KEL', summary = 'HIGH' where match_vi = 'MATCH' and match_su = 'NOT MATCH' and match_di = 'MATCH' and match_jln = 'MATCH' and (keterangan != 'CENTROID' or keterangan is null or keterangan = 'GOOGLE MAPS GEOCODING' or keterangan = 'GOOGLE PLACE')";
$sql6 = "UPDATE $tb set summary_detail = 'MATCH JALAN, MATCH KEC', summary = 'HIGH' where match_vi = 'NOT MATCH' and match_su = 'MATCH' and match_di = 'MATCH' and match_jln = 'MATCH' and (keterangan != 'CENTROID' or keterangan is null or keterangan = 'GOOGLE MAPS GEOCODING' or keterangan = 'GOOGLE PLACE')";
$sql7 = "UPDATE $tb set summary_detail = 'MATCH JALAN, MATCH KEL', summary = 'HIGH' where match_vi = 'MATCH' and match_su = 'MATCH' and match_di = 'MATCH' and match_jln = 'MATCH' and (keterangan != 'CENTROID' or keterangan is null or keterangan = 'GOOGLE MAPS GEOCODING' or keterangan = 'GOOGLE PLACE')";
$sql8 = "UPDATE $tb set summary_detail = 'MATCH JALAN ONLY', summary = 'LOW' where match_vi = 'NOT MATCH' and match_su = 'NOT MATCH' and match_di = 'NOT MATCH' and match_jln = 'MATCH' and (keterangan != 'CENTROID' or keterangan is null or keterangan = 'GOOGLE MAPS GEOCODING' or keterangan = 'GOOGLE PLACE')";
$sql9 = "UPDATE $tb set summary_detail = 'ALL NOT MATCH', summary = 'LOW' where match_vi = 'NOT MATCH' and match_su = 'NOT MATCH' and match_di = 'NOT MATCH' and match_jln = 'NOT MATCH' and (keterangan != 'CENTROID' or keterangan is null or keterangan = 'GOOGLE MAPS GEOCODING' or keterangan = 'GOOGLE PLACE' or keterangan = 'ERROR')";
$sql10 = "UPDATE $tb set summary_detail = 'MATCH KEL ONLY', summary = 'MEDIUM' where match_vi = 'MATCH' and match_su = 'NOT MATCH' and match_di = 'NOT MATCH' and match_jln = 'NOT MATCH' and (keterangan != 'CENTROID' or keterangan is null or keterangan = 'GOOGLE MAPS GEOCODING' or keterangan = 'GOOGLE PLACE')";
$sql11 = "UPDATE $tb set summary_detail = 'MATCH KEC ONLY', summary = 'MEDIUM' where match_vi = 'NOT MATCH' and match_su = 'MATCH' and match_di = 'NOT MATCH' and match_jln = 'NOT MATCH' and (keterangan != 'CENTROID' or keterangan is null or keterangan = 'GOOGLE MAPS GEOCODING' or keterangan = 'GOOGLE PLACE')";
$sql12 = "UPDATE $tb set summary_detail = 'MATCH KAB ONLY', summary = 'LOW' where match_vi = 'NOT MATCH' and match_su = 'NOT MATCH' and match_di = 'MATCH' and match_jln = 'NOT MATCH' and (keterangan != 'CENTROID' or keterangan is null or keterangan = 'GOOGLE MAPS GEOCODING' or keterangan = 'GOOGLE PLACE')";
$sql13 = "UPDATE $tb set summary_detail = 'MATCH KEL ONLY', summary = 'MEDIUM' where match_vi = 'MATCH' and match_su = 'MATCH' and match_di = 'NOT MATCH' and match_jln = 'NOT MATCH' and (keterangan != 'CENTROID' or keterangan is null or keterangan = 'GOOGLE MAPS GEOCODING' or keterangan = 'GOOGLE PLACE')";
$sql14 = "UPDATE $tb set summary_detail = 'MATCH KEL ONLY', summary = 'MEDIUM' where match_vi = 'MATCH' and match_su = 'NOT MATCH' and match_di = 'MATCH' and match_jln = 'NOT MATCH' and (keterangan != 'CENTROID' or keterangan is null or keterangan = 'GOOGLE MAPS GEOCODING' or keterangan = 'GOOGLE PLACE')";
$sql15 = "UPDATE $tb set summary_detail = 'MATCH KEC ONLY', summary = 'MEDIUM' where match_vi = 'NOT MATCH' and match_su = 'MATCH' and match_di = 'MATCH' and match_jln = 'NOT MATCH' and  (keterangan != 'CENTROID' or keterangan is null or keterangan = 'GOOGLE MAPS GEOCODING' or keterangan = 'GOOGLE PLACE')";
$sql16 = "UPDATE $tb set summary_detail = 'MATCH KEL ONLY', summary = 'MEDIUM' where match_vi = 'MATCH' and match_su = 'MATCH' and match_di = 'MATCH' and match_jln = 'NOT MATCH' and (keterangan != 'CENTROID' or keterangan is null or keterangan = 'GOOGLE MAPS GEOCODING' or keterangan = 'GOOGLE PLACE')";
$sql10a = "UPDATE $tb set summary_detail = 'CENTROID KEL', summary = 'LOW' where match_vi = 'MATCH' and match_su = 'NOT MATCH' and match_di = 'NOT MATCH' and match_jln = 'NOT MATCH' and keterangan = 'CENTROID'";
$sql11a = "UPDATE $tb set summary_detail = 'CENTROID KEC', summary = 'LOW' where match_vi = 'NOT MATCH' and match_su = 'MATCH' and match_di = 'NOT MATCH' and match_jln = 'NOT MATCH' and keterangan = 'CENTROID'";
$sql12a = "UPDATE $tb set summary_detail = 'CENTROID KAB', summary = 'LOW' where match_vi = 'NOT MATCH' and match_su = 'NOT MATCH' and match_di = 'MATCH' and match_jln = 'NOT MATCH' and keterangan = 'CENTROID'";
$sql13a = "UPDATE $tb set summary_detail = 'CENTROID KEL', summary = 'LOW' where match_vi = 'MATCH' and match_su = 'MATCH' and match_di = 'NOT MATCH' and match_jln = 'NOT MATCH' and keterangan = 'CENTROID'";
$sql14a = "UPDATE $tb set summary_detail = 'CENTROID KEL', summary = 'LOW' where match_vi = 'MATCH' and match_su = 'NOT MATCH' and match_di = 'MATCH' and match_jln = 'NOT MATCH' and keterangan = 'CENTROID'";
$sql15a = "UPDATE $tb set summary_detail = 'CENTROID KEC', summary = 'LOW' where match_vi = 'NOT MATCH' and match_su = 'MATCH' and match_di = 'MATCH' and match_jln = 'NOT MATCH' and keterangan = 'CENTROID'";
$sql16a = "UPDATE $tb set summary_detail = 'CENTROID KEL', summary = 'LOW' where match_vi = 'MATCH' and match_su = 'MATCH' and match_di = 'MATCH' and match_jln = 'NOT MATCH' and keterangan = 'CENTROID'";
$sth1 = $dbh->prepare($sql1);
$sth2 = $dbh->prepare($sql2);
$sth3 = $dbh->prepare($sql3);
$sth4 = $dbh->prepare($sql4);
$sth5 = $dbh->prepare($sql5);
$sth6 = $dbh->prepare($sql6);
$sth7 = $dbh->prepare($sql7);
$sth8 = $dbh->prepare($sql8);
$sth9 = $dbh->prepare($sql9);
$sth10 = $dbh->prepare($sql10);
$sth11 = $dbh->prepare($sql11);
$sth12 = $dbh->prepare($sql12);
$sth13 = $dbh->prepare($sql13);
$sth14 = $dbh->prepare($sql14);
$sth15 = $dbh->prepare($sql15);
$sth16 = $dbh->prepare($sql16);
$sth10a = $dbh->prepare($sql10a);
$sth11a = $dbh->prepare($sql11a);
$sth12a = $dbh->prepare($sql12a);
$sth13a = $dbh->prepare($sql13a);
$sth14a = $dbh->prepare($sql14a);
$sth15a = $dbh->prepare($sql15a);
$sth16a = $dbh->prepare($sql16a);
$sth1->execute;
$sth2->execute;
$sth3->execute;
$sth4->execute;
$sth5->execute;
$sth6->execute;
$sth7->execute;
$sth8->execute;
$sth9->execute;
$sth10->execute;
$sth11->execute;
$sth12->execute;
$sth13->execute;
$sth14->execute;
$sth15->execute;
$sth16->execute;
$sth10a->execute;
$sth11a->execute;
$sth12a->execute;
$sth13a->execute;
$sth14a->execute;
$sth15a->execute;
$sth16a->execute;
$dbh->commit();
};
if($@){
print "Error inserting the link and tag: $@";
$dbh->rollback();
}
$dbh->disconnect();
}
close (OUT);

#---- 2
#PRINT KE LAYAR PERNYATAAN SELESAI
#!/usr/bin/perl -w
print "PROSES SUMMARY SELESAI DILAKUKAN :)\n";
$duration = time - $start;
print "WAKTU EKSEKUSI: $duration detik";
