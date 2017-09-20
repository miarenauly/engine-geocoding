import jellyfish
from data_prep import *
from active_record import *
from pgsql import *


#Untuk menarik data yang dibutuhkan dari stringmatchingconcat
#Untuk memasukkan data yang sudah ditarik ke dalam table yang sama tetapi kolom berbeda
def fetch_adm_stringmatchingconcat(open_table_stringmatchingconcat):
	sql = fetch_data_adm_stringmatchingconcat(open_table_stringmatchingconcat)
	data = fetch(sql)
	for row in data:
		idx = row[0]
		dataa = row[1] 
		sql2 = update_data_adm_stringmatchingconcat(open_table_stringmatchingconcat, dataa, idx)
		execScalar(sql2)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (COLUMN ADM)\n")


#Untuk mengubah key menjadi value di dalam penggunaan dictionary (Kalau di Perl, dictionary = hash)
def replace_all2(repls, str):                                    
    return re.sub('|'.join(re.escape(key) for key in repls.keys()), lambda k: repls[k.group(0)], str)


#Untuk mengubah singkatan yang ada di StringMatchingConcat dengan kata-kata yang sudah distandarisasi di dalam file DB_Singkatan
def ubah_singkatan_adm_stringmatchingconcat(open_table_mtsingkatanadm, open_table_stringmatchingconcat):
	dic = {}
	sql2 = fetch_mtsingkatanadm(open_table_mtsingkatanadm)
	q2 = fetch(sql2)
	for row in q2:
		a = row[1]
		b = row[0]
		dic[a]=b
	sql = fetch_singkatan_adm_stringmatchingconcat(open_table_stringmatchingconcat)
	q = fetch(sql)
	for row in q:
		idx = row[0]
		adm = row[1]
		adm = adm.replace('.',' ').replace('-',' ').replace('(',' ').replace(')',' ').replace('"',' ').replace('/',' ').replace(':',' ').replace('*',' ').replace('+',' ').replace('[',' ').replace(']',' ').replace(',',' , ')
		adm = re.sub('\s+',' ',adm).strip()
		hasil = replace_all2(dic,adm)
		hasil = hasil.replace('KOTA ',' ').replace('DESA ',' ').replace('KEL ',' ').replace('KEC ',' ').replace('KAB ',' ').replace('PROV ',' ').replace('KABUPATEN',' ')
		hasil = re.sub('\s+',' ',hasil).strip()
		sql2 = '''update %s set adm_bersih = '%s' where id = %s''' % (open_table_stringmatchingconcat, hasil, idx)
		execScalar(sql2)
	print("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (COLUMN ADM_BERSIH)\n")


#Untuk memecah admawal dengan admreverse yang ada didalam adm_bersih
def split_adm_stringmatchingconcat(open_table_stringmatchingconcat):
	sql = fetch_singkatan_adm_stringmatchingconcatt(open_table_stringmatchingconcat)
	q = fetch(sql)
	for row in q:
		idx = row[0]
		adm_bersih = row[1]
		adm_bersih = adm_bersih.split(" | ")
		adm_awal_bersih = adm_bersih[0]
		adm_reverse_bersih = adm_bersih[1]
		sql = update_admawalbersih(open_table_stringmatchingconcat, adm_awal_bersih, idx)
		execScalar(sql)
		sql2 = update_admreversebersih(open_table_stringmatchingconcat, adm_reverse_bersih, idx)
		execScalar(sql2)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (COLUMN ADM_AWAL_BERSIH DAN ADM_REVERSE_BERSIH)\n")


