from flask import Flask, jsonify, request
import requests
import pymysql
from flask_cors import CORS

app = Flask(__name__)

CORS(app)

db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': '',  
    'database': 'weather1_db',
    'charset': 'utf8mb4',
    'cursorclass': pymysql.cursors.DictCursor
}

def create_tables():
    connection = pymysql.connect(**db_config)
    try:
        with connection.cursor() as cursor:
            cursor.execute("""
            CREATE TABLE IF NOT EXISTS error (
                id INT AUTO_INCREMENT PRIMARY KEY,
                error_message TEXT NOT NULL,
                timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            );
            """)
            cursor.execute("""
            CREATE TABLE IF NOT EXISTS weather_data (
                id INT AUTO_INCREMENT PRIMARY KEY,
                temperature FLOAT NOT NULL,
                humidity FLOAT NOT NULL,
                wind_speed FLOAT NOT NULL,
                dew_point FLOAT NOT NULL,
                icon VARCHAR(50) NOT NULL,
                timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            );
            """)
            connection.commit()
    finally:
        connection.close()


def log_error(message):
    connection = pymysql.connect(**db_config)
    try:
        with connection.cursor() as cursor:
            cursor.execute("INSERT INTO error (error_message) VALUES (%s)", (message,))
            connection.commit()
    finally:
        connection.close()


def save_weather_data(weather_data):
    connection = pymysql.connect(**db_config)
    try:
        with connection.cursor() as cursor:
            cursor.execute("INSERT INTO weather_data (temperature, humidity, wind_speed, dew_point, icon) VALUES (%s, %s, %s, %s, %s)",
                           (weather_data['temperature'], weather_data['humidity'], weather_data['wind_speed'], weather_data['dew_point'], weather_data['icon']))
            connection.commit()
    finally:
        connection.close()


def get_ip_geolocation():
    try:
     
        response = requests.get('http://ip-api.com/json/')
        response.raise_for_status()
        data = response.json()
        return {'latitude': data['lat'], 'longitude': data['lon']}
    except requests.exceptions.RequestException as e:
        log_error(str(e))
        return None

def get_weather_forecast(latitude, longitude):
    try:
        api_key = '22b45438c064c52dee7e17bd34c64c0f'
        url = f'https://api.openweathermap.org/data/2.5/forecast?lat={latitude}&lon={longitude}&appid={api_key}&units=metric'
        response = requests.get(url)
        response.raise_for_status()
        forecast_data = response.json()['list']
        daily_forecast = [forecast for index, forecast in enumerate(forecast_data) if index % 8 == 0]
        return daily_forecast
    except requests.exceptions.RequestException as e:
        log_error(str(e))
        return None
    
@app.route('/get_forecast')
def get_forecast():
    try:
        location = get_ip_geolocation()
        if location:
            latitude = location['latitude']
            longitude = location['longitude']
            
            forecast_data = get_weather_forecast(latitude, longitude)
            if forecast_data:
                return jsonify(forecast_data)
            else:
                return jsonify({'error': 'Gagal mendapatkan ramalan cuaca'})
        else:
            return jsonify({'error': 'Gagal mendapatkan geolokasi'})

    except Exception as e:
        log_error(str(e))
        return jsonify({'error': 'Terjadi kesalahan dalam memproses permintaan'})

@app.route('/get_weather')
def get_weather():
    try:
        api_key = '22b45438c064c52dee7e17bd34c64c0f'

        location = get_ip_geolocation()
        if location:
            latitude = location['latitude']
            longitude = location['longitude']

            url = f'https://api.openweathermap.org/data/2.5/weather?lat={latitude}&lon={longitude}&appid={api_key}&units=metric'
            response = requests.get(url)
            response.raise_for_status()

            weather_data = {
                'temperature': response.json()['main']['temp'],
                'humidity': response.json()['main']['humidity'],
                'wind_speed': response.json()['wind']['speed'],
                'dew_point': response.json()['main']['temp'] - ((100 - response.json()['main']['humidity']) / 5),
                'feels_like': response.json()['main']['feels_like'],
                'pressure': response.json()['main']['pressure'],
                'icon': response.json()['weather'][0]['icon']
            }

            save_weather_data(weather_data)

            return jsonify(weather_data)
        
        else:
            return jsonify({'error': 'Gagal mendapatkan geolokasi'})
        
    except requests.exceptions.RequestException as e:
        log_error(str(e))
        
        return jsonify({'error': 'Tidak tersambung ke internet atau terjadi kesalahan dalam mengambil data cuaca'})

    except Exception as e:
        log_error(str(e))
        return jsonify({'error': 'Terjadi kesalahan dalam memproses permintaan'})

@app.route('/logs')
def get_logs():
    try:
        connection = pymysql.connect(**db_config)
        try:
            with connection.cursor() as cursor:
                cursor.execute("SELECT * FROM error")
                logs = cursor.fetchall()
        finally:
            connection.close()
        return jsonify(logs)
    
    except requests.exceptions.RequestException as e:
        log_error(str(e))
        return jsonify({'error': 'Tidak tersambung ke internet atau terjadi kesalahan lain'})

    except Exception as e:
        log_error(str(e))
        return jsonify({'error': 'Terjadi kesalahan dalam memproses permintaan'})

if __name__ == '__main__':
    create_tables()
    app.run(debug=True)
