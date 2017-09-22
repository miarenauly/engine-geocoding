import googlemaps
import json
import requests
from datetime import datetime, timedelta
from time import time, sleep
import sys
sys.path.append('library')
from active_record import *
from apicounter import *
from cleansing import *
from pgsql import *
from logger import *


def geocode(table_name, idx, fixed_address, adm_list, keterangan, time_start, date_now):
    # Get Geocode API key from database
    geocode_api = getGeocodeApi(date_now)
    gc_key_id = geocode_api[0]
    # gc_api_key = geocode_api[1]
    gc_client_id = geocode_api[2]
    gc_private_key = geocode_api[3]
    for admin_location in adm_list:
        try:
            full_address = (fixed_address + '  ' +
                            admin_location + ' INDONESIA')
            full_address = cleansingFullAddress(full_address)
            print(full_address + '\t:')
            add_count = 0.25
            updateCount(add_count, date_now, gc_key_id)
            g = googlemaps.Client(client_id=gc_client_id,
                                  client_secret=gc_private_key, retry_timeout=60)
            obj = g.geocode(address=full_address, language='id')
            place_id = obj[0]['place_id']
            reverse_address = obj[0]['formatted_address']
            lng = obj[0]['geometry']['location']['lng']
            lat = obj[0]['geometry']['location']['lat']
            address_components = obj[0]['address_components']
            village = ''
            sub_district = ''
            district = ''
            province = ''
            country = ''
            for adm_details in address_components:
                if 'administrative_area_level_4' in adm_details['types'][0]:
                    village = adm_details['long_name']
                elif 'administrative_area_level_3' in adm_details['types'][0]:
                    sub_district = adm_details['long_name']
                elif 'administrative_area_level_2' in adm_details['types'][0]:
                    district = adm_details['long_name']
                elif 'administrative_area_level_1' in adm_details['types'][0]:
                    province = adm_details['long_name']
                elif 'country' in adm_details['types'][0]:
                    country = adm_details['long_name']
            end_geocode = datetime.now()
            keterangan = 'GOOGLE MAPS GEOCODING'
            time_end = end_geocode.strftime("%Y-%m-%d %H:%M:%S")
            update_result = updateGeocodeResult(table_name, lng, lat, '', reverse_address, village,
                                                sub_district, district, province, keterangan, time_start, time_end, idx)
            execScalar(update_result)
            print('\t [GEOCODE LOCATION FOUND]')
            break

        except (KeyError, IndexError) as e:
            print('\t [GEOCODE LOCATION NOT FOUND]')
            update_error = updateFlagError(table_name, idx)
            execScalar(update_error)


def google_places(table_name, idx, fixed_address, adm_list, keterangan, time_start, date_now):
    # Get Google Places API key from database
    gplaces_api = getGPlacesApi(date_now)
    gp_key_id = gplaces_api[0]
    gp_api_key = gplaces_api[1]
    for admin_location in adm_list:
        try:
            full_address = (fixed_address + ' ' +
                            admin_location + ' INDONESIA')
            full_address = cleansingFullAddress(full_address)
            print(full_address + '\t:')

            # getting place infromation using Google Place autocomplete
            place_url = "https://maps.googleapis.com/maps/api/place/details/json"
            query = full_address.replace(" ", "+")
            params = dict(
                query=query,
                key=gp_api_key,
                language='id')
            add_count = 0.1
            updateCount(add_count, date_now, gp_key_id)
            resp = requests.get(url=place_url, params=params)
            obj = json.loads(resp.text)
            if obj['results'][0] == True:
                result = (obj['results'][0])
            else:
                result = (obj['results'][0])
            village = adm_details['long_name']
            village = adm_details['long_name']
            place_id = (result['place_id'])

            # getting administrative infromation using Place Details
            keterangan = 'GOOGLE PLACES'
            google_places_details(table_name, time_start, place_id,
                                  keterangan, idx, gp_key_id, date_now, gp_api_key)
            print('\t [PLACES LOCATION FOUND]')
            break

        except (KeyError, IndexError) as e:
            print('\t [PLACES LOCATION NOT FOUND]')
            update_error = updateFlagError(table_name, idx)
            execScalar(update_error)


