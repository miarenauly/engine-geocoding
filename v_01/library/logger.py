import logging


def logger(log_file, level, message):
	logging.basicConfig(filename=log_file,
		level=logging.DEBUG,
		format='%(asctime)s %(levelname)-7s %(name)s: %(message)s',
        datefmt='%Y-%m-%d %H:%M:%S',
        filemode='w')
	if level == 'debug':
		logging.debug(message)
	elif level == 'info':
		logging.info(message)
	elif level == 'warning':
		logging.warning(message)