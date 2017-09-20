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
import matchingjln
import matchingadm


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


#making table stringmatchingconcat
def making_table_stringmatchingconcat(open_table_stringmatchingconcat):
	sql = active_record.making_proc_table_stringmatchingconcat(open_table_stringmatchingconcat)
	pgsql.execScalar(sql)
	print ("OUTPUT TB_STRINGMATCHINGCONCAT HAS CREATED\n")
	

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


def run(table_name, working_folder, log_file, open_table_stringmatchingconcat):
	#run geocode
	geocode.main(table_name)

	#run perl matching script
	logger.logger(log_file, 'info', 'perl will be run')
	print ("PROCESS MATCHING WILL BE RUN\n")
	matchingjln.main(table_name, open_table_stringmatchingconcat)


def main(argv):
	#get argument
	arg = get_arg(argv)
	working_folder = arg[0]
	table_name = arg[1]

	#making table
	match = '_matching'
	open_table_stringmatchingconcat = table_name + match
	making_table_stringmatchingconcat(open_table_stringmatchingconcat)

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
		run(table_name, working_folder, log_file, open_table_stringmatchingconcat)
		jml_row -= 100
	end = time()
	print("\n==========GEOCODE AND MATCHING DONE IN %s SECOND==========" % (end - start))
	logger.logger(log_file, 'info', "==========GEOCODE AND MATCHING DONE IN %s SECOND==========" % (end - start))

		
if __name__ == '__main__':
	main(sys.argv[1:])

#python main.py -i "E:\01 Internal\test-geocoding" -o "test"