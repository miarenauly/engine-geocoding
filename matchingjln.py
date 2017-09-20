import time
import re
import jellyfish
import matchingadm
from data_prep import *
from active_record import *
from pgsql import *
from re import sub
from matchingadm import *


#untuk menupdate flag_matching yang ada di table_name
def update_kode_data(table_name):
	sql = updateKodeDataa(table_name)
	execScalar(sql)
	print ("UPDATE FLAG_MATCHING HAS FINISHED\n")


#untuk menupdate flag_matching yang ada di table_name
def update_kode_dataa(table_name):
	sql = updateKodeDataaa(table_name)
	execScalar(sql)
	print ("UPDATE FLAG_MATCHING HAS FINISHED\n")


#making table stringmatchingconcat
def making_table_stringmatchingconcat(open_table_stringmatchingconcat):
	sql = making_proc_table_stringmatchingconcat(open_table_stringmatchingconcat)
	execScalar(sql)
	print ("OUTPUT TB_STRINGMATCHINGCONCAT HAS CREATED\n")


#Untuk menarik data stringmatchingconcat yang dibutuhkan dari database
#Untuk memasukkan data yang sudah ditarik ke dalam table
def fetch_data_stringmatchingconcat(table_name, open_table_stringmatchingconcat):
	sql = fetch_stringmatchingconcat(table_name)
	data = fetch(sql)
	for row in data:
		idx = row[0]
		ori_namex = row[1]
		ori_addressx = row[2] 
		ori_vix = row[3] 
		ori_sux = row[4] 
		ori_dix = row[5] 
		ori_prx = row[6] 
		f_geocodex = row[7]
		g_addressx = row[8]
		place_namex = row[9] 
		google_vix = row[10] 
		google_sux = row[11] 
		google_dix = row[12] 
		google_prx = row[13] 
		adm_vix = row[14] 
		adm_sux = row[15] 
		adm_dix = row[16] 
		adm_prx = row[17] 
		f_matchingx = row[18]
		sql = ''' insert into %s(id, ori_name, ori_address, ori_vi, ori_su, ori_di, ori_pr, flag_geocode, google_address, place_name, google_vi, google_su, google_di, google_pr, adm_vi, adm_su, adm_di, adm_pr, flag_matching) values (%s, '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s') ''' % (open_table_stringmatchingconcat, idx, ori_namex, ori_addressx, ori_vix, ori_sux, ori_dix, ori_prx, f_geocodex, g_addressx, place_namex, google_vix, google_sux, google_dix, google_prx, adm_vix, adm_sux, adm_dix, adm_prx, f_matchingx)
		execScalar(sql)
		#sql2 = ''' update %s set ori_name = 'Null' where ori_name = 'None' ''' % (open_table_stringmatchingconcat)
		#execScalar(sql2)
	print ("INSERT DATA STRINGMATCHINGCONCAT HAS FINISHED\n")


#untuk menupdate flag_geocode yang ada di stringmatchingconcat
def update_kode_data2(open_table_stringmatchingconcat):
	sql = updateKodeDataa2(open_table_stringmatchingconcat)
	execScalar(sql)
	print ("UPDATE FLAG_MATCHING HAS FINISHED\n")


#untuk menupdate flag_geocode yang ada di stringmatchingconcat
def update_kode_data3(open_table_stringmatchingconcat):
	sql = updateKodeDataa3(open_table_stringmatchingconcat)
	execScalar(sql)
	print ("UPDATE FLAG_MATCHING HAS FINISHED\n")


#Untuk menarik data stringmatchingconcat yang dibutuhkan dari database
#Untuk memasukkan data yang sudah ditarik ke dalam table
def fetch_data_stringmatchingconcat2(open_table_stringmatchingconcat):
	sql = fetch_stringmatchingconcat2(open_table_stringmatchingconcat)
	data = fetch(sql)
	for row in data:
		idx = row[0]
		dataa = row[1] 
		sql = update_stringmatchingconcat2(open_table_stringmatchingconcat, dataa, idx)
		execScalar(sql)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (COLUMN DATA)\n")


#Untuk mengubah key menjadi value di dalam penggunaan dictionary (Kalau di Perl, dictionary = hash)
def replace_all(repls, str):                                    
    return re.sub('|'.join(re.escape(key) for key in repls.keys()), lambda k: repls[k.group(0)], str)


#Untuk mengubah singkatan yang ada di StringMatchingConcat dengan kata-kata yang sudah distandarisasi di dalam file DB_Singkatan
def ubah_singkatan_stringmatchingconcat(open_table_mtsingkatan, open_table_stringmatchingconcat):
	dic = {}
	sql2 = fetch_mtsingkatan(open_table_mtsingkatan)
	q2 = fetch(sql2)
	for row in q2:
		a = row[1]
		b = row[0]
		dic[a]=b
	sql = fetch_singkatan_stringmatchingconcat(open_table_stringmatchingconcat)
	q = fetch(sql)
	for row in q:
		idx = row[0]
		address = row[1]
		address = address.replace('.',' ').replace('-',' ').replace('(',' ').replace(')',' ').replace('"',' ').replace('/',' ').replace(':',' ').replace('*',' ').replace('+',' ').replace('[',' ').replace(']',' ').replace(',',' , ')
		address = address.replace(' RT ',' ').replace(' RW ',' ').replace(' NO ',' ').replace(' DESA ',' ').replace(' TOKO ',' ').replace('MALL',' ').replace('KIOS',' ')
		address = re.sub('[0-9]+',' ',address).strip()
		address = re.sub('\s+',' ',address).strip()
		hasil = replace_all(dic,address)
		hasil = re.sub('\s+',' ',hasil).strip()
		sql2 = '''update %s set data_bersih = '%s' where id = %s''' % (open_table_stringmatchingconcat, hasil, idx)
		execScalar(sql2)
	print("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (COLUMN DATA_BERSIH)\n")


#Untuk memecah stringawal dengan stringreverse yang ada didalam stringmatchingconcat
def split_stringmatchingconcat(open_table_stringmatchingconcat):
	sql = fetch_singkatan_stringmatchingconcatt(open_table_stringmatchingconcat)
	q = fetch(sql)
	for row in q:
		idx = row[0]
		address_bersih = row[1]
		address_bersih = address_bersih.split("^|")
		address_awal_bersih = address_bersih[0]
		address_reverse_bersih = address_bersih[1]
		sql = update_addressawalbersih(open_table_stringmatchingconcat, address_awal_bersih, idx)
		execScalar(sql)
		sql2 = update_addressreversebersih(open_table_stringmatchingconcat, address_reverse_bersih, idx)
		execScalar(sql2)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (COLUMN ADDRESS_AWAL_BERSIH DAN ADDRESS_REVERSE_BERSIH)\n")


