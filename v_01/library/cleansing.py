import re

# pattern cleansing
pattern_addressmall = re.compile(
    '\\b(?=\w)(Mall)([a-z ]*)([,0-9]|lt|jl)', re.IGNORECASE)
pattern_admin_kec = re.compile(
    '\\b(?=\w)(kecamatan|kec)\W', re.IGNORECASE)
pattern_admin_kel = re.compile(
    '\\b(?=\w)(kelurahan|kel)\W', re.IGNORECASE)
pattern_admin_kab = re.compile(
    '\\b(?=\w)(kabupaten|kab|kota|kodya)\W', re.IGNORECASE)
pattern_admin_prov = re.compile(
    '\\b(?=\w)(provinsi|prov)\W', re.IGNORECASE)
pattern_apartemen = re.compile(
    '\\b(?=\w)(apartment|apartement|apartemen)', re.IGNORECASE)
pattern_arah = re.compile(
    '\\b(?=\w)(dalam|bagian|paling|plg|di\W|pertigaan|perempatan|jual|bawah)',
    re.IGNORECASE)
pattern_belakangpoi = re.compile(
    '\\b(?=\w)(bks|act|STAND|lt|lantai|unit|brt|sebelah|aks|BEDAK)',
    re.IGNORECASE)
pattern_blok = re.compile(
    '\\b(?=\w)(blok|block|blk|bk|bl)[\W]?', re.IGNORECASE)
pattern_bloknum = re.compile(
    '\\b(?=\w)(blok|block|blk|bk|bl|kavling|kav)(\s|\W\s|\W)([A-Z]+|[0-9]+)',
    re.IGNORECASE)
pattern_blok_multiple = re.compile(
    '\\b(?=\w)(blok|block|blk|bk|kavling|kav)(\W||W\s)([A-Z]+.[0-9]+)\s(&|dan)'
    '\s([A-Z]+.[0-9]+)', re.IGNORECASE)
pattern_bracket = re.compile(
    '[\[\]\{\}\(\)]', re.IGNORECASE)
pattern_cluster = re.compile(
    '\\b(?=\w)(cluster)', re.IGNORECASE)
pattern_desa = re.compile(
    '\\b(?=\w)(desa|dusun|ds|dsn)\W', re.IGNORECASE)
pattern_dpn_blkg = re.compile(
    '\\b(?=\w)(depannya|depanya|depan|dpn|belakang|blkng|blkg|dekat|dkt)',
    re.IGNORECASE)
pattern_duplicate = re.compile(
    '\\b(\w+)( \1\\b)+', re.IGNORECASE)
pattern_gang = re.compile(
    '\\b(?=\w)(gang|gg|gang)', re.IGNORECASE)
pattern_gangnum = re.compile(
    '\\b(?=\w)(gang|gg|gang)(\W|\W\s|\s\W|)([0-9]+|\\b(?=\w)[a-z]{0,3}(\W|$)'
    '|[a-z]+)',
    re.IGNORECASE)
pattern_gedung = re.compile(
    '\\b(?=\w)(gedung|gd|gdg|kantor|ktr|kntr)', re.IGNORECASE)
pattern_griya = re.compile(
    '\\b(?=\w)(griya)', re.IGNORECASE)
pattern_ibu = re.compile(
    '\\b(?=\w)(ibu|bapak|bpk|bp|bp)[\.\s]+([a-z]+)', re.IGNORECASE)
pattern_jalan = re.compile(
    '\\b(?=\w)(jalan|jln|jl|jlan|jaln)', re.IGNORECASE)
pattern_jakarta = re.compile(
    '\\b(?=\w)(jak|jkt)[\W\s]+', re.IGNORECASE)
pattern_jakbar = re.compile(
    '(jakarta)\W(barat|brt|bara$|bar$|ba$|b$)', re.IGNORECASE)
pattern_jaksel = re.compile(
    '(jakarta)\W(selatan|sltn|selata$|selat$|sela$|sel$|se$|s$)|(jakse$|jaks$)'
    , re.IGNORECASE)
pattern_jaktim = re.compile(
    '(jakarta)\W(timur|tmr|timu$|tim$|ti$|t$)', re.IGNORECASE)
