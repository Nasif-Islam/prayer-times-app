# Import the required libraries - for web app creation and for JSON responses
from flask import Flask, jsonify
from flask_cors import CORS
import requests  # Used to make HTTP requests to external APIs

# Initialize the Flask application
app = Flask(__name__)
# Allows cross-origin requests (for React frontend)
CORS(app)


# Root route of the application
@app.route("/")
def home():
    """Health check route"""
    return "Prayer Times App is live!"


# Route to fetch prayer times for a specific city and country
@app.route("/prayer-times/<city>/<country>")
def prayer_times(city, country):
    # Clean input
    city = city.strip()
    country = country.strip()
    if not city or not country:
        return jsonify({"error": "City and country are required"}), 400

    # Build request
    url = "http://api.aladhan.com/v1/timingsByCity"
    params = {"city": city, "country": country, "method": 2}

    try:
        response = requests.get(url, params=params, timeout=5)
        response.raise_for_status()
    except requests.exceptions.RequestException as e:
        return jsonify({"error": "Failed to contact AlAdhan API", "detail": str(e)}), 502

    payload = response.json()
    data = payload.get("data") or {}

    return jsonify({
        "status": "success",
        "city": city,
        "country": country,
        "data": {
            "date": data.get("date", {}).get("readable"),
            "timings": data.get("timings", {})
        }
    })


if __name__ == "__main__":
    # Run the Flask app locally
    app.run(host="0.0.0.0", port=8000)
