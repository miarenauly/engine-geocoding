# FOR DATA PREPARATION PURPOSES
def making_proc_table(table_name):
    sql = '''CREATE TABLE %s (
		id bigserial,
		modified date,
		ori_file text,
		ori_id text,
		ori_name text,
		ori_address text,
		ori_vi varchar (100),
		ori_su varchar (100),
		ori_di varchar (100),
		ori_pr varchar (100),
		cleanse_address_1 text,
		cleanse_address_2 text,
		cleanse_address_3 text,
		kode_data int,
		flag_geocode varchar (10),
		start_geocode timestamp,
		end_geocode timestamp,
		long float,
		lat float,
		google_address text,
		place_name text,
		google_vi varchar (100),
		google_su varchar (100),
		google_di varchar (100),
		google_pr varchar (100),
		adm_vi varchar (100),
		adm_su varchar (100),
		adm_di varchar (100),
		adm_pr varchar (100),
		adm_vi_id bigint,
		adm_su_id integer,
		adm_di_id integer,
		adm_pr_id integer,
		flag_matching varchar (100),
		match_pr  varchar (100),
		match_di  varchar (100),
		match_su  varchar (100),
		match_vi varchar (100),
		match_jln varchar (100),
		keterangan text,
		summary varchar (100),
		summary_detail varchar(100),
		unique (ori_file,ori_id)
		)''' % (table_name)
    return sql


def upperData(table_name):
    sql = """
	update {0} set ori_name = upper(ori_name);
	update {0} set ori_address = upper(ori_address);
	update {0} set ori_vi = upper(ori_vi);
	update {0} set ori_su = upper(ori_su);
	update {0} set ori_di = upper(ori_di);
	update {0} set ori_pr = upper(ori_pr);
	""" .format(table_name)
    return sql


def fetchCleanseAddress(table_name):
    sql = """
		SELECT id, ori_address FROM %s
	""" % (table_name)
    return sql


def updateCleanseAddress(table_name, col_name, fixed_address, idx):
    sql = """
		UPDATE %s
		SET %s = '%s'
		WHERE id = %s
	""" % (table_name, col_name, fixed_address, idx)
    return sql


# FOR GEOCODING PURPOSES
def updateKodeData(table_name):
    sql = """
		UPDATE {0} SET kode_data = 2 WHERE ori_name IS NOT NULL;
		UPDATE {0} SET kode_data = 1 WHERE (ori_address ILIKE '%JL%' OR ori_address ILIKE '%JALAN%') AND kode_data IS NULL;
		UPDATE {0} SET kode_data = 2 WHERE kode_data IS NULL;
	""" .format(table_name)
    return sql


def getAddressGeocode(table_name):
    sql = """
		SELECT kode_data,
				id,
				ori_name,
				ori_address,
				ori_vi, ori_su,
				ori_di, ori_pr,
				cleanse_address_1,
				cleanse_address_2,
				cleanse_address_3
		FROM %s
		WHERE flag_geocode = 'Q'
		LIMIT 100
	""" % (table_name)
    return sql


def updateGeocodeResult(table_name, lng, lat, place_name, place_address, village, sub_district, district, province, keterangan, time_start, time_end, idx):
    sql = """
		UPDATE %s
		SET long = '%s',
			lat = '%s',
			place_name = '%s',
			google_address = '%s',
			google_vi = '%s',
			google_su = '%s',
			google_di = '%s',
			google_pr = '%s',
			flag_geocode = 'D',
			keterangan = '%s',
			start_geocode = '%s',
			end_geocode = '%s'
		WHERE id = %s
	""" % (table_name, lng, lat, place_name, place_address, village, sub_district, district, province, keterangan, time_start, time_end, idx)
    return sql


def updateFlagError(table_name, idx):
    sql = """
		UPDATE %s
		SET flag_geocode = 'E'
		WHERE id = %s
	""" % (table_name, idx)
    return sql


def updateFlagProcess(table_name, idx):
    sql = """
		UPDATE %s
		SET flag_geocode = 'P'
		WHERE id = %s
	""" % (table_name, idx)
    return sql