def combined(table_name, idx, fixed_address, adm_list, keterangan, time_start, date_now):
    # Get Geocode API key from database
    geocode_api = getGeocodeApi(date_now)
    gc_key_id = geocode_api[0]
    gc_client_id = geocode_api[2]
    gc_private_key = geocode_api[3]

    # Get Google Places API key from database
    gplaces_api = getGPlacesApi(date_now)
    gp_key_id = gplaces_api[0]
    gp_api_key = gplaces_api[1]
    for admin_location in adm_list:
        try:
            full_address = (fixed_address + ' ' +
                            admin_location + ' INDONESIA')
            full_address = cleansingFullAddress(full_address)
            print(full_address + '\t:')

            # Getting Place ID of given address by Geocode
            add_count = 0.25
            updateCount(add_count, date_now, gc_key_id)
            g = googlemaps.Client(client_id=gc_client_id,
                                  client_secret=gc_private_key, retry_timeout=60)
            obj = g.geocode(address=full_address, language='id')
            place_id = obj[0]['place_id']

            # If address found in Geocode, We'll use Google Places API
            # to get Place Name and other details by using the Place ID
            keterangan = 'GOOGLE MAPS GEOCODING'
            google_places_details(table_name, time_start, place_id,
                                  keterangan, idx, gp_key_id, date_now, gp_api_key)
            print('\t [GEOCODE LOCATION FOUND]')
            break

        except (KeyError, IndexError) as e:
            print('\t [GEOCODE LOCATION NOT FOUND]')
            update_error = updateFlagError(table_name, idx)
            execScalar(update_error)


def google_places_details(table_name, time_start, place_id, keterangan, idx, gp_key_id, date_now, gp_api_key
                          ):
    add_count = 2
    updateCount(add_count, date_now, gp_key_id)
    place_url = "https://maps.googleapis.com/maps/api/place/details/json"
    params = dict(
        placeid=place_id,
        key=gp_api_key,
        language='id')
    resp = requests.get(url=place_url, params=params)
    obj = json.loads(resp.text)
    result = (obj['result'])
    place_id = (result['place_id'])
    place_name = (result['name'])
    place_name = place_name.replace("'", "")
    place_address = (result['formatted_address'])
    place_address = place_address.replace("'", "")
    place_lat = float(result['geometry']['location']['lat'])
    place_lng = float(result['geometry']['location']['lng'])
    print('\t[' + place_name + '\t:' + place_address + ']')
    address_components = result['address_components']
    village = ''
    sub_district = ''
    district = ''
    province = ''
    country = ''
    for adm_details in address_components:
        if 'administrative_area_level_4' in adm_details['types'][0]:
            village = adm_details['long_name']
        elif 'administrative_area_level_3' in adm_details['types'][0]:
            sub_district = adm_details['long_name']
        elif 'administrative_area_level_2' in adm_details['types'][0]:
            district = adm_details['long_name']
        elif 'administrative_area_level_1' in adm_details['types'][0]:
            province = adm_details['long_name']
        elif 'country' in adm_details['types'][0]:
            country = adm_details['long_name']

    end_geocode = datetime.now()
    time_end = end_geocode.strftime("%Y-%m-%d %H:%M:%S")
    update_result = updateGeocodeResult(table_name, place_lng, place_lat, place_name, place_address,
                                        village, sub_district, district, province, keterangan, time_start, time_end, idx)
    execScalar(update_result)