pattern_jakpus = re.compile(
    '(jakarta)\W(pusat|pst|pusa$|pus$|pu$|p$)', re.IGNORECASE)
pattern_jakut = re.compile(
    '(jakarta)\W(utara|utr|utar$|uta$|ut$|u$)', re.IGNORECASE)
pattern_kampung = re.compile(
    '\\b(?=\w)(kampung|kpg|kmp|kp)\W', re.IGNORECASE)
pattern_keckabgabung = re.compile(
    '(kec.|kecamatan|kec)([a-z ]*)(kab.|kab|kabupaten|kota)', re.IGNORECASE)
pattern_kelkecgabung = re.compile(
    '(kel|kel.|kelurahan|desa|dsn.|dsn|ds|ds.)([a-z ]*)(kec.|kecamatan|kec)',
    re.IGNORECASE)
pattern_kilometer = re.compile(
    '\\b(?=\w)(km.|km)', re.IGNORECASE)
pattern_kodepos = re.compile(
    '\\b(?=\w)(kodepos|kode\spos)', re.IGNORECASE)
pattern_kodeposnum = re.compile(
    '\\b[0-9]{5}\\b', re.IGNORECASE)
pattern_komplek = re.compile(
    '\\b(?=\w)(kompleks|komplek|komp)(\W\s|\s)', re.IGNORECASE)
pattern_lainlain = re.compile(
    '\\b(?=\w)(aks|bks|deretan|pojok)', re.IGNORECASE)
pattern_lastparent = re.compile(
    '\)$')
pattern_letter_after_number = re.compile(
    '[0-9]+(\s|:|-|)([a-z]{0,2}\W|[a-z]\s|[a-z]$)', re.IGNORECASE)
pattern_lantai = re.compile(
    '\\b(?=\w)(lantai|lt\.|lt|flr|floor)(\s|)\\b', re.IGNORECASE)
pattern_lapangan = re.compile(
    '\\b(?=\w)(lap|lpngn)(\W|\W\s)', re.IGNORECASE)
pattern_los = re.compile(
    '\\b(?=\w)(los|kios|lapak)', re.IGNORECASE)
pattern_mall = re.compile(
    '\\b(?=\w)(mall)', re.IGNORECASE)
pattern_meter = re.compile(
    '\\b(?=\w)[0-9]+(\s|)meter', re.IGNORECASE)
pattern_no = re.compile(
    '\\b(?=\w)(nomor|nomer|nmr|no\W)(\s|)', re.IGNORECASE)
pattern_no_end = re.compile(
    '\\b(?=\w)(nomor|nomer|nmr|no)(.$|.\s$|$)', re.IGNORECASE)
pattern_no_eng = re.compile(
    '\\b(?=\w)[0-9]+(st|nd|rd|th)', re.IGNORECASE)
pattern_number = re.compile(
    '[0-9]+', re.IGNORECASE)
pattern_numberandnumber = re.compile('([0-9]{0,3}(\s|)[a-z]{0,2})\s(&|dan)\s'
                                     '([0-9]{0,3}\s[a-z]{0,2})', re.IGNORECASE)
pattern_numberandparent = re.compile(
    '[0-9]+(\s|)\(')
pattern_numberwithletter = re.compile(
    '\W[a-z]?(|\W)[0-9]+|(\W|)[0-9]+\W\\b[a-z]?(\W|\\b)', re.IGNORECASE)
pattern_onlysinglenumber = re.compile(
    '^\d$')
pattern_pasar = re.compile(
    '\\b(?=\w)(pasar|psr|ps|psar|pasr)', re.IGNORECASE)
pattern_tlp = re.compile(
    '\\b(?=\w)((tlp|telp|telepon|telpon|tlp|tlp|telp|telp|)[\.\s\:]{0,3}(02\d*'
    '[\s-]+[0-9]+|\d{7,}|[02].([0-9]*).[0-9]+|\d{7,}|(\(|)[02\d](\)|)*'
    '\W[0-9]+))', re.IGNORECASE)
pattern_raya = re.compile(
    '(\sRAYA\s|\sRY\s|\WRAYA)', re.IGNORECASE)