def updateKetError(table_name, time_start, time_end, idx):
    sql = """
		UPDATE %s
		SET keterangan = 'ERROR',
			start_geocode = '%s',
			end_geocode = '%s'
		WHERE id = %s
	""" % (table_name, time_start, time_end, idx)
    return sql


def getFlag(table_name, idx):
    sql = """
		SELECT flag_geocode FROM %s WHERE id = %s
	""" % (table_name, idx)
    return sql


def checkGeocodeCount(table_name):
    sql = """
		SELECT count(flag_geocode) FROM %s
	""" % (table_name)
    return sql


def updateAdmIntersect(table_name, idx):
    sql = """
	UPDATE
		%s AS a
	SET
		adm_vi_id = b.vi_id,
		adm_su_id = b.su_id,
		adm_di_id = b.di_id,
		adm_pr_id = b.pr_id,
		adm_vi = b.vi_name,
		adm_su = b.su_name,
		adm_di = b.di_name,
		adm_pr = b.pr_name
	FROM
		shp_admin_dattabot AS b
		WHERE ST_Intersects(ST_SetSRID(ST_MakePoint(a.long, a.lat), 4326), b.geom) AND 
		a.id = %s
	""" % (table_name, idx)
    return sql


def getAdmInside(table_name):
    sql = """
		SELECT id
		FROM %s AS a, 
			 mt_batas_zona_tambahan AS b
		WHERE a.adm_pr_id IS NULL AND ST_Intersects(ST_SetSRID(ST_MakePoint(a.long, a.lat), 4326), b.geom)
		""" % (table_name)
    return sql


def updateAdmNearest(table_name, idx):
    sql = """
		UPDATE
			{0} AS a
		SET
			adm_vi_id = b.vi_id,
			adm_su_id = b.su_id,
			adm_di_id = b.di_id,
			adm_pr_id = b.pr_id,
			adm_vi = b.vi_name,
			adm_su = b.su_name,
			adm_di = b.di_name,
			adm_pr = b.pr_name
		FROM
			shp_admin_dattabot AS b
		WHERE a.id = {1} AND b.vi_id IN(
			SELECT b.vi_id
			FROM {0} AS a, shp_admin_dattabot AS b
			WHERE a.id = {1} 
			ORDER BY ST_Distance(b.geom, ST_SetSRID(ST_MakePoint(a.long, a.lat),4326)) ASC LIMIT 1)
		""" .format(table_name, idx)
    return sql


def making_proc_table_stringmatchingconcat(open_table_stringmatchingconcat):
    sql = '''CREATE TABLE %s (
 		id int,
 		ori_name varchar (255),
 		ori_address text,
 		ori_vi varchar (255),
 		ori_su varchar (255),
 		ori_di varchar (255),
 		ori_pr varchar (255),
 		flag_geocode varchar (255),
 		google_address text,
 		place_name varchar (255), 
 		google_vi varchar (255),
 		google_su varchar (255),
 		google_di varchar (255),
 		google_pr varchar (255), 
 		adm_vi varchar (255),
 		adm_su varchar (255),
 		adm_di varchar (255),
 		adm_pr varchar (255),
 		flag_matching varchar (100),
		data text,
		data_bersih text,
		address_awal_bersih text,
		address_reverse_bersih text,
		data_nama text,
		data_nama_bersih text,
		data_nama_awal_bersih text,
		data_nama_reverse_bersih text,
		data_nama_dan_place text,
		data_nama_dan_place_bersih text,
		data_nama_dan_place_awal_bersih text,
		ket_matchjln varchar (255),
		adm text,
		adm_bersih text,
		adm_awal_bersih text,
		adm_reverse_bersih text,
		adm_google text,
		adm_google_bersih text,
		adm_google_reverse_bersih text,
		adm_data_dan_google text,
		adm_data_dan_google_bersih text,
		adm_data_dan_google_awal_bersih text,
		ket_matchvi varchar (255),
		ket_matchsu varchar (255),
		ket_matchdi varchar (255),
		ket_matchpr varchar (255)
		)''' % (open_table_stringmatchingconcat)
    return sql