#Untuk mengecek kata per kata di dalam address_reverse_bersih ke dalam address_awal_bersih
#Ket: Matching Jalan Cara I (membandingkan ori_address dengan google_address)
def checkperwords_stringmatchingconcat(open_table_stringmatchingconcat):
	sql = fetcha(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		address_awal_bersih = row[1]
		address_reverse_bersih = row[2]
		address_awal_bersih = address_awal_bersih.replace(',','')
		address_awal_bersih = re.sub('\s+',' ',address_awal_bersih).strip()
		address_reverse_bersih = address_reverse_bersih.replace(',','')
		address_reverse_bersih = re.sub('\s+',' ',address_reverse_bersih).strip()
		list1 = []
		if (" " not in address_awal_bersih):
			list1.append(str(idx)+'|')
		elif (" " in address_awal_bersih):
			address_awal_bersih = address_awal_bersih.split(" ")
			list1.append(str(idx)+'|')
			for rows in address_awal_bersih:
				if (rows in address_reverse_bersih) and (("JL " in address_reverse_bersih) or ("PASAR " in address_reverse_bersih)):
					list1.append(rows)
				else:
					list1.append(" ")
		list_join = ' '.join(list1)
		list_join = re.sub('\s+',' ',list_join).strip()
		#print(list_join)
		list_split=list_join.split('|')
		idq = list_split[0]
		address_samaq = list_split[1]
		address_samaq = re.sub('\s+',' ',address_samaq).strip()
		address_awal_bersih = ' '.join([str(item) for item in address_awal_bersih])
		address_awal_bersih = re.sub('\s+',' ',address_awal_bersih).strip()
		#print(address_samaq)
		#print(type(address_samaq))
		#print(idq,'+',address_samaq,'+',address_awal_bersih)
		#print(address_awal_bersih)
		if ((address_samaq in address_awal_bersih) and (address_awal_bersih == 'J L')):
			#print(idq,address_awal_bersih,address_samaq,"NOT MATCH")
			sql = ''' update %s set ket_matchjln = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idq)
			execScalar(sql)
		elif ((address_samaq in address_awal_bersih) and (address_samaq == '')):
			#print(idq,address_awal_bersih,address_samaq,"NOT MATCH")
			sql = ''' update %s set ket_matchjln = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idq)
			execScalar(sql)
		elif ((address_samaq in address_awal_bersih) and ((address_samaq == 'JL') or (address_samaq == 'JL '))):
			#print(idq,address_awal_bersih,address_samaq,"NOT MATCH")
			sql = ''' update %s set ket_matchjln = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idq)
			execScalar(sql)
		elif ((address_samaq in address_awal_bersih) and ('JL ' not in address_awal_bersih)):
			#print(idq,address_awal_bersih,address_samaq,"NOT MATCH")
			sql = ''' update %s set ket_matchjln = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idq)
			execScalar(sql)
		elif ((address_samaq in address_awal_bersih) and (address_awal_bersih != 'J L') and (address_samaq != '') and (address_samaq != 'JL') and (address_samaq != 'JL ')):
			#print(idq,address_awal_bersih,address_samaq,"MATCH")
			sql = ''' update %s set ket_matchjln = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idq)
			execScalar(sql)
		else:
			#print(idq,address_awal_bersih,address_samaq,"NOT MATCH")
			sql = ''' update %s set ket_matchjln = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idq)
			execScalar(sql)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (KET_MATCHJLN I)\n")


#Untuk mengecek kata per kata di dalam address_reverse_bersih ke dalam address_awal_bersih
#Ket: Matching Jalan Cara II (membandingkan ori_address dengan google_address + memotong address sama menjadi 3 kata saja)
def checkperwords_stringmatchingconcat2(open_table_stringmatchingconcat):
	sql2 = fetchaa(open_table_stringmatchingconcat)
	data2 = fetch(sql2)
	for row in data2:
		idx = row[0]
		address_awal_bersih = row[1]
		address_reverse_bersih = row[2]
		address_awal_bersih = address_awal_bersih.replace(',','')
		address_awal_bersih = re.sub('\s+',' ',address_awal_bersih).strip()
		address_reverse_bersih = address_reverse_bersih.replace(',','')
		address_reverse_bersih = re.sub('\s+',' ',address_reverse_bersih).strip()
		list1 = []
		if (" " not in address_awal_bersih):
			list1.append(str(idx)+'|')
		elif (" " in address_awal_bersih):
			address_awal_bersih = address_awal_bersih.split(" ")
			list1.append(str(idx)+'|')
			for rows in address_awal_bersih:
				if (rows in address_reverse_bersih) and (("JL " in address_reverse_bersih) or ("PASAR " in address_reverse_bersih)):
					list1.append(rows)
				else:
					list1.append(" ")
		list_join = ' '.join(list1)
		list_join = re.sub('\s+',' ',list_join).strip()
		#print(list_join)
		list_split=list_join.split('|')
		idq = list_split[0]
		address_samaq = list_split[1]
		address_samaq = re.sub('\s+',' ',address_samaq).strip()
		address_awal_bersih = ' '.join([str(item) for item in address_awal_bersih])
		address_awal_bersih = re.sub('\s+',' ',address_awal_bersih).strip()
		if (len(address_samaq.split()) > 3):
			address_samaq = address_samaq.split()[:3]
			address_samaq = ' '.join(address_samaq)
			address_samaq = re.sub('\s+',' ',address_samaq).strip()
		if ((address_samaq in address_awal_bersih) and (address_awal_bersih == 'J L')):
			#print(idq,address_awal_bersih,address_samaq,"NOT MATCH")
			sql = ''' update %s set ket_matchjln = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idq)
			execScalar(sql)
		elif ((address_samaq in address_awal_bersih) and (address_samaq == '')):
			#print(idq,address_awal_bersih,address_samaq,"NOT MATCH")
			sql = ''' update %s set ket_matchjln = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idq)
			execScalar(sql)
		elif ((address_samaq in address_awal_bersih) and ((address_samaq == 'JL') or (address_samaq == 'JL '))):
			#print(idq,address_awal_bersih,address_samaq,"NOT MATCH")
			sql = ''' update %s set ket_matchjln = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idq)
			execScalar(sql)
		elif ((address_samaq in address_awal_bersih) and ('JL ' not in address_awal_bersih)):
			#print(idq,address_awal_bersih,address_samaq,"NOT MATCH")
			sql = ''' update %s set ket_matchjln = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idq)
			execScalar(sql)
		elif ((address_samaq in address_awal_bersih) and (address_awal_bersih != 'J L') and (address_samaq != '') and (address_samaq != 'JL') and (address_samaq != 'JL ')):
			#print(idq,address_awal_bersih,address_samaq,"MATCH")
			sql = ''' update %s set ket_matchjln = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idq)
			execScalar(sql)
		else:
			#print(idq,address_awal_bersih,address_samaq,"NOT MATCH")
			sql = ''' update %s set ket_matchjln = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idq)
			execScalar(sql)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (KET_MATCHJLN II)\n")


