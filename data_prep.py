import os, fnmatch
import re
import pandas as pd
import sys
sys.path.append('library')
from logger import *
from pgsql import *
from active_record import *
from cleansing import *
from datetime import datetime, timedelta

#making main table
def making_table(table_name,log_file):
	sql = making_proc_table(table_name)
	execScalar(sql)
	logger(log_file, 'info', "Output table has created" )
	print ("Output table has created")

#Finding csv file
def find_csv(working_folder,log_file):
	check_dir = print(os.path.isdir(working_folder))
	if check_dir == False:
		pass
		logger(log_file, 'warning', "Directory not exist, please check it again!" )
		print ("Directory not exist, please check it again!")
	else:
		list_csv = []
		for root, dirs, files in os.walk(working_folder,"*.csv"):
			for file in fnmatch.filter(files, "*.csv"):
				data = os.path.join (root, file)
				list_csv.append(data)
		return list_csv

#Insert database
def insert_data(table_name,csv_str,log_file):
	time_now = datetime.now()
	date_str = time_now.strftime("%Y-%m-%d")

	#read csv and transfer to database
	csv_str = csv_str.replace('\\','/')
	df = pd.read_csv(csv_str, names=['ori_id','ori_name', 'ori_address', 'ori_vi', 'ori_su', 'ori_di', 'ori_pr'], skiprows=1, sep=',', index_col=False, encoding='ISO-8859-1')
	df["flag_geocode"] = 'Q'
	df["ori_file"] = csv_str
	df["modified"] = date_str

	engine = engine_sqlalchemy()
	try:
		df.to_sql(name=table_name, con=engine, if_exists = 'append', index=False)
	except sqlalchemy.exc.DataError:
		pass
		logger(log_file, 'debug', "sqlalchemy - DataError" )
		print ("sqlalchemy - DataError")
	except sqlalchemy.exc.IntegrityError:
		pass
		logger(log_file, 'warning', "sqlalchemy - data already exist, will be skipped")
		print ("sqlalchemy - data already exist, will be skipped")

	#capitalize-ing data
	sql = upperData(table_name)
	execScalar(sql)

def cleansing(table_name,log_file):
	query = fetchCleanseAddress(table_name)
	data = fetch(query)
	for row in data:
		idx = row[0]
		ori_address = row[1] or ''
		logger(log_file, 'info', "Cleansing %i: %s" % (idx, ori_address))
		print ("Cleansing %i: %s" % (idx, ori_address))

		fixed_address_1 = cleansingGeocode(ori_address)
		query = updateCleanseAddress(table_name, 'cleanse_address_1', fixed_address_1, idx)
		execScalar(query)

		fixed_address_2 = cleansingGeocodeRetry(ori_address)
		if fixed_address_2 == fixed_address_1:
			pass
		else:
			query = updateCleanseAddress(table_name, 'cleanse_address_2', fixed_address_2, idx)
			execScalar(query)

		fixed_address_3 = cleansingGPlaces(ori_address)
		query = updateCleanseAddress(table_name, 'cleanse_address_3', fixed_address_3, idx)
		execScalar(query)

	logger(log_file, 'info', "All data has been cleansed")
	print ("\tAll data has been cleansed")

def main(table_name,working_folder,log_file):
	making_table(table_name,log_file)
	list_csv=find_csv(working_folder,log_file)
	print (list_csv)
	for csv in list_csv:
		print ("\t" + csv)
		insert_data(table_name,csv,log_file)
		cleansing(table_name,log_file)

#working_folder = "E:\\01 Internal\\test-geocoding\\"
#main("test",working_folder)