def updateKodeDataa(table_name):
	sql = '''
		update %s set flag_matching = 'Q' where summary is null and summary_detail is null;
	''' % (table_name)
	return sql


def updateKodeDataaa(table_name):
	sql = '''
		update %s set flag_matching = 'D' where flag_matching = 'Q' and summary is not null and summary_detail is not null;
	''' % (table_name)
	return sql


def fetch_stringmatchingconcat(table_name):
	sql = '''
		select id, ori_name, ori_address, ori_vi, ori_su, ori_di, ori_pr, flag_geocode, google_address, place_name, google_vi, google_su, google_di, google_pr, adm_vi, adm_su, adm_di, adm_pr, flag_matching FROM %s where flag_geocode != 'Q' and summary is null and flag_matching = 'Q' order by id limit 100
	''' % (table_name)
	return sql


def updateKodeDataa2(open_table_stringmatchingconcat):
	sql = '''
		update %s set flag_matching = 'P' where flag_matching = 'Q' and ket_matchvi is null and ket_matchpr is null;
	''' % (open_table_stringmatchingconcat)
	return sql


def updateKodeDataa3(open_table_stringmatchingconcat):
	sql = '''
		update %s set flag_matching = 'D' where flag_matching = 'P' and ket_matchvi is not null and ket_matchpr is not null;
	''' % (open_table_stringmatchingconcat)
	return sql


def fetch_stringmatchingconcat2(open_table_stringmatchingconcat):
    sql = '''
    	select id, upper(concat(ori_address,' ',' ^| ',google_address,' ')) as data FROM %s where flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
    return sql
 

def update_stringmatchingconcat2(open_table_stringmatchingconcat, dataa, idx):
	sql = '''
		update %s set data = '%s' where id = %s
	''' % (open_table_stringmatchingconcat, dataa, idx)
	return sql


def fetch_mtsingkatan(open_table_mtsingkatan):
	sql = '''
		select name, sinonim FROM %s 
	''' % (open_table_mtsingkatan)
	return sql


def fetch_singkatan_stringmatchingconcat(open_table_stringmatchingconcat):
    sql = '''
    	select id, data FROM %s where flag_geocode != 'Q' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
    return sql


def fetch_singkatan_stringmatchingconcatt(open_table_stringmatchingconcat):
    sql = '''
    	select id, data_bersih FROM %s where flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
    return sql


def update_addressawalbersih(open_table_stringmatchingconcat, address_awal_bersih, idx):
	sql = '''
		update %s set address_awal_bersih = '%s' where id = %s
	''' % (open_table_stringmatchingconcat, address_awal_bersih, idx)
	return sql


def update_addressreversebersih(open_table_stringmatchingconcat, address_reverse_bersih, idx):
	sql = '''
		update %s set address_reverse_bersih = '%s' where id = %s
	''' % (open_table_stringmatchingconcat, address_reverse_bersih, idx)
	return sql


def fetcha(open_table_stringmatchingconcat):
	sql = '''
		select id, address_awal_bersih, address_reverse_bersih from %s where flag_geocode != 'Q' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def fetchaa(open_table_stringmatchingconcat):
	sql = '''
		select id, address_awal_bersih, address_reverse_bersih from %s where ket_matchjln = 'NOT MATCH' and flag_geocode != 'Q' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def fetch_mtsingkatanpoi(open_table_mtsingkatanpoi):
	sql = '''
		select name, sinonim FROM %s 
	''' % (open_table_mtsingkatanpoi)
	return sql


def fetch_stringmatchingconcat3(open_table_stringmatchingconcat):
    sql = '''
    	select id, upper(concat(ori_name,' ',' ^| ',place_name,' ')) as data FROM %s where ket_matchjln = 'NOT MATCH' and flag_geocode != 'Q' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
    return sql 