#Untuk mengecek kata per kata di dalam address_reverse_bersih ke dalam address_awal_bersih
#Ket: Matching Jalan Cara III (membandingkan ori_address dengan google_address dengan memotong ori_address dan google_address menjadi 3 kata dan menghitung similaritynya menggunakan jaro)
def checkperwords_stringmatchingconcat3(open_table_stringmatchingconcat):
	sql = fetchaa(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		address_awal_bersih = row[1]
		address_reverse_bersih = row[2]
		address_awal_bersih = address_awal_bersih.replace(',','')
		address_awal_bersih = re.sub('\s+',' ',address_awal_bersih).strip()
		address_reverse_bersih = address_reverse_bersih.replace(',','')
		address_reverse_bersih = re.sub('\s+',' ',address_reverse_bersih).strip()
		if (len(address_awal_bersih.split()) > 3):
			address_awal_bersih = address_awal_bersih.split()[:3]
			address_awal_bersih = ' '.join(address_awal_bersih)
			address_awal_bersih = re.sub('\s+',' ',address_awal_bersih).strip()
			#print(address_awal_bersih)
		if (len(address_reverse_bersih.split()) > 3):
			address_reverse_bersih = address_reverse_bersih.split()[:3]
			address_reverse_bersih = ' '.join(address_reverse_bersih)
			address_reverse_bersih = re.sub('\s+',' ',address_reverse_bersih).strip()
			#print(address_reverse_bersih)
		score_lev = jellyfish.jaro_winkler(address_awal_bersih, address_reverse_bersih)
		if (score_lev >= 0.92):
			#print(idx,address_awal_bersih,address_reverse_bersih,score_lev)
			sql = ''' update %s set ket_matchjln = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (KET_MATCHJLN III)\n")


#Untuk menarik data stringmatchingconcat yang dibutuhkan dari database
#Untuk memasukkan data yang sudah ditarik ke dalam table
def fetch_data_stringmatchingconcat3(open_table_stringmatchingconcat):
	sql = fetch_stringmatchingconcat3(open_table_stringmatchingconcat)
	data = fetch(sql)
	for row in data:
		idx = row[0]
		dataa_nama = row[1] 
		sql = update_stringmatchingconcat3(open_table_stringmatchingconcat, dataa_nama, idx)
		execScalar(sql)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (COLUMN DATA_NAMA)\n")


#Untuk mengubah singkatan yang ada di StringMatchingConcat dengan kata-kata yang sudah distandarisasi di dalam file DB_Singkatan
def ubah_singkatan_stringmatchingconcat2(open_table_mtsingkatanpoi, open_table_stringmatchingconcat):
	dic = {}
	sql2 = fetch_mtsingkatanpoi(open_table_mtsingkatanpoi)
	q2 = fetch(sql2)
	for row in q2:
		a = row[1]
		b = row[0]
		dic[a]=b
	sql = fetch_singkatan_stringmatchingconcat2(open_table_stringmatchingconcat)
	q = fetch(sql)
	for row in q:
		idx = row[0]
		data_nama = row[1]
		data_nama = data_nama.replace('.',' ').replace('-',' ').replace('(',' ').replace(')',' ').replace('"',' ').replace('/',' ').replace(':',' ').replace('*',' ').replace('+',' ').replace('[',' ').replace(']',' ').replace(',',' , ')
		data_nama = re.sub('\s+',' ',data_nama).strip()
		hasil = replace_all(dic,data_nama)
		hasil = re.sub('\s+',' ',hasil).strip()
		sql2 = '''update %s set data_nama_bersih = '%s' where id = %s''' % (open_table_stringmatchingconcat, hasil, idx)
		execScalar(sql2)
	print("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (COLUMN DATA_NAMA_BERSIH)\n")


#Untuk memecah stringawal dengan stringreverse yang ada didalam stringmatchingconcat
def split_stringmatchingconcat2(open_table_stringmatchingconcat):
	sql = fetch_singkatan_z(open_table_stringmatchingconcat)
	q = fetch(sql)
	for row in q:
		idx = row[0]
		data_nama_bersih = row[1]
		data_nama_bersih = data_nama_bersih.split("^|")
		data_nama_awal_bersih = data_nama_bersih[0]
		data_nama_reverse_bersih = data_nama_bersih[1]
		data_nama_reverse_bersih = re.sub('\s+',' ',data_nama_reverse_bersih).strip()
		sql = update_addressawalbersih2(open_table_stringmatchingconcat, data_nama_awal_bersih, idx)
		execScalar(sql)
		sql2 = update_addressreversebersih2(open_table_stringmatchingconcat, data_nama_reverse_bersih, idx)
		execScalar(sql2)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (COLUMN ADDRESS_AWAL_BERSIH DAN ADDRESS_REVERSE_BERSIH)\n")


#Untuk mengecek kata per kata di dalam data_nama_reverse_bersih ke dalam data_nama_awal_bersih
#Ket: Matching Jalan Cara IV (membandingkan ori_name dengan place_name)
def checkperwords_stringmatchingconcat4(open_table_stringmatchingconcat):
	sql = fetcha2(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		data_nama_awal_bersih = row[1]
		data_nama_reverse_bersih = row[2]
		data_nama_awal_bersih = data_nama_awal_bersih.replace(',','')
		data_nama_awal_bersih = re.sub('\s+',' ',data_nama_awal_bersih).strip()
		data_nama_reverse_bersih = data_nama_reverse_bersih.replace(',','')
		data_nama_reverse_bersih = re.sub('\s+',' ',data_nama_reverse_bersih).strip()
		if ((data_nama_awal_bersih == data_nama_reverse_bersih) and (data_nama_reverse_bersih != '')):
			#print(idx,data_nama_awal_bersih,data_nama_reverse_bersih,"MATCH")
			sql = ''' update %s set ket_matchjln = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		elif ((data_nama_awal_bersih == data_nama_reverse_bersih) and (data_nama_reverse_bersih == '')):
			#print(idx,data_nama_awal_bersih,data_nama_reverse_bersih,"NOT MATCH")
			sql = ''' update %s set ket_matchjln = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
		else:
			#print(idx,data_nama_awal_bersih,data_nama_reverse_bersih,"NOT MATCH")
			sql = ''' update %s set ket_matchjln = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (KET_MATCHJLN IV)\n")


#Untuk mengecek kata per kata di dalam data_nama_reverse_bersih ke dalam data_nama_awal_bersih
#Ket: Matching Jalan Cara V (membandingkan ori_name dengan place_name dengan menghitung similaritynya menggunakan jaro)
def checkperwords_stringmatchingconcat5(open_table_stringmatchingconcat):
	sql = fetcha2(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		data_nama_awal_bersih = row[1]
		data_nama_reverse_bersih = row[2]
		data_nama_awal_bersih = data_nama_awal_bersih.replace(',','')
		data_nama_awal_bersih = re.sub('\s+',' ',data_nama_awal_bersih).strip()
		data_nama_reverse_bersih = data_nama_reverse_bersih.replace(',','')
		data_nama_reverse_bersih = re.sub('\s+',' ',data_nama_reverse_bersih).strip()
		score_lev = jellyfish.jaro_winkler(data_nama_awal_bersih, data_nama_reverse_bersih)
		if (score_lev >= 0.92):
			#print(idx,data_nama_awal_bersih,data_nama_reverse_bersih,score_lev)
			sql = ''' update %s set ket_matchjln = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idx)
			execScalar(sql)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (KET_MATCHJLN V)\n")


#Untuk mengecek kata per kata di dalam data_nama_reverse_bersih ke dalam data_nama_awal_bersih
#Ket: Matching Jalan Cara V (membandingkan ori_name dengan place_name dengan menghitung jumlah kata yang sama dengan menghitung jumlah kata yang ada di data_nama_reverse_bersih)
def checkperwords_stringmatchingconcat6(open_table_stringmatchingconcat):
	sql = fetcha2(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		data_nama_awal_bersih = row[1]
		data_nama_reverse_bersih = row[2]
		data_nama_awal_bersih = data_nama_awal_bersih.replace(',','')
		data_nama_awal_bersih = re.sub('\s+',' ',data_nama_awal_bersih).strip()
		data_nama_reverse_bersih = data_nama_reverse_bersih.replace(',','')
		data_nama_reverse_bersih = re.sub('\s+',' ',data_nama_reverse_bersih).strip()
		list1 = []
		if (" " not in data_nama_awal_bersih):
			list1.append(str(idx)+'|')
		elif (" " in data_nama_awal_bersih):
			data_nama_awal_bersih = data_nama_awal_bersih.split(" ")
			list1.append(str(idx)+'|')
			for rows in data_nama_awal_bersih:
				if ((rows in data_nama_reverse_bersih)):
					list1.append(rows)
				else:
					list1.append(" ")
		list_join = ' '.join(list1)
		list_join = re.sub('\s+',' ',list_join).strip()
		#print(list_join)
		list_split=list_join.split('|')
		idq = list_split[0]
		address_samaq = list_split[1]
		address_samaq = re.sub('\s+',' ',address_samaq).strip()
		data_nama_awal_bersih = ' '.join([str(item) for item in data_nama_awal_bersih])
		data_nama_awal_bersih = re.sub('\s+',' ',data_nama_awal_bersih).strip()
		if (((len(data_nama_reverse_bersih.split()) == len(address_samaq.split())) or (len(data_nama_awal_bersih.split()) == len(address_samaq.split()))) and (("SMP " in data_nama_reverse_bersih) or ("SMA " in data_nama_reverse_bersih) or ("SD " in data_nama_reverse_bersih)) and (("SMP " in data_nama_awal_bersih) or ("SMA " in data_nama_awal_bersih) or ("SD " in data_nama_awal_bersih))):
			#print(idq,data_nama_reverse_bersih,address_samaq,"MATCH")
			sql = ''' update %s set ket_matchjln = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idq)
			execScalar(sql)
		else:
			#print(idq,data_nama_reverse_bersih,address_samaq,"NOT MATCH")
			sql = ''' update %s set ket_matchjln = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idq)
			execScalar(sql)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (KET_MATCHJLN VI)\n")


#Untuk menarik data stringmatchingconcat yang dibutuhkan dari database
#Untuk memasukkan data yang sudah ditarik ke dalam table
def fetch_data_stringmatchingconcat4(open_table_stringmatchingconcat):
	sql = fetch_stringmatchingconcat4(open_table_stringmatchingconcat)
	data = fetch(sql)
	for row in data:
		idx = row[0]
		dataa_nama = row[1] 
		sql = update_stringmatchingconcat4(open_table_stringmatchingconcat, dataa_nama, idx)
		execScalar(sql)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (COLUMN DATA_NAMA_DAN_PLACE)\n")


#Untuk mengubah singkatan yang ada di StringMatchingConcat dengan kata-kata yang sudah distandarisasi di dalam file DB_Singkatan
def ubah_singkatan_stringmatchingconcat3(open_table_mtsingkatanpoi, open_table_stringmatchingconcat):
	dic = {}
	sql2 = fetch_mtsingkatanpoi(open_table_mtsingkatanpoi)
	q2 = fetch(sql2)
	for row in q2:
		a = row[1]
		b = row[0]
		dic[a]=b
	sql = fetch_singkatan_stringmatchingconcat3(open_table_stringmatchingconcat)
	q = fetch(sql)
	for row in q:
		idx = row[0]
		data_nama = row[1]
		data_nama = data_nama.replace('.',' ').replace('-',' ').replace('(',' ').replace(')',' ').replace('"',' ').replace('/',' ').replace(':',' ').replace('*',' ').replace('+',' ').replace('[',' ').replace(']',' ').replace(',',' , ')
		data_nama = re.sub('\s+',' ',data_nama).strip()
		hasil = replace_all(dic,data_nama)
		hasil = re.sub('\s+',' ',hasil).strip()
		sql2 = '''update %s set data_nama_dan_place_bersih = '%s' where id = %s''' % (open_table_stringmatchingconcat, hasil, idx)
		execScalar(sql2)
	print("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (COLUMN DATA_NAMA_DAN_PLACE_BERSIH)\n")


#Untuk memecah stringawal dengan stringreverse yang ada didalam stringmatchingconcat
def split_stringmatchingconcat3(open_table_stringmatchingconcat):
	sql = fetch_singkatan_z2(open_table_stringmatchingconcat)
	q = fetch(sql)
	for row in q:
		idx = row[0]
		data_nama_bersih = row[1]
		data_nama_bersih = data_nama_bersih.split("^|")
		data_nama_awal_bersih = data_nama_bersih[0]
		data_nama_reverse_bersih = data_nama_bersih[1]
		data_nama_reverse_bersih = re.sub('\s+',' ',data_nama_reverse_bersih).strip()
		sql = update_addressawalbersih3(open_table_stringmatchingconcat, data_nama_awal_bersih, idx)
		execScalar(sql)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (COLUMN DATA_NAMA_DAN_PLACE_AWAL_BERSIH)\n")


#Untuk mengecek kata per kata di dalam data_nama_reverse_bersih ke dalam data_nama_dan_place_awal_bersih
#Ket: Matching Jalan Cara V (membandingkan ori_name dengan place_name dengan menghitung jumlah kata yang sama dengan menghitung jumlah kata yang ada di data_nama_reverse_bersih)
def checkperwords_stringmatchingconcat7(open_table_stringmatchingconcat):
	sql = fetcha3(open_table_stringmatchingconcat)
	data2 = fetch(sql)
	for row in data2:
		idx = row[0]
		data_nama_awal_bersih = row[1]
		data_nama_reverse_bersih = row[2]
		data_nama_awal_bersih = data_nama_awal_bersih.replace(',','')
		data_nama_awal_bersih = re.sub('\s+',' ',data_nama_awal_bersih).strip()
		data_nama_reverse_bersih = data_nama_reverse_bersih.replace(',','')
		data_nama_reverse_bersih = re.sub('\s+',' ',data_nama_reverse_bersih).strip()
		list1 = []
		if (" " not in data_nama_awal_bersih):
			list1.append(str(idx)+'|')
		elif (" " in data_nama_awal_bersih):
			data_nama_awal_bersih = data_nama_awal_bersih.split(" ")
			list1.append(str(idx)+'|')
			for rows in data_nama_awal_bersih:
				if ((rows in data_nama_reverse_bersih)):
					list1.append(rows)
				else:
					list1.append(" ")
		list_join = ' '.join(list1)
		list_join = re.sub('\s+',' ',list_join).strip()
		#print(list_join)
		list_split=list_join.split('|')
		idq = list_split[0]
		address_samaq = list_split[1]
		address_samaq = re.sub('\s+',' ',address_samaq).strip()
		data_nama_awal_bersih = ' '.join([str(item) for item in data_nama_awal_bersih])
		data_nama_awal_bersih = re.sub('\s+',' ',data_nama_awal_bersih).strip()
		if (((len(data_nama_reverse_bersih.split()) == len(address_samaq.split())) or (len(data_nama_awal_bersih.split()) == len(address_samaq.split()))) and (("SMP " in data_nama_reverse_bersih) or ("SMA " in data_nama_reverse_bersih) or ("SD " in data_nama_reverse_bersih)) and (("SMP " in data_nama_awal_bersih) or ("SMA " in data_nama_awal_bersih) or ("SD " in data_nama_awal_bersih))):
			#print(idq,data_nama_reverse_bersih,address_samaq,"MATCH")
			sql = ''' update %s set ket_matchjln = 'MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idq)
			execScalar(sql)
		else:
			#print(idq,data_nama_reverse_bersih,address_samaq,"NOT MATCH")
			sql = ''' update %s set ket_matchjln = 'NOT MATCH' where id = %s ''' % (open_table_stringmatchingconcat, idq)
			execScalar(sql)
	print ("UPDATE DATA STRINGMATCHINGCONCAT HAS FINISHED (KET_MATCHJLN VI)\n")
	print ("UPDATE DATA STRINGMATCHINGCONCAT (KET_MATCHJLN) HAS FINISHED\n")


#join hasil dari stringmatchingconcat ke dalam table_name
def join_table_stringmatchingconcat_tablename(table_name, open_table_stringmatchingconcat):
	sql = join_table_stringmatchingconcat(table_name, open_table_stringmatchingconcat)
	execScalar(sql)
	print ("UPDATE TABLE_NAME HAS FINISHED (KET_MATCHJLN)\n")


#join hasil dari stringmatchingconcat ke dalam table_name
def join_tableadm_stringmatchingconcat_tablename(table_name, open_table_stringmatchingconcat):
	sql = join_table_adm_stringmatchingconcat(table_name, open_table_stringmatchingconcat)
	execScalar(sql)
	sql2 = join_table_adm_stringmatchingconcat2(table_name, open_table_stringmatchingconcat)
	execScalar(sql2)
	sql3 = join_table_adm_stringmatchingconcat3(table_name, open_table_stringmatchingconcat)
	execScalar(sql3)
	sql4 = join_table_adm_stringmatchingconcat4(table_name, open_table_stringmatchingconcat)
	execScalar(sql4)
	sql5 = join_table_adm_stringmatchingconcat5(table_name, open_table_stringmatchingconcat)
	execScalar(sql5)
	print ("UPDATE TABLE_NAME HAS FINISHED (KET_MATCHVI, KET_MATCHSU, KET_MATCHDI, KET_MATCHPR, FLAG_MATCHING)\n")


#untuk memasukkan kategori summary dan summary detail ke dalam table_name
def summary(table_name):
	sql = fetch_stringmatchingconcat5(table_name)
	data = fetch(sql)
	for row in data:
		idx = row[0]
		vi = row[1] 
		su = row[2] 
		di = row[3] 
		pr = row[4] 
		jln = row[5] 
		ket = row[6]
		flag_matching = row[7]
		if (ket == 'ERROR') and (flag_matching == 'P'):
			#print(idx,'+ LOW + ALL NOT MATCH')
			sql = ''' update %s set summary = 'LOW', summary_detail = 'ALL NOT MATCH' where keterangan = 'ERROR' and flag_matching = 'P' ''' % (table_name)
			execScalar(sql)
		if (jln == 'NOT MATCH') and (vi == 'MATCH') and (su == 'NOT MATCH') and (di == 'NOT MATCH') and (ket == 'CENTROID') and (flag_matching == 'P'):
			#print(idx,'+ LOW + CENTROID KEL')
			sql = ''' update %s set summary = 'LOW', summary_detail = 'CENTROID KEL' where match_jln = 'NOT MATCH' and match_vi = 'MATCH' and match_su = 'NOT MATCH' and match_di = 'NOT MATCH' and keterangan = 'CENTROID' and flag_matching = 'P' ''' % (table_name)
			execScalar(sql)
		if (jln == 'NOT MATCH') and (vi == 'MATCH') and (su == 'MATCH') and (di == 'NOT MATCH') and (ket == 'CENTROID') and (flag_matching == 'P'):
			#print(idx,'+ LOW + CENTROID KEL')
			sql = ''' update %s set summary = 'LOW', summary_detail = 'CENTROID KEL' where match_jln = 'NOT MATCH' and match_vi = 'MATCH' and match_su = 'MATCH' and match_di = 'NOT MATCH' and keterangan = 'CENTROID' and flag_matching = 'P' ''' % (table_name)
			execScalar(sql)
		if (jln == 'NOT MATCH') and (vi == 'MATCH') and (su == 'NOT MATCH') and (di == 'MATCH') and (ket == 'CENTROID') and (flag_matching == 'P'):
			#print(idx,'+ LOW + CENTROID KEL')
			sql = ''' update %s set summary = 'LOW', summary_detail = 'CENTROID KEL' where match_jln = 'NOT MATCH' and match_vi = 'MATCH' and match_su = 'NOT MATCH' and match_di = 'MATCH' and keterangan = 'CENTROID' and flag_matching = 'P' ''' % (table_name)
			execScalar(sql)
		if (jln == 'NOT MATCH') and (vi == 'MATCH') and (su == 'MATCH') and (di == 'MATCH') and (ket == 'CENTROID') and (flag_matching == 'P'):
			#print(idx,'+ LOW + CENTROID KEL')
			sql = ''' update %s set summary = 'LOW', summary_detail = 'CENTROID KEL' where match_jln = 'NOT MATCH' and match_vi = 'MATCH' and match_su = 'MATCH' and match_di = 'MATCH' and keterangan = 'CENTROID' and flag_matching = 'P' ''' % (table_name)
			execScalar(sql)
		if (jln == 'NOT MATCH') and (vi == 'NOT MATCH') and (su == 'MATCH') and (di == 'NOT MATCH') and (ket == 'CENTROID') and (flag_matching == 'P'):
			#print(idx,'+ LOW + CENTROID KEC')
			sql2 = ''' update %s set summary = 'LOW', summary_detail = 'CENTROID KEC' where match_vi = 'NOT MATCH' and match_su = 'MATCH' and match_di = 'NOT MATCH' and match_jln = 'NOT MATCH' and keterangan = 'CENTROID' and flag_matching = 'P' ''' % (table_name)
			execScalar(sql2)		
		if (jln == 'NOT MATCH') and (vi == 'NOT MATCH') and (su == 'MATCH') and (di == 'MATCH') and (ket == 'CENTROID') and (flag_matching == 'P'):
			#print(idx,'+ LOW + CENTROID KEC')
			sql2 = ''' update %s set summary = 'LOW', summary_detail = 'CENTROID KEC' where match_vi = 'NOT MATCH' and match_su = 'MATCH' and match_di = 'MATCH' and match_jln = 'NOT MATCH' and keterangan = 'CENTROID' and flag_matching = 'P' ''' % (table_name)
			execScalar(sql2)		
		if (jln == 'NOT MATCH') and (vi == 'NOT MATCH') and (su == 'NOT MATCH') and (di == 'MATCH') and (ket == 'CENTROID') and (flag_matching == 'P'):
			#print(idx,'+ LOW + CENTROID KAB')
			sql2 = ''' update %s set summary = 'LOW', summary_detail = 'CENTROID KAB' where match_vi = 'NOT MATCH' and match_su = 'NOT MATCH' and match_di = 'MATCH' and match_jln = 'NOT MATCH' and keterangan = 'CENTROID' and flag_matching = 'P' ''' % (table_name)
			execScalar(sql2)
		if (jln == 'NOT MATCH') and (vi == 'NOT MATCH') and (su == 'NOT MATCH') and (di == 'NOT MATCH') and (ket == 'CENTROID') and (flag_matching == 'P'):
			#print(idx,'+ LOW + ALL NOT MATCH')
			sql2 = ''' update %s set summary = 'LOW', summary_detail = 'ALL NOT MATCH' where match_vi = 'NOT MATCH' and match_su = 'NOT MATCH' and match_di = 'NOT MATCH' and match_jln = 'NOT MATCH' and keterangan = 'CENTROID' and flag_matching = 'P' ''' % (table_name)
			execScalar(sql2)
		if (jln == 'MATCH') and (vi == 'MATCH') and (su == 'NOT MATCH') and (di == 'NOT MATCH') and (ket != 'CENTROID') and (ket != 'ERROR') and ((ket == 'GOOGLE MAPS GEOCODING') or (ket == 'GOOGLE PLACES')) and (flag_matching == 'P'):
			#print(idx,'+ LOW + MATCH JALAN ONLY')
			sql2 = ''' update %s set summary = 'LOW', summary_detail = 'MATCH JALAN ONLY' where match_vi = 'MATCH' and match_su = 'NOT MATCH' and match_di = 'NOT MATCH' and match_jln = 'MATCH' and keterangan != 'CENTROID' and keterangan != 'ERROR' and ((keterangan = 'GOOGLE MAPS GEOCODING') or (keterangan = 'GOOGLE PLACES')) and flag_matching = 'P' ''' % (table_name)
			execScalar(sql2)	
		if (jln == 'MATCH') and (vi == 'NOT MATCH') and (su == 'MATCH') and (di == 'NOT MATCH') and (ket != 'CENTROID') and (ket != 'ERROR') and ((ket == 'GOOGLE MAPS GEOCODING') or (ket == 'GOOGLE PLACES')) and (flag_matching == 'P'):
			#print(idx,'+ LOW + MATCH JALAN ONLY')
			sql2 = ''' update %s set summary = 'LOW', summary_detail = 'MATCH JALAN ONLY' where match_vi = 'NOT MATCH' and match_su = 'MATCH' and match_di = 'NOT MATCH' and match_jln = 'MATCH' and keterangan != 'CENTROID' and keterangan != 'ERROR' and ((keterangan = 'GOOGLE MAPS GEOCODING') or (keterangan = 'GOOGLE PLACES')) and flag_matching = 'P' ''' % (table_name)
			execScalar(sql2)	
		if (jln == 'MATCH') and (vi == 'NOT MATCH') and (su == 'NOT MATCH') and (di == 'NOT MATCH') and (ket != 'CENTROID') and (ket != 'ERROR') and ((ket == 'GOOGLE MAPS GEOCODING') or (ket == 'GOOGLE PLACES')) and (flag_matching == 'P'):
			#print(idx,'+ LOW + MATCH JALAN ONLY')
			sql2 = ''' update %s set summary = 'LOW', summary_detail = 'MATCH JALAN ONLY' where match_vi = 'NOT MATCH' and match_su = 'NOT MATCH' and match_di = 'NOT MATCH' and match_jln = 'MATCH' and keterangan != 'CENTROID' and keterangan != 'ERROR' and ((keterangan = 'GOOGLE MAPS GEOCODING') or (keterangan = 'GOOGLE PLACES')) and flag_matching = 'P' ''' % (table_name)
			execScalar(sql2)
		if (jln == 'MATCH') and (vi == 'MATCH') and (su == 'MATCH') and (di == 'NOT MATCH') and (ket != 'CENTROID') and (ket != 'ERROR') and ((ket == 'GOOGLE MAPS GEOCODING') or (ket == 'GOOGLE PLACES')) and (flag_matching == 'P'):
			#print(idx,'+ HIGH + MATCH JALAN, MATCH KEL')
			sql2 = ''' update %s set summary = 'HIGH', summary_detail = 'MATCH JALAN, MATCH KEL' where match_vi = 'MATCH' and match_su = 'MATCH' and match_di = 'NOT MATCH' and match_jln = 'MATCH' and keterangan != 'CENTROID' and keterangan != 'ERROR' and ((keterangan = 'GOOGLE MAPS GEOCODING') or (keterangan = 'GOOGLE PLACES')) and flag_matching = 'P' ''' % (table_name)
			execScalar(sql2)
		if (jln == 'MATCH') and (vi == 'MATCH') and (su == 'NOT MATCH') and (di == 'MATCH') and (ket != 'CENTROID') and (ket != 'ERROR') and ((ket == 'GOOGLE MAPS GEOCODING') or (ket == 'GOOGLE PLACES')) and (flag_matching == 'P'):
			#print(idx,'+ HIGH + MATCH JALAN, MATCH KEL')
			sql2 = ''' update %s set summary = 'HIGH', summary_detail = 'MATCH JALAN, MATCH KEL' where match_vi = 'MATCH' and match_su = 'NOT MATCH' and match_di = 'MATCH' and match_jln = 'MATCH' and keterangan != 'CENTROID' and keterangan != 'ERROR' and ((keterangan = 'GOOGLE MAPS GEOCODING') or (keterangan = 'GOOGLE PLACES')) and flag_matching = 'P' ''' % (table_name)
			execScalar(sql2)
		if (jln == 'MATCH') and (vi == 'MATCH') and (su == 'MATCH') and (di == 'MATCH') and (ket != 'CENTROID') and (ket != 'ERROR') and ((ket == 'GOOGLE MAPS GEOCODING') or (ket == 'GOOGLE PLACES')) and (flag_matching == 'P'):
			#print(idx,'+ HIGH + MATCH JALAN, MATCH KEL')
			sql2 = ''' update %s set summary = 'HIGH', summary_detail = 'MATCH JALAN, MATCH KEL' where match_vi = 'MATCH' and match_su = 'MATCH' and match_di = 'MATCH' and match_jln = 'MATCH' and keterangan != 'CENTROID' and keterangan != 'ERROR' and ((keterangan = 'GOOGLE MAPS GEOCODING') or (keterangan = 'GOOGLE PLACES')) and flag_matching = 'P' ''' % (table_name)
			execScalar(sql2)
		if (jln == 'MATCH') and (vi == 'NOT MATCH') and (su == 'MATCH') and (di == 'MATCH') and (ket != 'CENTROID') and (ket != 'ERROR') and ((ket == 'GOOGLE MAPS GEOCODING') or (ket == 'GOOGLE PLACES')) and (flag_matching == 'P'):
			#print(idx,'+ HIGH + MATCH JALAN, MATCH KEC')
			sql2 = ''' update %s set summary = 'HIGH', summary_detail = 'MATCH JALAN, MATCH KEC' where match_vi = 'NOT MATCH' and match_su = 'MATCH' and match_di = 'MATCH' and match_jln = 'MATCH' and keterangan != 'CENTROID' and keterangan != 'ERROR' and ((keterangan = 'GOOGLE MAPS GEOCODING') or (keterangan = 'GOOGLE PLACES')) and flag_matching = 'P' ''' % (table_name)
			execScalar(sql2)			
		if (jln == 'MATCH') and (vi == 'NOT MATCH') and (su == 'NOT MATCH') and (di == 'MATCH') and (ket != 'CENTROID') and (ket != 'ERROR') and ((ket == 'GOOGLE MAPS GEOCODING') or (ket == 'GOOGLE PLACES')) and (flag_matching == 'P'):
			#print(idx,'+ HIGH + MATCH JALAN, MATCH KAB')
			sql2 = ''' update %s set summary = 'HIGH', summary_detail = 'MATCH JALAN, MATCH KAB' where match_vi = 'NOT MATCH' and match_su = 'NOT MATCH' and match_di = 'MATCH' and match_jln = 'MATCH' and keterangan != 'CENTROID' and keterangan != 'ERROR' and ((keterangan = 'GOOGLE MAPS GEOCODING') or (keterangan = 'GOOGLE PLACES')) and flag_matching = 'P' ''' % (table_name)
			execScalar(sql2)
		if (jln == 'NOT MATCH') and (vi == 'NOT MATCH') and (su == 'NOT MATCH') and (di == 'NOT MATCH') and (ket != 'CENTROID') and (ket != 'ERROR') and ((ket == 'GOOGLE MAPS GEOCODING') or (ket == 'GOOGLE PLACES')) and (flag_matching == 'P'):
			#print(idx,'+ LOW + ALL NOT MATCH')
			sql2 = ''' update %s set summary = 'LOW', summary_detail = 'ALL NOT MATCH' where match_vi = 'NOT MATCH' and match_su = 'NOT MATCH' and match_di = 'NOT MATCH' and match_jln = 'NOT MATCH' and keterangan != 'CENTROID' and keterangan != 'ERROR' and ((keterangan = 'GOOGLE MAPS GEOCODING') or (keterangan = 'GOOGLE PLACES')) and flag_matching = 'P' ''' % (table_name)
			execScalar(sql2)
		if (jln == 'NOT MATCH') and (vi == 'MATCH') and (su == 'NOT MATCH') and (di == 'NOT MATCH') and (ket != 'CENTROID') and (ket != 'ERROR') and ((ket == 'GOOGLE MAPS GEOCODING') or (ket == 'GOOGLE PLACES')) and (flag_matching == 'P'):
			#print(idx,'+ MEDIUM + MATCH KEL ONLY')
			sql2 = ''' update %s set summary = 'MEDIUM', summary_detail = 'MATCH KEL ONLY' where match_vi = 'MATCH' and match_su = 'NOT MATCH' and match_di = 'NOT MATCH' and match_jln = 'NOT MATCH' and keterangan != 'CENTROID' and keterangan != 'ERROR' and ((keterangan = 'GOOGLE MAPS GEOCODING') or (keterangan = 'GOOGLE PLACES')) and flag_matching = 'P' ''' % (table_name)
			execScalar(sql2)
		if (jln == 'NOT MATCH') and (vi == 'MATCH') and (su == 'MATCH') and (di == 'NOT MATCH') and (ket != 'CENTROID') and (ket != 'ERROR') and ((ket == 'GOOGLE MAPS GEOCODING') or (ket == 'GOOGLE PLACES')) and (flag_matching == 'P'):
			#print(idx,'+ MEDIUM + MATCH KEL ONLY')
			sql2 = ''' update %s set summary = 'MEDIUM', summary_detail = 'MATCH KEL ONLY' where match_vi = 'MATCH' and match_su = 'MATCH' and match_di = 'NOT MATCH' and match_jln = 'NOT MATCH' and keterangan != 'CENTROID' and keterangan != 'ERROR' and ((keterangan = 'GOOGLE MAPS GEOCODING') or (keterangan = 'GOOGLE PLACES')) and flag_matching = 'P' ''' % (table_name)
			execScalar(sql2)
		if (jln == 'NOT MATCH') and (vi == 'MATCH') and (su == 'NOT MATCH') and (di == 'MATCH') and (ket != 'CENTROID') and (ket != 'ERROR') and ((ket == 'GOOGLE MAPS GEOCODING') or (ket == 'GOOGLE PLACES')) and (flag_matching == 'P'):
			#print(idx,'+ MEDIUM + MATCH KEL ONLY')
			sql2 = ''' update %s set summary = 'MEDIUM', summary_detail = 'MATCH KEL ONLY' where match_vi = 'MATCH' and match_su = 'NOT MATCH' and match_di = 'MATCH' and match_jln = 'NOT MATCH' and keterangan != 'CENTROID' and keterangan != 'ERROR' and ((keterangan = 'GOOGLE MAPS GEOCODING') or (keterangan = 'GOOGLE PLACES')) and flag_matching = 'P' ''' % (table_name)
			execScalar(sql2)
		if (jln == 'NOT MATCH') and (vi == 'MATCH') and (su == 'MATCH') and (di == 'MATCH') and (ket != 'CENTROID') and (ket != 'ERROR') and ((ket == 'GOOGLE MAPS GEOCODING') or (ket == 'GOOGLE PLACES')) and (flag_matching == 'P'):
			#print(idx,'+ MEDIUM + MATCH KEL ONLY')
			sql2 = ''' update %s set summary = 'MEDIUM', summary_detail = 'MATCH KEL ONLY' where match_vi = 'MATCH' and match_su = 'MATCH' and match_di = 'MATCH' and match_jln = 'NOT MATCH' and keterangan != 'CENTROID' and keterangan != 'ERROR' and ((keterangan = 'GOOGLE MAPS GEOCODING') or (keterangan = 'GOOGLE PLACES')) and flag_matching = 'P' ''' % (table_name)
			execScalar(sql2)
		if (jln == 'NOT MATCH') and (vi == 'NOT MATCH') and (su == 'MATCH') and (di == 'NOT MATCH') and (ket != 'CENTROID') and (ket != 'ERROR') and ((ket == 'GOOGLE MAPS GEOCODING') or (ket == 'GOOGLE PLACES')) and (flag_matching == 'P'):
			#print(idx,'+ MEDIUM + MATCH KEC ONLY')
			sql2 = ''' update %s set summary = 'MEDIUM', summary_detail = 'MATCH KEC ONLY' where match_vi = 'NOT MATCH' and match_su = 'MATCH' and match_di = 'NOT MATCH' and match_jln = 'NOT MATCH' and keterangan != 'CENTROID' and keterangan != 'ERROR' and ((keterangan = 'GOOGLE MAPS GEOCODING') or (keterangan = 'GOOGLE PLACES')) and flag_matching = 'P' ''' % (table_name)
			execScalar(sql2)
		if (jln == 'NOT MATCH') and (vi == 'NOT MATCH') and (su == 'MATCH') and (di == 'MATCH') and (ket != 'CENTROID') and (ket != 'ERROR') and ((ket == 'GOOGLE MAPS GEOCODING') or (ket == 'GOOGLE PLACES')) and (flag_matching == 'P'):
			#print(idx,'+ MEDIUM + MATCH KEC ONLY')
			sql2 = ''' update %s set summary = 'MEDIUM', summary_detail = 'MATCH KEC ONLY' where match_vi = 'NOT MATCH' and match_su = 'MATCH' and match_di = 'MATCH' and match_jln = 'NOT MATCH' and keterangan != 'CENTROID' and keterangan != 'ERROR' and ((keterangan = 'GOOGLE MAPS GEOCODING') or (keterangan = 'GOOGLE PLACES')) and flag_matching = 'P' ''' % (table_name)
			execScalar(sql2)
		if (jln == 'NOT MATCH') and (vi == 'NOT MATCH') and (su == 'NOT MATCH') and (di == 'MATCH') and (ket != 'CENTROID') and (ket != 'ERROR') and ((ket == 'GOOGLE MAPS GEOCODING') or (ket == 'GOOGLE PLACES')) and (flag_matching == 'P'):
			#print(idx,'+ MEDIUM + MATCH KAB ONLY')
			sql2 = ''' update %s set summary = 'LOW', summary_detail = 'MATCH KAB ONLY' where match_vi = 'NOT MATCH' and match_su = 'NOT MATCH' and match_di = 'MATCH' and match_jln = 'NOT MATCH' and keterangan != 'CENTROID' and keterangan != 'ERROR' and ((keterangan = 'GOOGLE MAPS GEOCODING') or (keterangan = 'GOOGLE PLACES')) and flag_matching = 'P' ''' % (table_name)
			execScalar(sql2)
		if (ket != 'GOOGLE PLACES') and (ket != 'GOOGLE MAPS GEOCODING') and (ket != 'CENTROID') and (ket != 'ERROR') and (flag_matching == 'P'):
			#print(idx,'+ LOW + ALL NOT MATCH')
			sql2 = ''' update %s set summary = 'LOW', summary_detail = 'ALL NOT MATCH' where keterangan is null and flag_matching = 'P' ''' % (table_name)
			execScalar(sql2)
	print("UPDATE TABLE_NAME HAS FINISHED (SUMMARY, SUMMARY_DETAIL)\n")
	print("UPDATE TABLE_NAME HAS FINISHED (MATCH_JLN, MATCH_ADM, SUMMARY, SUMMARY_DETAIL)")


#untuk mejalankan keseluruhan fungsi yang ada di matchingjln.py
def main(table_name, open_table_stringmatchingconcat):
	##variabel sementara
	#table_name = 'z_tb_test'
	#open_table_stringmatchingconcat = 'z_tb_stringmatchingconcat_2017_07_07_10_26_50'
	#open_table_stringmatchingconcat = time.strftime("z_tb_stringmatchingconcat_%Y_%m_%d_%H_%M_%S")
	##------------------
	open_table_mtsingkatan = 'mt_singkatan'
	open_table_mtsingkatanpoi = 'mt_singkatanpoi'
	update_kode_data(table_name)
	update_kode_dataa(table_name)
	fetch_data_stringmatchingconcat(table_name, open_table_stringmatchingconcat)
	update_kode_data2(open_table_stringmatchingconcat)
	update_kode_data3(open_table_stringmatchingconcat)
	##----- 1 (Matching Jalan -> matching ori_address dengan google_address)
	fetch_data_stringmatchingconcat2(open_table_stringmatchingconcat)
	ubah_singkatan_stringmatchingconcat(open_table_mtsingkatan, open_table_stringmatchingconcat)
	split_stringmatchingconcat(open_table_stringmatchingconcat) 
	checkperwords_stringmatchingconcat(open_table_stringmatchingconcat)
	checkperwords_stringmatchingconcat2(open_table_stringmatchingconcat)
	checkperwords_stringmatchingconcat3(open_table_stringmatchingconcat)
	##----- 2 (Matching Jalan -> matching ori_name dengan place_name)
	fetch_data_stringmatchingconcat3(open_table_stringmatchingconcat)
	ubah_singkatan_stringmatchingconcat2(open_table_mtsingkatanpoi, open_table_stringmatchingconcat)
	split_stringmatchingconcat2(open_table_stringmatchingconcat)
	checkperwords_stringmatchingconcat4(open_table_stringmatchingconcat)
	checkperwords_stringmatchingconcat5(open_table_stringmatchingconcat)
	checkperwords_stringmatchingconcat6(open_table_stringmatchingconcat)
	##----- 3 (Matching Jalan -> matching add+ori_name dengan place_name)
	fetch_data_stringmatchingconcat4(open_table_stringmatchingconcat)
	ubah_singkatan_stringmatchingconcat3(open_table_mtsingkatanpoi, open_table_stringmatchingconcat)
	split_stringmatchingconcat3(open_table_stringmatchingconcat)
	checkperwords_stringmatchingconcat7(open_table_stringmatchingconcat)
	##------------------
	join_table_stringmatchingconcat_tablename(table_name, open_table_stringmatchingconcat)
	matchingadm.main(open_table_stringmatchingconcat)
	join_tableadm_stringmatchingconcat_tablename(table_name, open_table_stringmatchingconcat) 
	summary(table_name)

#hilangin ascii nya di notepad++ aja
#tinggal replace kode "[^\x00-\x7F]+" jadi ""