#Untuk mengecek kata per kata yang ada di dalam adm_reverse_bersih ke dalam adm_awal_bersih
#Ket: Matching Adm Cara I (membandingkan ori_vi/su/di/pr dan adm_vi/su/di/pr (ke satu2 adm)(sama persis))
def checkperwords_adm_stringmatchingconcat(open_table_stringmatchingconcat):
	sql = fetchadm(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		if (vi_awal == vi_rev) and (vi_awal == 'NONE ') and (vi_rev == 'NONE '):
			#print('vi',idx,'+',vi_awal,'+',vi_rev,"+NOT MATCH")
			sql = ''' update %s set ket_matchvi = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		elif (vi_awal == vi_rev) and (vi_awal != 'NONE ') and (vi_rev != 'NONE '):
			#print('vi',idx,'+',vi_awal,'+',vi_rev,"+MATCH")
			sql = ''' update %s set ket_matchvi = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		else:
			#print('-------------------vi',idx,'+',vi_awal,'+',vi_rev,"+NOT MATCH")
			sql = ''' update %s set ket_matchvi = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		if (su_awal == su_rev) and (su_awal == ' NONE ') and (su_rev == ' NONE '):
			#print('su',idx,'+',su_awal,'+',su_rev,"+NOT MATCH")
			sql = ''' update %s set ket_matchsu = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		elif (su_awal == su_rev) and (su_awal != ' NONE ') and (su_rev != ' NONE '):
			#print('su',idx,'+',su_awal,'+',su_rev,"+MATCH")
			sql = ''' update %s set ket_matchsu = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		else:
			#print('-------------------su',idx,'+',su_awal,'+',su_rev,"+NOT MATCH")
			sql = ''' update %s set ket_matchsu = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)	
		if (di_awal == di_rev) and (di_awal == ' NONE ') and (di_rev == ' NONE '):
			#print('di',idx,'+',di_awal,'+',di_rev,"+NOT MATCH")
			sql = ''' update %s set ket_matchdi = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		elif (di_awal == di_rev) and (di_awal != ' NONE ') and (di_rev != ' NONE '):
			#print('di',idx,'+',di_awal,'+',di_rev,"+MATCH")
			sql = ''' update %s set ket_matchdi = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		else:
			#print('-------------------di',idx,'+',di_awal,'+',di_rev,"+NOT MATCH")
			sql = ''' update %s set ket_matchdi = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		if (pr_awal == pr_rev) and (pr_awal == ' NONE') and (pr_rev == ' NONE'):
			#print('pr',idx,'+',pr_awal,'+',pr_rev,"+NOT MATCH")
			sql = ''' update %s set ket_matchpr = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		elif (pr_awal == pr_rev) and (pr_awal != ' NONE') and (pr_rev != ' NONE'):
			#print('pr',idx,'+',pr_awal,'+',pr_rev,"+MATCH")
			sql = ''' update %s set ket_matchpr = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		else:
			#print('-------------------pr',idx,'+',pr_awal,'+',pr_rev,"+NOT MATCH")
			sql = ''' update %s set ket_matchpr = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (KET_MATCHADM I)\n")