def update_stringmatchingconcat3(open_table_stringmatchingconcat, dataa_nama, idx):
	sql = '''
		update %s set data_nama = '%s' where id = %s
	''' % (open_table_stringmatchingconcat, dataa_nama, idx)
	return sql


def fetch_singkatan_stringmatchingconcat2(open_table_stringmatchingconcat):
    sql = '''
    	select id, data_nama FROM %s where ket_matchjln = 'NOT MATCH' and flag_geocode != 'Q' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
    return sql


def update_addressawalbersih2(open_table_stringmatchingconcat, address_nama_awal_bersih, idx):
	sql = '''
		update %s set data_nama_awal_bersih = '%s' where id = %s
	''' % (open_table_stringmatchingconcat, address_nama_awal_bersih, idx)
	return sql


def update_addressreversebersih2(open_table_stringmatchingconcat, address_nama_reverse_bersih, idx):
	sql = '''
		update %s set data_nama_reverse_bersih = '%s' where id = %s
	''' % (open_table_stringmatchingconcat, address_nama_reverse_bersih, idx)
	return sql


def fetch_singkatan_z(open_table_stringmatchingconcat):
    sql = '''
    	select id, data_nama_bersih FROM %s where ket_matchjln = 'NOT MATCH' and flag_geocode != 'Q' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
    return sql


def fetcha2(open_table_stringmatchingconcat):
	sql = '''
		select id, data_nama_awal_bersih, data_nama_reverse_bersih from %s where ket_matchjln = 'NOT MATCH' and flag_geocode != 'Q' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def fetch_stringmatchingconcat4(open_table_stringmatchingconcat):
    sql = '''
    	select id, upper(concat(ori_address,' ',ori_name,' ',' ^| ',place_name,' ')) as data FROM %s where ket_matchjln = 'NOT MATCH' and flag_geocode != 'Q' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
    return sql 


def update_stringmatchingconcat4(open_table_stringmatchingconcat, dataa_nama, idx):
	sql = '''
		update %s set data_nama_dan_place = '%s' where id = %s
	''' % (open_table_stringmatchingconcat, dataa_nama, idx)
	return sql


def fetch_singkatan_stringmatchingconcat3(open_table_stringmatchingconcat):
    sql = '''
    	select id, data_nama FROM %s where ket_matchjln = 'NOT MATCH' and flag_geocode != 'Q' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
    return sql



def fetch_singkatan_z2(open_table_stringmatchingconcat):
    sql = '''
    	select id, data_nama_dan_place_bersih FROM %s where ket_matchjln = 'NOT MATCH' and flag_geocode != 'Q' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
    return sql


def update_addressawalbersih3(open_table_stringmatchingconcat, address_nama_awal_bersih, idx):
	sql = '''
		update %s set data_nama_dan_place_awal_bersih = '%s' where id = %s
	''' % (open_table_stringmatchingconcat, address_nama_awal_bersih, idx)
	return sql


def fetcha3(open_table_stringmatchingconcat):
	sql = '''
		select id, data_nama_dan_place_awal_bersih, data_nama_reverse_bersih from %s where ket_matchjln = 'NOT MATCH' and flag_geocode != 'Q' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def join_table_stringmatchingconcat(table_name, open_table_stringmatchingconcat):
	sql = '''
		update %s as v set match_jln = s.ket_matchjln from %s as s where v.id = s.id
	''' % (table_name, open_table_stringmatchingconcat)
	return sql


def fetch_data_adm_stringmatchingconcat(open_table_stringmatchingconcat):
	sql = '''
		select id, upper(concat(ori_vi,' ^ ',ori_su,' ^ ',ori_di,' ^ ',ori_pr,' | ',adm_vi,' ^ ',adm_su,' ^ ',adm_di,' ^ ',adm_pr,' ')) FROM %s where flag_geocode != 'Q' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def update_data_adm_stringmatchingconcat(open_table_stringmatchingconcat, dataa, idx):
	sql = '''
		update %s set adm = '%s' where id = %s
	''' % (open_table_stringmatchingconcat, dataa, idx)
	return sql


