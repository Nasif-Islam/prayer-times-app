# Import the required libraries - for web app creation and for JSON responses

from flask import Flask, jsonify
from flask_cors import CORS
import requests  # Used to make HTTP requests to external APIs

# Initialize the Flask application
app = Flask(__name__)
CORS(app)


# This is the root route of the application
# When you visit the base URL ("/"), it will return a simple message confirming the app is running.
@app.route("/")
def home():
    return "Prayer Times App is live!"


# This route takes two URL parameters: city and country
# It fetches prayer times for the given location from the AlAdhan API
@app.route("/prayer-times/<city>/<country>")
def prayer_times(city, country):
    # Construct the API URL dynamically using the city and country provided by the user
    url = f"http://api.aladhan.com/v1/timingsByCity?city={city}&country={country}&method=2"

    # Send a GET request to the AlAdhan API
    response = requests.get(url)

    if response.status_code == 200:  # Successful response
        return jsonify(
            response.json()
        )  # Convert the API response to JSON and send it to the user
    else:
        # If the API request fails, return an error message and HTTP status code is 500
        return jsonify({"error": "Unable to fetch prayer times"}), 500


# This block ensures the app runs only if this file is executed directly
# It runs the Flask app on host '0.0.0.0' (accessible from any network interface) and port 8000 (changeable if needed).
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