#Untuk mengecek kata per kata yang ada di dalam adm_reverse_bersih ke dalam adm_awal_bersih
#Ket: Matching Adm Cara II (membandingkan ori_vi/su/di/pr dan adm_vi/su/di/pr (ke satu2 adm)(contains))
def checkperwords_adm_stringmatchingconcat2(open_table_stringmatchingconcat):
	sql = fetchadm2(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		if (vi_rev in vi_awal) or (vi_awal in vi_rev) and (vi_awal == 'NONE ') and (vi_rev == 'NONE '):
			#print('vi',idx,'+',vi_rev,'+',vi_awal,"+NOT MATCH")
			sql = ''' update %s set ket_matchvi = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		elif (vi_rev in vi_awal) or (vi_awal in vi_rev) and (vi_awal != 'NONE ') and (vi_rev != 'NONE '):
			#print('vi',idx,'+',vi_awal,'+',vi_rev,"+MATCH")
			sql = ''' update %s set ket_matchvi = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		else:
			#print('-------------------vi',idx,'+',vi_rev,'+',vi_awal,"+NOT MATCH")
			sql = ''' update %s set ket_matchvi = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	sql = fetchadm3(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		if (su_rev in su_awal) or (su_awal in su_rev)  and (su_awal == ' NONE ') and (su_rev == ' NONE '):
			#print('su',idx,'+',su_rev,'+',su_awal,"+NOT MATCH")
			sql = ''' update %s set ket_matchsu = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		elif (su_awal in su_rev) or (su_rev in su_awal) and (su_awal != ' NONE ') and (su_rev != ' NONE '):
			#print('su',idx,'+',su_awal,'+',su_rev,"+MATCH")
			sql = ''' update %s set ket_matchsu = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		else:
			#print('-------------------su',idx,'+',su_rev,'+',su_awal,"+NOT MATCH")
			sql = ''' update %s set ket_matchsu = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	sql = fetchadm4(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		if (di_rev in di_awal) or (di_awal in di_rev) and (di_awal == ' NONE ') and (di_rev == ' NONE '):
			#print('di',idx,'+',di_rev,'+',di_awal,"+NOT MATCH")
			sql = ''' update %s set ket_matchdi = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		elif (di_rev in di_awal) or (di_awal in di_rev) and (di_awal != ' NONE ') and (di_rev != ' NONE '):
			#print('di',idx,'+',di_rev,'+',di_awal,"+MATCH")
			sql = ''' update %s set ket_matchdi = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		else:
			#print('-------------------di',idx,'+',di_rev,'+',di_awal,"+NOT MATCH")
			sql = ''' update %s set ket_matchdi = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	sql = fetchadm5(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		if (pr_rev in pr_awal) or (pr_awal in pr_rev) and (pr_awal == ' NONE') and (pr_rev == ' NONE'):
			#print('pr',idx,'+',pr_rev,'+',pr_awal,"+NOT MATCH")
			sql = ''' update %s set ket_matchpr = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		elif (pr_rev in pr_awal) or (pr_awal in pr_rev) and (pr_awal != ' NONE') and (pr_rev != ' NONE'):
			#print('pr',idx,'+',pr_awal,'+',pr_rev,"+MATCH")
			sql = ''' update %s set ket_matchpr = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		else:
			#print('-------------------pr',idx,'+',pr_rev,'+',pr_awal,"+NOT MATCH")
			sql = ''' update %s set ket_matchpr = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (KET_MATCHADM II)\n")


#Untuk mengecek kata per kata yang ada di dalam adm_reverse_bersih ke dalam adm_awal_bersih
#Ket: Matching Adm Cara III (membandingkan ori_vi/su/di/pr dan adm_vi/su/di/pr dengan menggunakan jaro similarity (ke satu2 adm))
def checkperwords_adm_stringmatchingconcat3(open_table_stringmatchingconcat):
	sql = fetchadm2(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		score_lev = jellyfish.jaro_winkler(vi_awal, vi_rev)
		if (score_lev >= 0.92) and (vi_awal == 'NONE ') and (vi_rev == 'NONE '):
			#print('vi',idx,'+',vi_rev,'+',vi_awal,"+NOT MATCH")
			sql = ''' update %s set ket_matchvi = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		elif (score_lev >= 0.92) and (vi_awal != 'NONE ') and (vi_rev != 'NONE '):
			#print('vi',idx,'+',vi_awal,'+',vi_rev,"+MATCH")
			sql = ''' update %s set ket_matchvi = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		else:
			#print('-------------------vi',idx,'+',vi_rev,'+',vi_awal,"+NOT MATCH",score_lev)
			sql = ''' update %s set ket_matchvi = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	sql = fetchadm3(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		score_lev2 = jellyfish.jaro_winkler(su_awal, su_rev)
		if (score_lev2 >= 0.92) and (su_awal == ' NONE ') and (su_rev == ' NONE '):
			#print('su',idx,'+',su_rev,'+',su_awal,"+NOT MATCH")
			sql = ''' update %s set ket_matchsu = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		elif (score_lev2 >= 0.92) and (su_awal != ' NONE ') and (su_rev != ' NONE '):
			#print('su',idx,'+',su_awal,'+',su_rev,"+MATCH")
			sql = ''' update %s set ket_matchsu = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		else:
			#print('-------------------su',idx,'+',su_rev,'+',su_awal,"+NOT MATCH")
			sql = ''' update %s set ket_matchsu = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)	
	sql = fetchadm4(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		score_lev3 = jellyfish.jaro_winkler(di_awal, di_rev)
		if (score_lev3 >= 0.92) and (di_awal == ' NONE ') and (di_rev == ' NONE '):
			#print('di',idx,'+',di_rev,'+',di_awal,"+NOT MATCH")
			sql = ''' update %s set ket_matchdi = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		elif (score_lev3 >= 0.92) and (di_awal != ' NONE ') and (di_rev != ' NONE '):
			#print('di',idx,'+',di_rev,'+',di_awal,"+MATCH")
			sql = ''' update %s set ket_matchdi = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		else:
			#print('-------------------di',idx,'+',di_rev,'+',di_awal,"+NOT MATCH")
			sql = ''' update %s set ket_matchdi = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	sql = fetchadm5(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		score_lev4 = jellyfish.jaro_winkler(pr_awal, pr_rev)
		if (score_lev4 >= 0.92) and (pr_awal == ' NONE') and (pr_rev == ' NONE'):
			#print('pr',idx,'+',pr_rev,'+',pr_awal,"+NOT MATCH")
			sql = ''' update %s set ket_matchpr = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		elif (score_lev4 >= 0.92) and (pr_awal != ' NONE') and (pr_rev != ' NONE'):
			#print('pr',idx,'+',pr_awal,'+',pr_rev,"+MATCH")
			sql = ''' update %s set ket_matchpr = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		else:
			#print('-------------------pr',idx,'+',pr_rev,'+',pr_awal,"+NOT MATCH")
			sql = ''' update %s set ket_matchpr = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (KET_MATCHADM III)\n")


#Untuk menarik data yang dibutuhkan dari stringmatchingconcat
#Untuk memasukkan data yang sudah ditarik ke dalam table yang sama tetapi kolom berbeda
def fetch_adm_google_stringmatchingconcat(open_table_stringmatchingconcat):
	sql = fetch_data_adm_google_stringmatchingconcat(open_table_stringmatchingconcat)
	data = fetch(sql)
	for row in data:
		idx = row[0]
		dataa_google = row[1] 
		sql2 = update_data_adm_google_stringmatchingconcat(open_table_stringmatchingconcat, dataa_google, idx)
		execScalar(sql2)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (COLUMN ADM_GOOGLE)\n")


#Untuk mengubah singkatan yang ada di StringMatchingConcat dengan kata-kata yang sudah distandarisasi di dalam file DB_Singkatan
def ubah_singkatan_adm_google_stringmatchingconcat(open_table_mtsingkatanadm, open_table_stringmatchingconcat):
	dic = {}
	sql2 = fetch_mtsingkatanadm(open_table_mtsingkatanadm)
	q2 = fetch(sql2)
	for row in q2:
		a = row[1]
		b = row[0]
		dic[a]=b
	sql = fetch_singkatan_adm_google_stringmatchingconcat(open_table_stringmatchingconcat)
	q = fetch(sql)
	for row in q:
		idx = row[0]
		adm = row[1]
		adm = adm.replace('.',' ').replace('-',' ').replace('(',' ').replace(')',' ').replace('"',' ').replace('/',' ').replace(':',' ').replace('*',' ').replace('+',' ').replace('[',' ').replace(']',' ').replace(',',' , ') 
		hasil = replace_all2(dic,adm)
		hasil = hasil.replace('KOTA ',' ').replace('DESA ',' ').replace('KEL ',' ').replace('KEC ',' ').replace('KAB ',' ').replace('PROV ',' ').replace('KABUPATEN',' ')
		hasil = re.sub('\s+',' ',hasil).strip()
		sql2 = '''update %s set adm_google_bersih = '%s' where id = %s''' % (open_table_stringmatchingconcat, hasil, idx)
		execScalar(sql2)
	print("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (COLUMN ADM_GOOGLE_BERSIH)\n")


#Untuk memecah admawal dengan admreverse yang ada didalam adm_google_bersih
def split_adm_google_stringmatchingconcat(open_table_stringmatchingconcat):
	sql = fetch_singkatan_adm_google_stringmatchingconcatt(open_table_stringmatchingconcat)
	q = fetch(sql)
	for row in q:
		idx = row[0]
		adm_google_bersih2 = row[1]
		adm_google_bersih2 = adm_google_bersih2.split(" | ")
		adm_google_awal_bersih = adm_google_bersih2[0]
		adm_google_reverse_bersih = adm_google_bersih2[1]
		sql2 = update_admgooglereversebersih(open_table_stringmatchingconcat, adm_google_reverse_bersih, idx)
		execScalar(sql2)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (COLUMN ADM_GOOGLE_REVERSE_BERSIH)\n")


#Untuk mengecek kata per kata yang ada di dalam adm_google_reverse_bersih ke dalam adm_awal_bersih
#Ket: Matching Adm Cara IV (membandingkan ori_vi/su/di/pr dan adm_google_vi/su/di/pr (ke satu2 adm)(sama persis))
def checkperwords_adm_google_stringmatchingconcat(open_table_stringmatchingconcat):
	sql = fetchadmgoogle(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		ket_match_vi = row[3]
		ket_match_su = row[4]
		ket_match_di = row[5]
		ket_match_pr = row[6]
		if (vi_awal == vi_rev) and (ket_match_vi == 'NOT MATCH') and (vi_awal != 'NONE ') and (vi_rev != 'NONE '):
			#print('vi',idx,'+',vi_awal,'+',vi_rev,"+MATCH")
			sql = ''' update %s set ket_matchvi = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		if (su_awal == su_rev) and (ket_match_su == 'NOT MATCH') and (su_awal != ' NONE ') and (su_rev != ' NONE '):
			#print('su',idx,'+',su_awal,'+',su_rev,"+MATCH")
			sql = ''' update %s set ket_matchsu = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		if (di_awal == di_rev) and (ket_match_di == 'NOT MATCH') and (di_awal != ' NONE ') and (di_rev != ' NONE '):
			#print('di',idx,'+',di_awal,'+',di_rev,"+MATCH")
			sql = ''' update %s set ket_matchdi = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		if (pr_awal == pr_rev) and (ket_match_pr == 'NOT MATCH') and (pr_awal != ' NONE') and (pr_rev != ' NONE'):
			#print('pr',idx,'+',pr_awal,'+',pr_rev,"+MATCH")
			sql = ''' update %s set ket_matchpr = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (KET_MATCHADM IV)\n")


#Untuk mengecek kata per kata yang ada di dalam adm_google_reverse_bersih ke dalam adm_awal_bersih
#Ket: Matching Adm Cara V (membandingkan ori_vi/su/di/pr dan adm_google_vi/su/di/pr (ke satu2 adm)(contains))
def checkperwords_adm_google_stringmatchingconcat2(open_table_stringmatchingconcat):
	sql = fetchadmgoogle2(open_table_stringmatchingconcat) 
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		ket_match_vi = row[3]
		ket_match_su = row[4]
		ket_match_di = row[5]
		ket_match_pr = row[6]
		if ((vi_rev in vi_awal) or (vi_awal in vi_rev)) and (ket_match_vi == 'NOT MATCH') and (vi_awal != 'NONE ') and (vi_rev != 'NONE '):
			#print('vi',idx,'+',vi_rev,'+',vi_awal,"+MATCH")
			sql = ''' update %s set ket_matchvi = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	sql = fetchadmgoogle3(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		ket_match_vi = row[3]
		ket_match_su = row[4]
		ket_match_di = row[5]
		ket_match_pr = row[6]
		if ((su_rev in su_awal) or (su_awal in su_rev)) and (ket_match_su == 'NOT MATCH') and (su_awal != ' NONE ') and (su_rev != ' NONE '):
			#print('su',idx,'+',su_rev,'+',su_awal,"+MATCH")
			sql = ''' update %s set ket_matchsu = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	sql = fetchadmgoogle4(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		ket_match_vi = row[3]
		ket_match_su = row[4]
		ket_match_di = row[5]
		ket_match_pr = row[6]
		if ((di_rev in di_awal) or (di_awal in di_rev)) and (ket_match_di == 'NOT MATCH') and (di_awal != ' NONE ') and (di_rev != ' NONE '):
			#print('di',idx,'+',di_rev,'+',di_awal,"+MATCH")
			sql = ''' update %s set ket_matchdi = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	sql = fetchadmgoogle5(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		ket_match_vi = row[3]
		ket_match_su = row[4]
		ket_match_di = row[5]
		ket_match_pr = row[6]
		if ((pr_rev in pr_awal) or (pr_awal in pr_rev)) and (ket_match_pr == 'NOT MATCH') and (pr_awal != ' NONE') and (pr_rev != ' NONE'):
			#print('pr',idx,'+',pr_rev,'+',pr_awal,"+MATCH")
			sql = ''' update %s set ket_matchpr = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (KET_MATCHADM V)\n")


#Untuk mengecek kata per kata yang ada di dalam adm_google_reverse_bersih ke dalam adm_awal_bersih
#Ket: Matching Adm Cara VI (membandingkan ori_vi/su/di/pr dan adm_google_vi/su/di/pr dengan menggunakan jaro similarity (ke satu2 adm))
def checkperwords_adm_google_stringmatchingconcat3(open_table_stringmatchingconcat):
	sql = fetchadmgoogle2(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		ket_match_vi = row[3]
		ket_match_su = row[4]
		ket_match_di = row[5]
		ket_match_pr = row[6]
		score_lev = jellyfish.jaro_winkler(vi_awal, vi_rev)
		if (score_lev >= 0.92) and (ket_match_vi == 'NOT MATCH') and (vi_awal != 'NONE ') and (vi_rev != 'NONE '):
			#print('vi','+',score_lev,'+',idx,'+',vi_rev,'+',vi_awal,"+MATCH")
			sql = ''' update %s set ket_matchvi = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	sql = fetchadmgoogle3(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		ket_match_vi = row[3]
		ket_match_su = row[4]
		ket_match_di = row[5]
		ket_match_pr = row[6]		
		score_lev2 = jellyfish.jaro_winkler(su_awal, su_rev)
		if (score_lev2 >= 0.92) and (ket_match_su == 'NOT MATCH') and (su_awal != ' NONE ') and (su_rev != ' NONE '):
			#print('su','+',score_lev,'+',idx,'+',su_rev,'+',su_awal,"+MATCH")
			sql = ''' update %s set ket_matchsu = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	sql = fetchadmgoogle4(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		ket_match_vi = row[3]
		ket_match_su = row[4]
		ket_match_di = row[5]
		ket_match_pr = row[6]	
		score_lev3 = jellyfish.jaro_winkler(di_awal, di_rev)
		if (score_lev3 >= 0.92) and (ket_match_di == 'NOT MATCH') and (di_awal != ' NONE ') and (di_rev != ' NONE '):
			#print('di','+',score_lev,'+',idx,'+',di_rev,'+',di_awal,"+MATCH")
			sql = ''' update %s set ket_matchdi = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	sql = fetchadmgoogle5(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		ket_match_vi = row[3]
		ket_match_su = row[4]
		ket_match_di = row[5]
		ket_match_pr = row[6]
		score_lev4 = jellyfish.jaro_winkler(pr_awal, pr_rev)
		if (score_lev4 >= 0.92) and (ket_match_pr == 'NOT MATCH') and (pr_awal != ' NONE') and (pr_rev != ' NONE'):
			#print('pr','+',score_lev,'+',idx,'+',pr_rev,'+',pr_awal,"+MATCH")
			sql = ''' update %s set ket_matchpr = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (KET_MATCHADM VI)\n")


#Untuk menarik data yang dibutuhkan dari stringmatchingconcat
#Untuk memasukkan data yang sudah ditarik ke dalam table yang sama tetapi kolom berbeda
def fetch_adm_data_google_stringmatchingconcat(open_table_stringmatchingconcat):
	sql = fetch_dataadm_stringmatchingconcat(open_table_stringmatchingconcat)
	data = fetch(sql)
	for row in data:
		idx = row[0]
		dataa_google = row[1] 
		sql2 = update_dataadm_stringmatchingconcat(open_table_stringmatchingconcat, dataa_google, idx)
		execScalar(sql2)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (COLUMN ADM_DATA_DAN_GOOGLE)\n") 


#Untuk mengubah singkatan yang ada di StringMatchingConcat dengan kata-kata yang sudah distandarisasi di dalam file DB_Singkatan
def ubah_singkatan_adm_data_google_stringmatchingconcat(open_table_mtsingkatanadm, open_table_stringmatchingconcat):
	dic = {}
	sql2 = fetch_mtsingkatanadm(open_table_mtsingkatanadm)
	q2 = fetch(sql2)
	for row in q2:
		a = row[1]
		b = row[0]
		dic[a]=b
	sql = fetch_singkatan_dataadm_stringmatchingconcat(open_table_stringmatchingconcat)
	q = fetch(sql)
	for row in q:
		idx = row[0]
		adm = row[1]
		adm = adm.replace('.',' ').replace('-',' ').replace('(',' ').replace(')',' ').replace('"',' ').replace('/',' ').replace(':',' ').replace('*',' ').replace('+',' ').replace('[',' ').replace(']',' ').replace(',',' , ') 
		hasil = replace_all2(dic,adm)
		hasil = hasil.replace('KOTA ',' ').replace('DESA ',' ').replace('KEL ',' ').replace('KEC ',' ').replace('KAB ',' ').replace('PROV ',' ').replace('KABUPATEN',' ')
		hasil = re.sub('\s+',' ',hasil).strip()
		sql2 = '''update %s set adm_data_dan_google_bersih = '%s' where id = %s''' % (open_table_stringmatchingconcat, hasil, idx)
		execScalar(sql2)
	print("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (COLUMN ADM_DATA_DAN_GOOGLE_BERSIH)\n")


#Untuk memecah admawal dengan admreverse yang ada didalam adm_data_dan_google_bersih
def split_adm_data_google_stringmatchingconcat(open_table_stringmatchingconcat):
	sql = fetch_singkatan_dataadm_stringmatchingconcatt(open_table_stringmatchingconcat)
	q = fetch(sql)
	for row in q:
		idx = row[0]
		adm_google_bersih2 = row[1]
		adm_google_bersih2 = adm_google_bersih2.split(" | ")
		adm_google_awal_bersih = adm_google_bersih2[0]
		adm_google_reverse_bersih = adm_google_bersih2[1]
		sql2 = update_dataadmreversebersih(open_table_stringmatchingconcat, adm_google_awal_bersih, idx)
		execScalar(sql2)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (COLUMN ADM_DATA_DAN_GOOGLE_AWAL_BERSIH)\n")


#Untuk mengecek kata per kata yang ada di dalam adm_reverse_bersih ke dalam adm_data_dan_google_awal_bersih
#Ket: Matching Adm Cara VII (membandingkan add+ori_vi/su/di/pr dan adm_vi/su/di/pr (ke satu2 adm)(contains))
def checkperwords_adm_data_google_stringmatchingconcat(open_table_stringmatchingconcat):
	sql = fetchgoogledataadm(open_table_stringmatchingconcat) 
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		ket_match_vi = row[3]
		ket_match_su = row[4]
		ket_match_di = row[5]
		ket_match_pr = row[6]
		if ((vi_rev in vi_awal) or (vi_awal in vi_rev)) and (ket_match_vi == 'NOT MATCH') and (vi_awal != 'NONE ') and (vi_rev != 'NONE '):
			#print('vi',idx,'+',vi_rev,'+',vi_awal,"+MATCH")
			sql = ''' update %s set ket_matchvi = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	sql = fetchdataadm2(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		ket_match_vi = row[3]
		ket_match_su = row[4]
		ket_match_di = row[5]
		ket_match_pr = row[6]
		if ((su_rev in su_awal) or (su_awal in su_rev)) and (ket_match_su == 'NOT MATCH') and (su_awal != ' NONE ') and (su_rev != ' NONE '):
			#print('su',idx,'+',su_rev,'+',su_awal,"+MATCH")
			sql = ''' update %s set ket_matchsu = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	sql = fetchdataadm3(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		ket_match_vi = row[3]
		ket_match_su = row[4]
		ket_match_di = row[5]
		ket_match_pr = row[6]
		if ((di_rev in di_awal) or (di_awal in di_rev)) and (ket_match_di == 'NOT MATCH') and (di_awal != ' NONE ') and (di_rev != ' NONE '):
			#print('di',idx,'+',di_rev,'+',di_awal,"+MATCH")
			sql = ''' update %s set ket_matchdi = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	sql = fetchdataadm4(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		ket_match_vi = row[3]
		ket_match_su = row[4]
		ket_match_di = row[5]
		ket_match_pr = row[6]
		if ((pr_rev in pr_awal) or (pr_awal in pr_rev)) and (ket_match_pr == 'NOT MATCH') and (pr_awal != ' NONE') and (pr_rev != ' NONE'):
			#print('pr',idx,'+',pr_rev,'+',pr_awal,"+MATCH")
			sql = ''' update %s set ket_matchpr = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (KET_MATCHADM VII)\n")


#Untuk mengecek kata per kata yang ada di dalam adm_google_reverse_bersih ke dalam adm_data_dan_google_awal_bersih
#Ket: Matching Adm Cara VII (membandingkan add+ori_vi/su/di/pr dan google_vi/su/di/pr (ke satu2 adm)(contains))
def checkperwords_adm_datagoogle_stringmatchingconcat(open_table_stringmatchingconcat):
	sql = fetchgoogledataadm(open_table_stringmatchingconcat) 
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		ket_match_vi = row[3]
		ket_match_su = row[4]
		ket_match_di = row[5]
		ket_match_pr = row[6]
		if ((vi_rev in vi_awal) or (vi_awal in vi_rev)) and (ket_match_vi == 'NOT MATCH') and (vi_awal != 'NONE ') and (vi_rev != 'NONE '):
			#print('vi',idx,'+',vi_rev,'+',vi_awal,"+MATCH")
			sql = ''' update %s set ket_matchvi = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	sql = fetchgoogledataadm2(open_table_stringmatchingconcat) 
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		ket_match_vi = row[3]
		ket_match_su = row[4]
		ket_match_di = row[5]
		ket_match_pr = row[6]
		if ((su_rev in su_awal) or (su_awal in su_rev)) and (ket_match_su == 'NOT MATCH') and (su_awal != ' NONE ') and (su_rev != ' NONE '):
			#print('su',idx,'+',su_rev,'+',su_awal,"+MATCH")
			sql = ''' update %s set ket_matchsu = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	sql = fetchgoogledataadm3(open_table_stringmatchingconcat) 
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		ket_match_vi = row[3]
		ket_match_su = row[4]
		ket_match_di = row[5]
		ket_match_pr = row[6]
		if ((di_rev in di_awal) or (di_awal in di_rev)) and (ket_match_di == 'NOT MATCH') and (di_awal != ' NONE ') and (di_rev != ' NONE '):
			#print('di',idx,'+',di_rev,'+',di_awal,"+MATCH")
			sql = ''' update %s set ket_matchdi = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	sql = fetchgoogledataadm4(open_table_stringmatchingconcat) 
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		adm_awal_bersih = row[1]
		adm_awal_bersih = adm_awal_bersih.split("^")
		vi_awal = adm_awal_bersih[0]
		su_awal = adm_awal_bersih[1]
		di_awal = adm_awal_bersih[2]
		pr_awal = adm_awal_bersih[3]
		adm_reverse_bersih = row[2]
		adm_reverse_bersih = adm_reverse_bersih.split("^")
		vi_rev = adm_reverse_bersih[0]
		su_rev = adm_reverse_bersih[1]
		di_rev = adm_reverse_bersih[2]
		pr_rev = adm_reverse_bersih[3]
		ket_match_vi = row[3]
		ket_match_su = row[4]
		ket_match_di = row[5]
		ket_match_pr = row[6]
		if ((pr_rev in pr_awal) or (pr_awal in pr_rev)) and (ket_match_pr == 'NOT MATCH') and (pr_awal != ' NONE') and (pr_rev != ' NONE'):
			#print('pr',idx,'+',pr_rev,'+',pr_awal,"+MATCH")
			sql = ''' update %s set ket_matchpr = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (KET_MATCHADM VIII)\n")
	print ("UPDATE DATA STRINGMATCHINGCONCAT (KET_MATCHADM) HAS FINISHED\n")


#untuk mejalankan keseluruhan fungsi yang ada di matchingadm.py
def main(open_table_stringmatchingconcat):
	open_table_mtsingkatanadm = 'mt_singkatanadm'
	##----- 1 (Matching ADM -> matching ori_vi/su/di/pr dengan adm_vi/su/di/pr)
	fetch_adm_stringmatchingconcat(open_table_stringmatchingconcat)
	ubah_singkatan_adm_stringmatchingconcat(open_table_mtsingkatanadm, open_table_stringmatchingconcat)
	split_adm_stringmatchingconcat(open_table_stringmatchingconcat)
	checkperwords_adm_stringmatchingconcat(open_table_stringmatchingconcat) 
	checkperwords_adm_stringmatchingconcat2(open_table_stringmatchingconcat)
	checkperwords_adm_stringmatchingconcat3(open_table_stringmatchingconcat)
	##----- 2 (Matching ADM -> matching ori_vi/su/di/pr dengan google_vi/su/di/pr)
	fetch_adm_google_stringmatchingconcat(open_table_stringmatchingconcat)
	ubah_singkatan_adm_google_stringmatchingconcat(open_table_mtsingkatanadm, open_table_stringmatchingconcat)
	split_adm_google_stringmatchingconcat(open_table_stringmatchingconcat)
	checkperwords_adm_google_stringmatchingconcat(open_table_stringmatchingconcat)
	checkperwords_adm_google_stringmatchingconcat2(open_table_stringmatchingconcat)
	checkperwords_adm_google_stringmatchingconcat3(open_table_stringmatchingconcat)
	##----- 3 (Matching ADM -> matching add+ori_vi/su/di/pr dengan adm_vi/su/di/pr)
	fetch_adm_data_google_stringmatchingconcat(open_table_stringmatchingconcat)
	ubah_singkatan_adm_data_google_stringmatchingconcat(open_table_mtsingkatanadm, open_table_stringmatchingconcat)
	split_adm_data_google_stringmatchingconcat(open_table_stringmatchingconcat)
	checkperwords_adm_data_google_stringmatchingconcat(open_table_stringmatchingconcat)
	##----- 4 (Matching ADM -> matching add+ori_vi/su/di/pr dengan google_vi/su/di/pr) 
	checkperwords_adm_datagoogle_stringmatchingconcat(open_table_stringmatchingconcat)