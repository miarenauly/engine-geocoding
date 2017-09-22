from datetime import datetime
import pytz
import pgsql


def createApiList():
    sql = """
        CREATE TABLE mt_api_list(
        id SERIAL PRIMARY KEY,
        api_type VARCHAR(50),
        api_key VARCHAR(50),
        client_id VARCHAR(50),
        client_secret VARCHAR(50),
        query_limit BIGINT)
    """
    return sql


def makeApiCountTable():
    sql = """
        CREATE TABLE mt_api_query_count(
        query_date DATE,
        key_id INTEGER,
        api_type VARCHAR(50),
        api_key VARCHAR(50),
        client_id VARCHAR(50),
        client_secret VARCHAR(50),
        query_count float DEFAULT 0,
        query_limit BIGINT DEFAULT 0,
        api_status VARCHAR(50))
    """
    return sql


def dateNow():
    timenow = datetime.now(tz=pytz.utc).astimezone(pytz.timezone('US/Pacific'))
    timenow = timenow.strftime("%Y-%m-%d")
    return timenow


def getDate(date_now):
    sql = """
    SELECT query_date
    FROM mt_api_query_count
    WHERE query_date = '%s'
    """ % (date_now)
    return sql


def insertApi(date_now):
    sql = """
    INSERT INTO mt_api_query_count (query_date, key_id, api_type, api_key, client_id, client_secret, query_limit)
    SELECT '%s', id, api_type, api_key, client_id, client_secret, query_limit
    FROM mt_api_list
    """ % (date_now)
    return sql


def updateApiStatus(date_now):
    sql = """
    UPDATE mt_api_query_count
    SET api_status = 'DAILY LIMIT REACHED'
    WHERE query_count >= query_limit;

    UPDATE mt_api_query_count
    SET api_status = 'EXPIRED'
    WHERE query_date < '%s';
    """ % (date_now)
    return sql


def getApi(date_now, api_type):
    sql = """
    SELECT key_id, api_key, client_id, client_secret
    FROM mt_api_query_count
    WHERE api_status IS NULL AND query_date = '%s' AND api_type = '%s'
    """ % (date_now, api_type)
    return sql


def updateApiCount(add_count, query_date, key_id):
    sql = """
    UPDATE mt_api_query_count
    SET query_count = (query_count + %s)
    WHERE query_date = '%s' AND key_id = %s
    """ % (add_count, query_date, key_id)
    return sql


def createApiListTable():
    get_api_list = createApiList()
    api_list = pgsql.execScalar(api_list)


def checkDate():
    create_count_table = makeApiCountTable()
    pgsql.execScalar(create_count_table)
    date_now = dateNow()
    check_date = pgsql.fetchone(getDate(date_now))
    update_api_status = updateApiStatus(date_now)
    pgsql.execScalar(update_api_status)
    if check_date == None:
        insert_api = insertApi(date_now)
        pgsql.execScalar(insert_api)
    else:
        pass
    return date_now


def getGeocodeApi(date_now):
    get_geocode_api = getApi(date_now, 'geocode')
    geocode_api = pgsql.fetchone(get_geocode_api)
    if geocode_api == None:
        raise Exception(
            "Daily Google Places API query limit reached! Please retry tomorrow at 12:00 AM Pacific Time or increase your daily query limit.")
    else:
        return geocode_api


def getGPlacesApi(date_now):
    get_gplaces_api = getApi(date_now, 'google_places')
    gplaces_api = pgsql.fetchone(get_gplaces_api)
    if gplaces_api == None:
        raise Exception(
            "Daily Google Places API query limit reached! Please retry tomorrow at 12:00 AM Pacific Time or increase your daily query limit.")
    else:
        return gplaces_api


def updateCount(add_count, query_date, key_id):
    update_api_count = updateApiCount(add_count, query_date, key_id)
    pgsql.execScalar(update_api_count)
