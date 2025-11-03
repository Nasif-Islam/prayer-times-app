import "./App.css";
import { useState } from "react";
import axios from "axios";

function App() {
  const [city, setCity] = useState("");
  const [country, setCountry] = useState("");
  const [timings, setTimings] = useState(null);
  const [error, setError] = useState("");

  const fetchPrayerTimes = async () => {
    try {
      const response = await axios.get(`http://127.0.0.1:8000/prayer-times/${city}/${country}`);
      setTimings(response.data.data.timings);
      setError("");
    } catch (err) {
      setError("Could not fetch prayer times. Please check your input.");
      setTimings(null);
    }
  };

  return (
    <div style={{ fontFamily: "Arial", padding: "40px", textAlign: "center" }}>
      <h1>🕌 Prayer Times App</h1>

      <input
        type="text"
        placeholder="City"
        value={city}
        onChange={(e) => setCity(e.target.value)}
        style={{ margin: "5px", padding: "8px" }}
      />
      <input
        type="text"
        placeholder="Country"
        value={country}
        onChange={(e) => setCountry(e.target.value)}
        style={{ margin: "5px", padding: "8px" }}
      />
      <button onClick={fetchPrayerTimes} style={{ padding: "10px 20px", margin: "10px" }}>
        Get Prayer Times
      </button>

      {error && <p style={{ color: "red" }}>{error}</p>}

      {timings && (
        <div style={{ marginTop: "20px" }}>
          <h2>Prayer Times for {city}, {country}</h2>
          <ul style={{ listStyle: "none", padding: 0 }}>
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