pattern_rt = re.compile(
    '\\b(?=\w)(rt.[0-9]+.(/)*.([0-9]+)|rt(\W\s|\W)[0-9]+|rt(\W\s|\W)[0-9]+'
    '[a-z]?|rt(\.)[0-9]+[a-z]+|rt\W\s[0-9]+\s[0-9]+|rt(\W|)$)*', re.IGNORECASE)
pattern_rw = re.compile(
    '\\b(?=\w)(rw[.\s][0-9]+|rw(\W|)$)', re.IGNORECASE)
pattern_rtrw = re.compile(
    '(\\b(?=\w)rt/rw.[0-9]+.(/)*.[0-9]+|\\b(?=\w)rt(\W|\W\s|s|)[0-9]+(\s|/)'
    'rw(\W|\W\s|\s|)[0-9]+|rt[0-9]+(\s|)rw[0-9]+|rt[a-z]+\srw[a-z]+'
    '|\\b(?=\w)rt(\.)[0-9]+[a-z]?\srw\s[0-9]+|\\b(?=\w)rt/rw[0-9]+)',
    re.IGNORECASE)
pattern_samping = re.compile(
    '\\b(?=\w)(samping|smpng|spg|seberang|sebrang|sebelah|samp\.|sblh|lewat|'
    'setelah|stlh|sesudah|ssdh|sebelum|sblm)', re.IGNORECASE)
pattern_spaces_lead_trail = re.compile(
    '(^[ \t]|[ \t]+$)')
pattern_spaces_multiple = re.compile(
    '\s{2,}')
pattern_tandaarah = re.compile(
    '\\b(?=\w)(sebelah|sblh)\s(.)(timur|selatan|barat|utara|tenggara|tengah)',
    re.IGNORECASE)
pattern_tandabaca = re.compile(
    '([;:/.,-])', re.IGNORECASE)
pattern_terminal = re.compile(
    '(terminal|trmnl)', re.IGNORECASE)
pattern_toko = re.compile(
    '\\b(?=\w)(toko|kios).[A-Z]+', re.IGNORECASE)
pattern_unavailable = re.compile(
    '^(general|xna|-)$', re.IGNORECASE)
pattern_trash = re.compile(
    '\\b(?=\w)(isi\sgalon|masuk|ke|fax|dari|parkir|iwan)(\s|\W|$)',
    re.IGNORECASE)


def cleansingGeocode(ori_address):
    fixed_address = pattern_jalan.sub('JALAN', ori_address)
    fixed_address = pattern_tlp.sub('', fixed_address)
    fixed_address = pattern_pasar.sub('PASAR', fixed_address)
    fixed_address = pattern_lantai.sub('', fixed_address)
    fixed_address = pattern_rtrw.sub('', fixed_address)
    fixed_address = pattern_rt.sub('', fixed_address)
    fixed_address = pattern_rw.sub('', fixed_address)
    fixed_address = pattern_gang.sub('GANG', fixed_address)
    fixed_address = pattern_kampung.sub('KAMPUNG ', fixed_address)
    fixed_address = pattern_arah.sub('', fixed_address)
    fixed_address = pattern_dpn_blkg.sub('', fixed_address)
    fixed_address = pattern_blok.sub('BLOK ', fixed_address)
    fixed_address = pattern_samping.sub('', fixed_address)
    fixed_address = pattern_admin_kec.sub('', fixed_address)
    fixed_address = pattern_admin_kel.sub('', fixed_address)
    fixed_address = pattern_admin_kab.sub('', fixed_address)
    fixed_address = pattern_admin_prov.sub('', fixed_address)
    fixed_address = pattern_kodepos.sub('', fixed_address)
    fixed_address = pattern_kodeposnum.sub('', fixed_address)
    fixed_address = pattern_jakarta.sub('JAKARTA ', fixed_address)
    fixed_address = pattern_jakpus.sub('JAKARTA PUSAT', fixed_address)
    fixed_address = pattern_jakbar.sub('JAKARTA BARAT', fixed_address)
    fixed_address = pattern_jaksel.sub('JAKARTA SELATAN', fixed_address)
    fixed_address = pattern_jaktim.sub('JAKARTA TIMUR', fixed_address)
    fixed_address = pattern_jakut.sub('JAKARTA UTARA', fixed_address)
    fixed_address = pattern_los.sub('', fixed_address)
    fixed_address = pattern_lapangan.sub('LAPANGAN ', fixed_address)
    fixed_address = pattern_toko.sub('', fixed_address)
    fixed_address = pattern_ibu.sub('', fixed_address)
    fixed_address = pattern_belakangpoi.sub('', fixed_address)
    fixed_address = pattern_raya.sub(' RAYA ', fixed_address)
    fixed_address = pattern_komplek.sub('KOMPLEK ', fixed_address)
    fixed_address = pattern_terminal.sub('TERMINAL', fixed_address)
    fixed_address = pattern_no_end.sub('', fixed_address)
    fixed_address = pattern_no_eng.sub('', fixed_address)
    fixed_address = pattern_meter.sub('', fixed_address)
    fixed_address = pattern_trash.sub('', fixed_address)
    fixed_address = pattern_bracket.sub('', fixed_address)
    fixed_address = pattern_tandabaca.sub(' ', fixed_address)
    fixed_address = pattern_spaces_lead_trail.sub('', fixed_address)
    fixed_address = pattern_spaces_multiple.sub(' ', fixed_address)
    fixed_address = pattern_duplicate.sub('\1', fixed_address)
    fixed_address = fixed_address.replace('\n', '')
    return fixed_address


