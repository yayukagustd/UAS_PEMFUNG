import React, { useEffect, useState, useCallback } from 'react';
import './App.css';
import axios from 'axios';

function App() {
  const [weatherData, setWeatherData] = useState(null);
  const [forecastData, setForecastData] = useState([]);
  const [dateTime, setDateTime] = useState({ date: '', time: '' });
  const [location, setLocation] = useState('');

  const updateDateTime = () => {
    const now = new Date();
    setDateTime({
      date: now.toDateString(),
      time: now.toLocaleTimeString()
    });
  };

  const fetchWeather = async () => {
    try {
      const response = await axios.get(`http://127.0.0.1:5000/get_weather`);
      setWeatherData(response.data);
    } catch (error) {
      console.error('Error fetching weather data:', error);
    }
  };

  const fetchForecast = async () => {
    try {
      const response = await axios.get(`http://localhost:5000/get_forecast`);
      setForecastData(response.data);
    } catch (error) {
      console.error('Error fetching forecast data:', error);
    }
  };

  const handleGeolocationError = (error) => {
    console.error('Error getting geolocation:', error);
  };

  const showPosition = useCallback(async (position) => {
    const newPosition = { latitude: position.coords.latitude, longitude: position.coords.longitude };
    try {
      const response = await axios.get(
        `https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${newPosition.latitude}&lon=${newPosition.longitude}&accept-language=en`
      );
      const location = response.data.display_name;
      setLocation(location);
      fetchWeather();
      fetchForecast();
    } catch (error) {
      console.error('Error fetching reverse geocoding data:', error);
    }
  }, []);

  const getLocation = useCallback(() => {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(showPosition, handleGeolocationError, {
        enableHighAccuracy: true,
        timeout: 5000,
        maximumAge: 0,
      });
    } else {
      console.log('Geolocation is not supported by this browser.');
    }
  }, [showPosition]);

  useEffect(() => {
    getLocation();
    updateDateTime();
    const intervalId = setInterval(updateDateTime, 1000);
    return () => clearInterval(intervalId);
  }, [getLocation]);

  const handleRefresh = () => {
    window.location.reload();
  };

  if (!weatherData || forecastData.length === 0) {
    return <div>Loading...</div>;
  }

  return (
    <div className="weather-container">
      <h1>My Weather App</h1>
      <div className="date-time">
        <div className="temperature-container">
          <p id="temperature">{weatherData.temperature}°C</p>
        </div>
        <div className="clock-container">
          <div className="clock-section">{dateTime.time}</div>
        </div>
      </div>
      <div className="weather-info">
        <div className="icon">
          <img id="icon" src={`http://openweathermap.org/img/wn/${weatherData.icon}.png`} alt="weather icon" />
        </div>
      </div>
      <div className="weather-details">
        <p id="temperature-label">INFORMATION</p> {/* Tambahkan label keterangan suhu */}
        <p><span className="label">Feels like: </span><span id="feelsLike">{weatherData.feels_like}°C</span></p>
        <p><span className="label">Pressure: </span><span id="pressure">{weatherData.pressure} hPa</span></p>
        <p><span className="label">Humidity: </span><span id="humidity">{weatherData.humidity}%</span></p>
        <p><span className="label">Wind Speed: </span><span id="windSpeed">{weatherData.wind_speed} m/s</span></p>
        <p><span className="label">Dew Point: </span><span id="dewPoint">{weatherData.dew_point}°C</span></p>
      </div>
      <div className="location">
        <p id="currentDate">{dateTime.date}</p>
        <p id="selectedCity">{location}</p>
      </div>
      <div className="forecast-container">
        {forecastData.map((forecast, index) => (
          <div className="forecast-day" key={index}>
            <p className="day">{new Date(forecast.dt_txt).toLocaleDateString('en-US', { weekday: 'short' })}</p>
            <img src={`http://openweathermap.org/img/wn/${forecast.weather[0].icon}.png`} alt="weather icon" />
            <p className="temperature">{Math.round(forecast.main.temp)}°C</p>
          </div>
        ))}
      </div>
      <button id="refreshWeatherData" onClick={handleRefresh}>
        Refresh
      </button>
    </div>
  );
}

export default App;