def fetch_mtsingkatanadm(open_table_mtsingkatanadm):
	sql = '''
		select name, sinonim FROM %s 
	''' % (open_table_mtsingkatanadm)
	return sql


def fetch_singkatan_adm_stringmatchingconcat(open_table_stringmatchingconcat):
    sql = '''
    	select id, adm FROM %s where flag_geocode != 'Q' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
    return sql


def fetch_singkatan_adm_stringmatchingconcatt(open_table_stringmatchingconcat):
	sql = '''
    	select id, adm_bersih FROM %s where flag_matching = 'P' order by id
    ''' % (open_table_stringmatchingconcat)
	return sql


def update_admawalbersih(open_table_stringmatchingconcat, adm_awal_bersih, idx):
	sql = '''
		update %s set adm_awal_bersih = '%s' where id = %s
	''' % (open_table_stringmatchingconcat, adm_awal_bersih, idx)
	return sql


def update_admreversebersih(open_table_stringmatchingconcat, adm_reverse_bersih, idx):
	sql2 = '''
		update %s set adm_reverse_bersih = '%s' where id = %s
	''' % (open_table_stringmatchingconcat, adm_reverse_bersih, idx)
	return sql2


def fetchadm(open_table_stringmatchingconcat):
	sql = '''
		select id, adm_awal_bersih, adm_reverse_bersih from %s where flag_geocode != 'Q' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def fetchadm2(open_table_stringmatchingconcat):
	sql = '''
		select id, adm_awal_bersih, adm_reverse_bersih from %s where flag_geocode != 'Q' and ket_matchvi = 'NOT MATCH' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def fetchadm3(open_table_stringmatchingconcat):
	sql = '''
		select id, adm_awal_bersih, adm_reverse_bersih from %s where flag_geocode != 'Q' and ket_matchsu = 'NOT MATCH' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def fetchadm4(open_table_stringmatchingconcat):
	sql = '''
		select id, adm_awal_bersih, adm_reverse_bersih from %s where flag_geocode != 'Q' and ket_matchdi = 'NOT MATCH' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def fetchadm5(open_table_stringmatchingconcat):
	sql = '''
		select id, adm_awal_bersih, adm_reverse_bersih from %s where flag_geocode != 'Q' and ket_matchpr = 'NOT MATCH' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def fetch_data_adm_google_stringmatchingconcat(open_table_stringmatchingconcat):
	sql = '''
		select id, upper(concat(ori_vi,' ^ ',ori_su,' ^ ',ori_di,' ^ ',ori_pr,' | ',google_vi,' ^ ',google_su,' ^ ',google_di,' ^ ',google_pr,' ')) FROM %s where flag_geocode != 'Q' and (ket_matchvi = 'NOT MATCH' or ket_matchsu = 'NOT MATCH' or ket_matchdi = 'NOT MATCH' or ket_matchpr = 'NOT MATCH') and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def update_data_adm_google_stringmatchingconcat(open_table_stringmatchingconcat, dataa_google, idx):
	sql = '''
		update %s set adm_google = '%s' where id = %s
	''' % (open_table_stringmatchingconcat, dataa_google, idx)
	return sql


def fetch_singkatan_adm_google_stringmatchingconcat(open_table_stringmatchingconcat):
    sql = '''
    	select id, adm_google FROM %s where flag_geocode != 'Q' and adm_google is not null and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
    return sql


def fetch_singkatan_adm_google_stringmatchingconcatt(open_table_stringmatchingconcat):
	sql = '''
    	select id, adm_google_bersih FROM %s where adm_google_bersih is not null and flag_matching = 'P' order by id
    ''' % (open_table_stringmatchingconcat)
	return sql


def update_admgooglereversebersih(open_table_stringmatchingconcat, adm_google_reverse_bersih, idx):
	sql2 = '''
		update %s set adm_google_reverse_bersih = '%s' where id = %s
	''' % (open_table_stringmatchingconcat, adm_google_reverse_bersih, idx)
	return sql2