def runData1(table_name, kode_data, idx, ori_name, cleanse_address_1, cleanse_address_2, cleanse_address_3, adm_list, time_start, date_now):
    # if ori_name exists, use ori_name instead of ori_address
    cleanse_address = [cleanse_address_1, cleanse_address_2, cleanse_address_3]
    keterangan = ''
    get_flag = getFlag(table_name, idx)
    updateError = updateFlagError(table_name, idx)
    execScalar(updateError)
    for address in cleanse_address:
        flag = fetchone(get_flag)[0]
        if flag == 'E' and address is not '':
            geocode(table_name, idx, address,
                    adm_list, keterangan, time_start, date_now)
        else:
            continue

    for address in cleanse_address:
        flag = fetchone(get_flag)[0]
        if flag == 'E' and address is not '':
            google_places(table_name, idx, address,
                          adm_list, keterangan, time_start, date_now)
        else:
            continue

    flag = fetchone(get_flag)[0]
    if flag == 'E' and len(adm_list) != 0:
        adm_list = [x for x in adm_list if x != '']
        ori_name = ''
        fixed_address = ''
        keterangan = 'CENTROID'
        print('[=========== RUN CENTROID ==========]')
        combined(table_name, idx, fixed_address,
                 adm_list, keterangan, time_start, date_now)

    flag = fetchone(get_flag)[0]
    if flag == 'E':
        end_geocode = datetime.now()
        time_end = end_geocode.strftime("%Y-%m-%d %H:%M:%S")
        update_error = updateKetError(
            table_name, time_start, time_end, idx)
        execScalar(update_error)


def runData2(table_name, kode_data, idx, ori_name, cleanse_address_1, cleanse_address_2, cleanse_address_3, adm_list, time_start, date_now):
    get_flag = getFlag(table_name, idx)
    keterangan = ''
    # if ori_name exists, use ori_name instead of ori_address
    if ori_name is not None:
        combined(table_name, idx, ori_name,
                 adm_list, keterangan, time_start, date_now)
    elif ori_name is None and cleanse_address_3 is not None:
        combined(table_name, idx, cleanse_address_3,
                 adm_list, keterangan, time_start, date_now)
    else:
        updateError = updateFlagError(table_name, idx)
        execScalar(updateError)

    flag = fetchone(get_flag)[0]
    if flag == 'E' and cleanse_address_1 is not '':
        combined(table_name, idx, cleanse_address_1,
                 adm_list, keterangan, time_start, date_now)

    flag = fetchone(get_flag)[0]
    if flag == 'E' and cleanse_address_2 is not '':
        combined(table_name, idx, cleanse_address_2,
                 adm_list, keterangan, time_start, date_now)

    cleanse_address = [cleanse_address_1, cleanse_address_2, cleanse_address_3]
    for address in cleanse_address:
        flag = fetchone(get_flag)[0]
        if flag == 'E' and address is not '':
            google_places(table_name, idx, address,
                          adm_list, keterangan, time_start, date_now)
        else:
            continue

    flag = fetchone(get_flag)[0]
    if flag == 'E' and len(adm_list) != 0:
        adm_list = [x for x in adm_list if x != '']
        ori_name = ''
        fixed_address = ''
        keterangan = 'CENTROID'
        print('\t[=====RUN CENTROID=====]')
        combined(table_name, idx, fixed_address,
                 adm_list, keterangan, time_start, date_now)

    flag = fetchone(get_flag)[0]
    if flag == 'E':
        end_geocode = datetime.now()
        time_end = end_geocode.strftime("%Y-%m-%d %H:%M:%S")
        update_error = updateKetError(
            table_name, time_start, time_end, idx)
        execScalar(update_error)


def run(table_name, kode_data, idx, ori_name, cleanse_address_1, cleanse_address_2, cleanse_address_3, adm_list, time_start, date_now):
    for attempt in range(3):
        try:
            if kode_data == 1:
                runData1(table_name, kode_data, idx, ori_name, cleanse_address_1,
                         cleanse_address_2, cleanse_address_3, adm_list, time_start, date_now)
            if kode_data == 2:
                runData2(table_name, kode_data, idx, ori_name, cleanse_address_1,
                         cleanse_address_2, cleanse_address_3, adm_list, time_start, date_now)
        except (requests.exceptions.SSLError, requests.exceptions.ConnectionError, requests.exceptions.ReadTimeout) as requests_error:
            sleep(5)
            if kode_data == 1:
                runData1(table_name, kode_data, idx, ori_name, cleanse_address_1,
                         cleanse_address_2, cleanse_address_3, adm_list, time_start, date_now)
            if kode_data == 2:
                runData2(table_name, kode_data, idx, ori_name, cleanse_address_1,
                         cleanse_address_2, cleanse_address_3, adm_list, time_start, date_now)
        else:
            break
    else:
        print("has tried 3 times but fail")