def cleansingGeocodeRetry(ori_address):
    fixed_address = pattern_jalan.sub('JALAN', ori_address)
    fixed_address = pattern_pasar.sub('PASAR', fixed_address)
    fixed_address = pattern_gangnum.sub('', fixed_address)
    fixed_address = pattern_lantai.sub('', fixed_address)
    fixed_address = pattern_rtrw.sub('', fixed_address)
    fixed_address = pattern_rt.sub('', fixed_address)
    fixed_address = pattern_rw.sub('', fixed_address)
    fixed_address = pattern_tlp.sub('', fixed_address)
    fixed_address = pattern_numberandnumber.sub('', fixed_address)
    fixed_address = pattern_letter_after_number.sub('', fixed_address)
    fixed_address = pattern_meter.sub('', fixed_address)
    fixed_address = pattern_arah.sub('', fixed_address)
    fixed_address = pattern_dpn_blkg.sub('', fixed_address)
    fixed_address = pattern_samping.sub('', fixed_address)
    fixed_address = pattern_admin_kec.sub('', fixed_address)
    fixed_address = pattern_admin_kel.sub('', fixed_address)
    fixed_address = pattern_admin_kab.sub('', fixed_address)
    fixed_address = pattern_admin_prov.sub('', fixed_address)
    fixed_address = pattern_kodepos.sub('', fixed_address)
    fixed_address = pattern_kodeposnum.sub('', fixed_address)
    fixed_address = pattern_jakarta.sub('JAKARTA ', fixed_address)
    fixed_address = pattern_jakpus.sub('JAKARTA PUSAT', fixed_address)
    fixed_address = pattern_jakbar.sub('JAKARTA BARAT', fixed_address)
    fixed_address = pattern_jaksel.sub('JAKARTA SELATAN', fixed_address)
    fixed_address = pattern_jaktim.sub('JAKARTA TIMUR', fixed_address)
    fixed_address = pattern_jakut.sub('JAKARTA UTARA', fixed_address)
    fixed_address = pattern_los.sub('', fixed_address)
    fixed_address = pattern_lapangan.sub('LAPANGAN ', fixed_address)
    fixed_address = pattern_toko.sub('', fixed_address)
    fixed_address = pattern_ibu.sub('', fixed_address)
    fixed_address = pattern_desa.sub('', fixed_address)
    fixed_address = pattern_kampung.sub('', fixed_address)
    fixed_address = pattern_gedung.sub('', fixed_address)
    fixed_address = pattern_blok_multiple.sub('', fixed_address)
    fixed_address = pattern_bloknum.sub('', fixed_address)
    fixed_address = pattern_no.sub('', fixed_address)
    fixed_address = pattern_no_end.sub('', fixed_address)
    fixed_address = pattern_no_eng.sub('', fixed_address)
    fixed_address = pattern_numberwithletter.sub('', fixed_address)
    fixed_address = pattern_number.sub('', fixed_address)
    fixed_address = pattern_tandaarah.sub('', fixed_address)
    fixed_address = pattern_keckabgabung.sub('', fixed_address)
    fixed_address = pattern_kelkecgabung.sub('', fixed_address)
    fixed_address = pattern_lainlain.sub('', fixed_address)
    fixed_address = pattern_raya.sub(' ', fixed_address)
    fixed_address = pattern_terminal.sub('TERMINAL', fixed_address)
    fixed_address = pattern_apartemen.sub('', fixed_address)
    fixed_address = pattern_cluster.sub('', fixed_address)
    fixed_address = pattern_griya.sub('', fixed_address)
    fixed_address = pattern_komplek.sub('', fixed_address)
    fixed_address = pattern_mall.sub('', fixed_address)
    fixed_address = pattern_belakangpoi.sub('', fixed_address)
    fixed_address = pattern_addressmall.sub('', fixed_address)
    fixed_address = pattern_kilometer.sub('', fixed_address)
    fixed_address = pattern_trash.sub('', fixed_address)
    fixed_address = pattern_bracket.sub('', fixed_address)
    fixed_address = pattern_tandabaca.sub(' ', fixed_address)
    fixed_address = pattern_spaces_lead_trail.sub('', fixed_address)
    fixed_address = pattern_spaces_multiple.sub(' ', fixed_address)
    fixed_address = pattern_duplicate.sub('\1', fixed_address)
    fixed_address = fixed_address.replace('\n', '')
    return fixed_address


