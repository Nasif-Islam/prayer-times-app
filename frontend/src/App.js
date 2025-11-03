import "./App.css";
import { useState, useEffect } from "react";
import axios from "axios";

function App() {
  const [city, setCity] = useState("");
  const [country, setCountry] = useState("");
  const [timings, setTimings] = useState(null);
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);
  const [darkMode, setDarkMode] = useState(false);

  const API_URL = process.env.REACT_APP_API_URL || "http://127.0.0.1:8000";

  useEffect(() => {
    document.body.className = darkMode ? "dark-mode" : "";
  }, [darkMode]);

  const fetchPrayerTimes = async () => {
    if (!city || !country) {
      setError("Please enter both city and country.");
      return;
    }

    setLoading(true);
    setError("");
    setTimings(null);

    try {
      const response = await axios.get(`${API_URL}/prayer-times/${city}/${country}`);
      setTimings(response.data.data.timings);
    } catch {
      setError("Could not fetch prayer times. Please check your input.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="app-container">
      <button
        className="theme-toggle"
        onClick={() => setDarkMode(!darkMode)}
      >
        {darkMode ? "☀️ Light Mode" : "🌙 Dark Mode"}
      </button>

      <h1>🕌 Prayer Times App</h1>

      <input
        type="text"
        placeholder="City"
        value={city}
        onChange={(e) => setCity(e.target.value)}
        onKeyDown={(e) => e.key === "Enter" && fetchPrayerTimes()}
      />
      <input
        type="text"
        placeholder="Country"
        value={country}
        onChange={(e) => setCountry(e.target.value)}
        onKeyDown={(e) => e.key === "Enter" && fetchPrayerTimes()}
      />
      <button onClick={fetchPrayerTimes}>Get Prayer Times</button>

      {loading && <p className="loading">Fetching prayer times...</p>}
      {error && <p className="error">{error}</p>}

      {timings && Object.keys(timings).length > 0 && (
        <div className="results">
          <h2>Prayer Times for {city}, {country}</h2>
          <ul>
            {Object.entries(timings).map(([name, time]) => (
              <li key={name}><strong>{name}</strong>: {time}</li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
}

export default App;
