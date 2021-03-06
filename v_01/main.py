import os
import sys, getopt
from time import time, sleep
from multiprocessing import Process
from threading import Thread
from subprocess import Popen, PIPE
import data_prep
import geocode
sys.path.append('library')
import active_record
import pgsql
import logger


perl_exe = r'C:\Perl64\bin\perl.exe'


def get_arg(argv):
	working_folder = ''
	table_name = ''
	try:
		opts, args = getopt.getopt(argv,"i:o:",["ifile=","ofile="])
	except getopt.GetoptError:
		print ('format error, do: "python main.py -i <input folder> -t <output table>"')
		sys.exit(2)
	for opt, arg in opts:
		if opt in ("-i", "--ifile"):
			working_folder = arg
			working_folder = working_folder + "\\"
		elif opt in ("-o", "--ofile"):
			table_name = arg
	print ('Input folder is: ', working_folder)
	print ('Output table is: ', table_name)
	return working_folder, table_name
	

def geocode_thread(table_name):
	print (table_name)
	thread = Thread(target = geocode.main, args = (table_name))
	thread2 = Thread(target = geocode.main, args = (table_name))
	thread3 = Thread(target = geocode.main, args = (table_name))
	thread4 = Thread(target = geocode.main, args = (table_name))
	thread.start()
	thread2.start()
	thread3.start()
	thread4.start()
	#tunggu sampe thread terakhir to be done buat lanjut ke step berikutnya
	thread4.join()
	print ("thread finished...exiting")

def match_sum(table_name):
	#get perl directory
	cwd = os.getcwd()
	dir_perl = os.path.join(cwd,'matching','Dokumen.txt')
	print (dir_perl)

	#change Dokumen.txt to change table_name parameter
	file_perl = open(dir_perl,'r')
	lines = file_perl.readlines()
	conn_perl = str(lines[0]).split(";")
	conn_perl[0] = pgsql.dbname
	conn_perl[1] = pgsql.dbhost
	conn_perl[2] = pgsql.dbport
	conn_perl[3] = table_name
	conn_perl[4] = pgsql.dbuser
	conn_perl[5] = pgsql.dbpass
	rows = []
	for val in conn_perl:
		row = str(val)
		rows.append(row)
	data_perl = ';'.join(rows)
	print (data_perl)
	file_perl = open(dir_perl,'w')
	file_perl.write(data_perl)

	#run perl script
	Popen(['perl', 'matching.pl'], stdout=PIPE, stderr=PIPE)
	#dont run any python code after this one, nanti jadi ga jalan process nya

def run(table_name, working_folder, log_file):
	#run geocode
	geocode.main(table_name)

	#run perl matching script
	logger.logger(log_file, 'info', 'perl will be run')
	print ("perl will be run")
	process = Process(target = match_sum, args = (table_name,))
	process.start()
	process.join()

	sleep(50)

	print ("all process has ben done, please wait for perl script result to be appear in database")

def main(argv):
	#get argument
	arg = get_arg(argv)
	working_folder = arg[0]
	table_name = arg[1]

	#log_file
	log_file = working_folder+table_name+".log"

	#first logging
	logger.logger(log_file, 'info', 'Input folder is: %s' % working_folder)
	logger.logger(log_file, 'info', 'Output table is: %s' % table_name)

	#run data_prep
	logger.logger(log_file, 'info', '==========DATA PREPARATION IS RUNNING==========')
	start = time()
	data_prep.main(table_name,working_folder,log_file)
	end = time()
	print("\nDATA PREPARATION DONE IN %s SECOND==========" % (end - start))
	logger.logger(log_file, 'info', "==========DATA PREPARATION DONE IN %s SECOND==========" % (end - start))

	#run geocode and matching
	logger.logger(log_file, 'info', '==========GEOCODE AND MATCHING IS RUNNING==========')
	start = time()
	check = active_record.checkGeocodeCount(table_name)
	data = pgsql.fetchone(check)
	jml_row = data[0]
	part = 0
	while jml_row >= 1:
		part += 1
		print('RUN PART %s' % part)
		run(table_name, working_folder, log_file)
		jml_row -= 100
	end = time()
	print("\n==========GEOCODE AND MATCHING DONE IN %s SECOND==========" % (end - start))
	logger.logger(log_file, 'info', "==========GEOCODE AND MATCHING DONE IN %s SECOND==========" % (end - start))

		
if __name__ == '__main__':
	main(sys.argv[1:])

#python main.py -i "E:\01 Internal\test-geocoding" -o "test"