def cleansingGPlaces(ori_address):
    fixed_address = pattern_jalan.sub('JALAN', ori_address)
    fixed_address = pattern_pasar.sub('PASAR', fixed_address)
    fixed_address = pattern_gangnum.sub('', fixed_address)
    fixed_address = pattern_lantai.sub('', fixed_address)
    fixed_address = pattern_rtrw.sub('', fixed_address)
    fixed_address = pattern_rt.sub('', fixed_address)
    fixed_address = pattern_rw.sub('', fixed_address)
    fixed_address = pattern_tlp.sub('', fixed_address)
    fixed_address = pattern_numberandnumber.sub('', fixed_address)
    fixed_address = pattern_letter_after_number.sub('', fixed_address)
    fixed_address = pattern_meter.sub('', fixed_address)
    fixed_address = pattern_arah.sub('', fixed_address)
    fixed_address = pattern_arah.sub('', fixed_address)
    fixed_address = pattern_dpn_blkg.sub('', fixed_address)
    fixed_address = pattern_samping.sub('', fixed_address)
    fixed_address = pattern_admin_kec.sub('', fixed_address)
    fixed_address = pattern_admin_kel.sub('', fixed_address)
    fixed_address = pattern_admin_kab.sub('', fixed_address)
    fixed_address = pattern_admin_prov.sub('', fixed_address)
    fixed_address = pattern_kodepos.sub('', fixed_address)
    fixed_address = pattern_kodeposnum.sub('', fixed_address)
    fixed_address = pattern_jakarta.sub('JAKARTA ', fixed_address)
    fixed_address = pattern_jakpus.sub('JAKARTA PUSAT', fixed_address)
    fixed_address = pattern_jakbar.sub('JAKARTA BARAT', fixed_address)
    fixed_address = pattern_jaksel.sub('JAKARTA SELATAN', fixed_address)
    fixed_address = pattern_jaktim.sub('JAKARTA TIMUR', fixed_address)
    fixed_address = pattern_jakut.sub('JAKARTA UTARA', fixed_address)
    fixed_address = pattern_los.sub('', fixed_address)
    fixed_address = pattern_lapangan.sub('LAPANGAN ', fixed_address)
    fixed_address = pattern_toko.sub('', fixed_address)
    fixed_address = pattern_ibu.sub('', fixed_address)
    fixed_address = pattern_desa.sub('', fixed_address)
    fixed_address = pattern_kampung.sub('', fixed_address)
    fixed_address = pattern_blok_multiple.sub('', fixed_address)
    fixed_address = pattern_bloknum.sub('', fixed_address)
    fixed_address = pattern_no.sub('', fixed_address)
    fixed_address = pattern_no_end.sub('', fixed_address)
    fixed_address = pattern_no_eng.sub('', fixed_address)
    fixed_address = pattern_numberwithletter.sub('', fixed_address)
    fixed_address = pattern_number.sub('', fixed_address)
    fixed_address = pattern_belakangpoi.sub('', fixed_address)
    fixed_address = pattern_tandaarah.sub('', fixed_address)
    fixed_address = pattern_keckabgabung.sub('', fixed_address)
    fixed_address = pattern_kelkecgabung.sub('', fixed_address)
    fixed_address = pattern_lainlain.sub('', fixed_address)
    fixed_address = pattern_raya.sub(' ', fixed_address)
    fixed_address = pattern_komplek.sub('KOMPLEK ', fixed_address)
    fixed_address = pattern_terminal.sub('TERMINAL', fixed_address)
    fixed_address = pattern_kilometer.sub('', fixed_address)
    fixed_address = pattern_trash.sub('', fixed_address)
    fixed_address = pattern_bracket.sub('', fixed_address)
    fixed_address = pattern_tandabaca.sub(' ', fixed_address)
    fixed_address = pattern_spaces_lead_trail.sub('', fixed_address)
    fixed_address = pattern_spaces_multiple.sub(' ', fixed_address)
    fixed_address = pattern_duplicate.sub('\1', fixed_address)
    fixed_address = fixed_address.replace('\n', '')
    return fixed_address