def fetchadmgoogle(open_table_stringmatchingconcat):
	sql = '''
		select id, adm_awal_bersih, adm_google_reverse_bersih, ket_matchvi, ket_matchsu, ket_matchdi, ket_matchpr from %s where flag_geocode != 'Q' and adm_google_reverse_bersih is not null and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def fetchadmgoogle2(open_table_stringmatchingconcat):
	sql = '''
		select id, adm_awal_bersih, adm_google_reverse_bersih, ket_matchvi, ket_matchsu, ket_matchdi, ket_matchpr from %s where flag_geocode != 'Q' and ket_matchvi = 'NOT MATCH' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def fetchadmgoogle3(open_table_stringmatchingconcat):
	sql = '''
		select id, adm_awal_bersih, adm_google_reverse_bersih, ket_matchvi, ket_matchsu, ket_matchdi, ket_matchpr from %s where flag_geocode != 'Q' and ket_matchsu = 'NOT MATCH' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def fetchadmgoogle4(open_table_stringmatchingconcat):
	sql = '''
		select id, adm_awal_bersih, adm_google_reverse_bersih, ket_matchvi, ket_matchsu, ket_matchdi, ket_matchpr from %s where flag_geocode != 'Q' and ket_matchdi = 'NOT MATCH' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def fetchadmgoogle5(open_table_stringmatchingconcat):
	sql = '''
		select id, adm_awal_bersih, adm_google_reverse_bersih, ket_matchvi, ket_matchsu, ket_matchdi, ket_matchpr  from %s where flag_geocode != 'Q' and ket_matchpr = 'NOT MATCH' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def fetch_dataadm_stringmatchingconcat(open_table_stringmatchingconcat):
	sql = '''
		select id, upper(concat(ori_address,' ',ori_vi,' ^ ',ori_address,' ',ori_su,' ^ ',ori_address,' ',ori_di,' ^ ',ori_address,' ',ori_pr,' | ',adm_vi,' ^ ',adm_su,' ^ ',adm_di,' ^ ',adm_pr,' ')) FROM %s where flag_geocode != 'Q' and (ket_matchvi = 'NOT MATCH' or ket_matchsu = 'NOT MATCH' or ket_matchdi = 'NOT MATCH' or ket_matchpr = 'NOT MATCH') and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def update_dataadm_stringmatchingconcat(open_table_stringmatchingconcat, dataa_google, idx):
	sql = '''
		update %s set adm_data_dan_google = '%s' where id = %s
	''' % (open_table_stringmatchingconcat, dataa_google, idx)
	return sql


