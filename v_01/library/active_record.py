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
		match_pr  varchar (100),
		match_di  varchar (100),
		match_su  varchar (100),
		match_vi varchar (100),
		match_jln varchar (100),
		keterangan text,
		summary varchar (100),
		summary_detail varchar(100),
		parsing text,
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