def cleansingVillage(ori_vi):
    fixed_vi = pattern_spaces_lead_trail.sub('', ori_vi)
    fixed_vi = pattern_spaces_multiple.sub(' ', fixed_vi)
    fixed_vi = pattern_admin_kel.sub('', fixed_vi)
    fixed_vi = pattern_unavailable.sub('', fixed_vi)
    fixed_vi = pattern_numberandparent.sub('', fixed_vi)
    fixed_vi = pattern_lastparent.sub('', fixed_vi)
    fixed_vi = pattern_onlysinglenumber.sub('', fixed_vi)
    return fixed_vi


def cleansingSubDistrict(ori_su):
    fixed_su = pattern_spaces_lead_trail.sub('', ori_su)
    fixed_su = pattern_spaces_multiple.sub(' ', fixed_su)
    fixed_su = pattern_admin_kec.sub('', fixed_su)
    fixed_su = pattern_unavailable.sub('', fixed_su)
    fixed_su = pattern_numberandparent.sub('', fixed_su)
    fixed_su = pattern_lastparent.sub('', fixed_su)
    fixed_su = pattern_onlysinglenumber.sub('', fixed_su)
    return fixed_su


def cleansingDistrict(ori_di):
    fixed_di = pattern_spaces_lead_trail.sub('', ori_di)
    fixed_di = pattern_spaces_multiple.sub(' ', fixed_di)
    fixed_di = pattern_admin_kab.sub('', fixed_di)
    fixed_di = pattern_unavailable.sub('', fixed_di)
    fixed_di = pattern_numberandparent.sub('', fixed_di)
    fixed_di = pattern_lastparent.sub('', fixed_di)
    fixed_di = pattern_onlysinglenumber.sub('', fixed_di)
    return fixed_di


def cleansingProvince(ori_pr):
    fixed_pr = pattern_spaces_lead_trail.sub('', ori_pr)
    fixed_pr = pattern_spaces_multiple.sub(' ', fixed_pr)
    fixed_pr = pattern_admin_prov.sub('', fixed_pr)
    fixed_pr = pattern_unavailable.sub('', fixed_pr)
    fixed_pr = pattern_numberandparent.sub('', fixed_pr)
    fixed_pr = pattern_lastparent.sub('', fixed_pr)
    fixed_pr = pattern_onlysinglenumber.sub('', fixed_pr)
    return fixed_pr


def cleansingFullAddress(full_address):
    fixed_full_address = pattern_spaces_lead_trail.sub('', full_address)
    fixed_full_address = pattern_spaces_multiple.sub(' ', fixed_full_address)
    return fixed_full_address