def fetch_singkatan_dataadm_stringmatchingconcat(open_table_stringmatchingconcat):
    sql = '''
    	select id, adm_data_dan_google FROM %s where flag_geocode != 'Q' and adm_data_dan_google is not null and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
    return sql


def fetch_singkatan_dataadm_stringmatchingconcatt(open_table_stringmatchingconcat):
	sql = '''
    	select id, adm_data_dan_google_bersih FROM %s where adm_data_dan_google_bersih is not null and flag_matching = 'P' order by id
    ''' % (open_table_stringmatchingconcat)
	return sql


def update_dataadmreversebersih(open_table_stringmatchingconcat, adm_google_awal_bersih, idx):
	sql2 = '''
		update %s set adm_data_dan_google_awal_bersih = '%s' where id = %s
	''' % (open_table_stringmatchingconcat, adm_google_awal_bersih, idx)
	return sql2


def fetchdataadm(open_table_stringmatchingconcat):
	sql = '''
		select id, adm_reverse_bersih, adm_data_dan_google_awal_bersih, ket_matchvi, ket_matchsu, ket_matchdi, ket_matchpr from %s where flag_geocode != 'Q' and ket_matchvi = 'NOT MATCH' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def fetchdataadm2(open_table_stringmatchingconcat) :
	sql = '''
		select id, adm_reverse_bersih, adm_data_dan_google_awal_bersih, ket_matchvi, ket_matchsu, ket_matchdi, ket_matchpr from %s where flag_geocode != 'Q' and ket_matchsu = 'NOT MATCH' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def fetchdataadm3(open_table_stringmatchingconcat) :
	sql = '''
		select id, adm_reverse_bersih, adm_data_dan_google_awal_bersih, ket_matchvi, ket_matchsu, ket_matchdi, ket_matchpr from %s where flag_geocode != 'Q' and ket_matchdi = 'NOT MATCH' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def fetchdataadm4(open_table_stringmatchingconcat) :
	sql = '''
		select id, adm_reverse_bersih, adm_data_dan_google_awal_bersih, ket_matchvi, ket_matchsu, ket_matchdi, ket_matchpr  from %s where flag_geocode != 'Q' and ket_matchpr = 'NOT MATCH' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def fetchgoogledataadm(open_table_stringmatchingconcat):
	sql = '''
		select id, adm_google_reverse_bersih, adm_data_dan_google_awal_bersih, ket_matchvi, ket_matchsu, ket_matchdi, ket_matchpr from %s where flag_geocode != 'Q' and ket_matchvi = 'NOT MATCH' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def fetchgoogledataadm2(open_table_stringmatchingconcat) :
	sql = '''
		select id, adm_google_reverse_bersih, adm_data_dan_google_awal_bersih, ket_matchvi, ket_matchsu, ket_matchdi, ket_matchpr from %s where flag_geocode != 'Q' and ket_matchsu = 'NOT MATCH' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def fetchgoogledataadm3(open_table_stringmatchingconcat) :
	sql = '''
		select id, adm_google_reverse_bersih, adm_data_dan_google_awal_bersih, ket_matchvi, ket_matchsu, ket_matchdi, ket_matchpr from %s where flag_geocode != 'Q' and ket_matchdi = 'NOT MATCH' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def fetchgoogledataadm4(open_table_stringmatchingconcat) :
	sql = '''
		select id, adm_google_reverse_bersih, adm_data_dan_google_awal_bersih, ket_matchvi, ket_matchsu, ket_matchdi, ket_matchpr  from %s where flag_geocode != 'Q' and ket_matchpr = 'NOT MATCH' and flag_matching = 'P' order by id
	''' % (open_table_stringmatchingconcat)
	return sql


def join_table_adm_stringmatchingconcat(table_name, open_table_stringmatchingconcat):
	sql = '''
		update %s as v set match_vi = s.ket_matchvi from %s as s where v.id = s.id
	''' % (table_name, open_table_stringmatchingconcat)
	return sql


def join_table_adm_stringmatchingconcat2(table_name, open_table_stringmatchingconcat):
	sql = '''
		update %s as v set match_su = s.ket_matchsu from %s as s where v.id = s.id
	''' % (table_name, open_table_stringmatchingconcat)
	return sql


def join_table_adm_stringmatchingconcat3(table_name, open_table_stringmatchingconcat):
	sql = '''
		update %s as v set match_di = s.ket_matchdi from %s as s where v.id = s.id
	''' % (table_name, open_table_stringmatchingconcat)
	return sql


def join_table_adm_stringmatchingconcat4(table_name, open_table_stringmatchingconcat):
	sql = '''
		update %s as v set match_pr = s.ket_matchpr from %s as s where v.id = s.id
	''' % (table_name, open_table_stringmatchingconcat)
	return sql


def join_table_adm_stringmatchingconcat5(table_name, open_table_stringmatchingconcat):
	sql = '''
		update %s as v set flag_matching = s.flag_matching from %s as s where v.id = s.id
	''' % (table_name, open_table_stringmatchingconcat)
	return sql


def fetch_stringmatchingconcat5(table_name):
    sql = '''
    	select id, match_vi, match_su, match_di, match_pr, match_jln, keterangan, flag_matching FROM %s where match_vi is not null and match_su is not null and match_di is not null and match_pr is not null and match_jln is not null and flag_matching = 'P'
	''' % (table_name)
    return sql 


def fetch_stringmatchingconcat6(table_name):
    sql = '''
    	select id, summary FROM %s where summary is not null and summary_detail is not null
	''' % (table_name)
    return sql 