def retry_timeout(table_name, kode_data, idx, ori_name, cleanse_address_1, cleanse_address_2, cleanse_address_3, adm_list, time_start, date_now):
    start_exec = time()
    while (time() - start_exec < 45):
        run(table_name, kode_data, idx, ori_name, cleanse_address_1,
            cleanse_address_2, cleanse_address_3, adm_list, time_start, date_now)
        break

    else:
        run(table_name, kode_data, idx, ori_name, cleanse_address_1,
            cleanse_address_2, cleanse_address_3, adm_list, time_start, date_now)


def main(table_name):
    global time
    sql = updateKodeData(table_name)
    execScalar(sql)
    query = getAddressGeocode(table_name)
    fetch_data = fetch(query)

    for row in fetch_data:
        idx = row[1]
        sql = updateFlagProcess(table_name, idx)
        execScalar(sql)

    start = time()
    for row in fetch_data:
        start_geocode = datetime.now()
        time_start = start_geocode.strftime("%Y-%m-%d %H:%M:%S")
        date_now = checkDate()
        # Get Geocode Details
        kode_data = row[0]
        idx = row[1]
        ori_name = row[2]
        ori_address = str(row[3] or '')
        ori_vi = str(row[4] or '')
        ori_su = str(row[5] or '')
        ori_di = str(row[6] or '')
        ori_pr = str(row[7] or '')
        cleanse_address_1 = str(row[8] or '')
        cleanse_address_2 = str(row[9] or '')
        cleanse_address_3 = str(row[10] or '')
        ori_address = ori_address.replace("'", "")
        ori_vi = cleansingVillage(ori_vi)
        ori_su = cleansingSubDistrict(ori_su)
        ori_di = cleansingDistrict(ori_di)
        ori_pr = cleansingProvince(ori_pr)
        ori_vi = cleansingVillage(ori_vi)
        adm_list_old = [ori_vi, ori_su, ori_di]
        adm_list = []
        adm_present = [x for x in adm_list_old if x is not '']
        jml_adm = len(adm_present)
        while jml_adm >= 1:
            adm_str = ' '.join(adm_present)
            adm_list.append(adm_str)
            # print(adm_str)
            del adm_present[0]
            jml_adm -= 1
        if len(adm_list) >= 1 and ori_pr is not '':
            adm_list = [x + ' ' + ori_pr for x in adm_list]
        elif adm_list == [] and ori_pr is not '':
            adm_list = [ori_pr]
        elif adm_list == [] and ori_pr is '':
            adm_list = ['']

        retry_timeout(table_name, kode_data, idx, ori_name, cleanse_address_1,
                      cleanse_address_2, cleanse_address_3, adm_list, time_start, date_now)

    end = time()
    print("\nGEOCODE PROCESS DONE IN %s SECOND==========" % (end - start))

    # Update Administrative Information by intersecting Coordinate from Google
    # Places to Admin Shapefile
    print("\nGETTING ADMINISTRATIVE INFORMATION FROM DATABASE...")
    for row_temp in fetch_data:
        idx = row_temp[1]
        updateadm = updateAdmIntersect(table_name, idx)
        execScalar(updateadm)
    # Finding nearest polygon if point not overlap with polygons during
    # intersects
    check_point = getAdmInside(table_name)
    data_not_overlap = fetch(check_point)
    for row_temp2 in data_not_overlap:
        idx = row_temp2[0]
        update_nearest_adm = updateAdmNearest(table_name, idx)
        execScalar(update_nearest_adm)
    print("\nGETTING ADMINISTRATIVE INFORMATION FROM DATABASE DONE")

# main("testt")
# main(sys.argv[1])
