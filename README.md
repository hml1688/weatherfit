# Weatherfit
App Icon:  

<img src="https://github.com/hml1688/weatherfit/blob/main/assets/icon/closet.png"  alt="icon" style="width: 150px; height: auto;">  
WeatherFit is a smart outfit recommendation app that combines real-time weather data with various clothing suggestions. It helps users dress comfortably and stylishly by offering outfit ideas based on the full-day temperature range.

## 1. Landing Page
https://hml1688.github.io/weatherfit/WeatherfitLandingPage/landingpage.html

This website introduces the motivation and detailed functions of weatherfit, and are accompanied by corresponding screenshots of the app operation. If users are interested, they can also click the "get started" button at the beginning to go to the weatherfit github page to learn more.

## 2. Motivation  
WeatherFit was created to solve a common daily problem: many people find it hard to decide what to wear based on just the temperature in the weather forecast. It’s difficult to translate numbers into actual clothing choices, especially when considering personal comfort. This app helps users by recommending appropriate outfits based on the full temperature range of the day. It also encourages style exploration by offering varied combinations and sharing inspirations from others.  
<div style="display: flex; justify-content: space-between;">
  <img src="https://github.com/hml1688/weatherfit/blob/main/assets/storyboarding.png" alt="storyboarding" style="width: 300px; height: auto;">
  <img src="https://github.com/hml1688/weatherfit/blob/main/assets/wireframes%20design.jpg" alt="wireframes design" style="width: 300px; height: auto;">
</div>  
<br> This storyboard shows a typical user scenario. A girl looks out the window and isn’t sure how to dress for the day. She remembers feeling cold last time at 18°C, even with a light jacket. Then she recalls the WeatherFit app, which gives personalized outfit suggestions. She checks it, gets a sweatshirt recommendation for today’s 20°C, and heads out feeling warm and happy.  

## 3. App showcase  
Find video here: https://www.youtube.com/watch?v=KbrM4y_c3W8  

## 4. Detailed Function  
1) Real-Time Weather Detection: Automatically locates the user and retrieves detailed weather data, including temperature range and wind speed.
<img src="https://github.com/hml1688/weatherfit/blob/main/docs/weather.png" alt="weatherscreen" style="width: 300px; height: auto;">

2) Smart Outfit Suggestions: Matches weather data with clothing items based on their ideal temperature range to generate diverse outfit recommendations.
<img src="https://github.com/hml1688/weatherfit/blob/main/docs/different%20recommendation.png" alt="recommendationcreen" style="width: 300px; height: auto;">

3) Interactive Shake-to-Refresh: Users can shake their phone to get a new outfit suggestion, making the experience fun and engaging.
   <img src="https://github.com/hml1688/weatherfit/blob/main/docs/gyroscope.png" alt="newrecommendation" style="width: 300px; height: auto;">

4) Outfit Collection & Community Inspiration: Users can save their favorite outfit-weather combinations and explore looks shared by others to get styling ideas for future weather conditions.
   
   <img src="https://github.com/hml1688/weatherfit/blob/main/docs/add%20favorite.png" alt="add favorite" style="width: 300px; height: auto;">
   <img src="https://github.com/hml1688/weatherfit/blob/main/docs/favorite.png" alt="favoritecreen" style="width: 300px; height: auto;">

## 5. Module Interaction Diagram and Data flow diagram  
1) Module Interaction Diagram
This diagram shows how different parts of the app work together. When the user gives location access, we pull live weather data through the OpenWeather API. At the same time, the phone’s motion sensor detects shake gestures to refresh the outfit. These two inputs — weather and interaction — come together in the recommendation engine, which picks suitable clothes based on temperature. The results are shown in the app and saved to Firestore for future use.
<img src="https://github.com/hml1688/weatherfit/blob/main/docs/Module%20interaction.png" alt="Module Interaction" style="width: 300px; height: auto;">

2) Data Lifecycle Flow
This flow shows how data moves through the app. It starts when the user shares their location — triggering the weather API to pull temperature info. The recommendation engine uses this to select outfits that match the conditions. These suggestions are saved to Firestore, so the user can see past choices.
<img src="https://github.com/hml1688/weatherfit/blob/main/docs/Data%20flow.png" alt="data flow" style="width: 300px; height: auto;">

## 6. Install The App  

### 📲 How to Download & Run WeatherFit

You have two easy ways to try out the WeatherFit app:

#### ✅ Option 1: Download Pre-Built APK

1. Visit the Releases section of this repository. 
2. Download the latest version from the **Assets** list:
   - `app-release.apk` — for direct installation on Android.
   - `app-release.aab` — for Play Store upload.
   - `Source code (zip/tar.gz)` — If you'd like to explore the full project.
3. Install the APK on your Android device.
   - You may need to enable *Install unknown apps* in your device settings.

---

#### 🛠 Option 2: Build from Source (Flutter)

1. **Clone this repository**:
   ```bash
   git clone https://github.com/your-username/weatherfit.git
   cd weatherfit
2. **Install dependencies**:
   ```bash
   flutter pub get
3. **Run the app on a connected Android device or emulator**:
   ```bash
   flutter run
4. **You’ll need Flutter SDK installed. Check your environment using**:
   ```bash
   flutter doctor

## 7. ☁️ API Usage Documentation

WeatherFit leverages the **OpenWeatherMap API** to power real-time outfit recommendations.  
### 🔗 API Endpoint:  api.openweathermap.org    

  
---

### ⚙️ How WeatherFit Uses This Data

1. The app retrieves the user’s location using device GPS.
2. It calls the OpenWeather API to fetch the upcoming 5-day hourly forecast.
3. From the data, it extracts:
   - **Min and Max temperature of the day**
   - **Wind speed**
4. It passes this data to the **outfit recommendation engine**, which:
   - Compares temperature ranges with clothing metadata.
   - Selects suitable tops and bottoms that match the comfort range.
   - Randomly combines filtered results into a full outfit suggestion.
5. The result is displayed to the user and optionally stored in Firebase for future reference.

---

### 🔐 Setting Up Your API Key

To make API calls work, follow these steps:

1. Sign up or log in at [OpenWeatherMap](https://openweathermap.org/).
2. Go to your profile and generate an API key.
3. Replace the placeholder key in the following file: lib/services/weather_service.dart

Look for the line like this and insert your key:
 ```dart
final apiKey = 'YOUR_API_KEY_HERE';  
 ```

##  Contact Details 

🎉 Welcome for your comment!  
📝 Contact Email: ucfnaoa@ucl.ac.uk
