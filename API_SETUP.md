# API Setup Guide for AkScore App

## 🔑 How to Get API Keys

### 1. Football Data API (Free)
- **Website**: https://www.football-data.org/client/register
- **Cost**: Free tier available
- **Rate Limit**: 10 requests per minute
- **Features**: Basic match and team data

**Steps:**
1. Go to https://www.football-data.org/client/register
2. Create a free account
3. Get your API key from the dashboard
4. Copy the key to `lib/config/api_config.dart`

### 2. RapidAPI - API-Football (Free)
- **Website**: https://rapidapi.com/api-sports/api/api-football
- **Cost**: Free tier available
- **Rate Limit**: 100 requests per day
- **Features**: Detailed team and player statistics

**Steps:**
1. Go to https://rapidapi.com/api-sports/api/api-football
2. Sign up for a free account
3. Subscribe to the free plan
4. Get your API key from the dashboard
5. Copy the key to `lib/config/api_config.dart`

## 🔧 How to Configure API Keys

### Step 1: Copy the Template
```bash
cp lib/config/api_config_template.dart lib/config/api_config.dart
```

### Step 2: Edit the Configuration File
Open `lib/config/api_config.dart` and replace the placeholder values:

```dart
class ApiConfig {
  // Replace with your actual API keys
  static const String footballDataApiKey = 'your_actual_football_data_key';
  static const String rapidApiKey = 'your_actual_rapid_api_key';
  
  // ... rest of the configuration
}
```

### Step 3: Test the Configuration
Run the app to test if the API keys work:
```bash
flutter run
```

## 🛡️ Security Notes

- ✅ The `api_config.dart` file is in `.gitignore` - it won't be committed to version control
- ✅ Keep your API keys private and don't share them
- ✅ Use environment variables for production deployments
- ✅ Monitor your API usage to avoid exceeding rate limits

## 🚀 Alternative: Use Mock Data

If you don't want to set up API keys right now, the app will automatically use mock data from `FakeApiService`. This allows you to test all features without real API calls.

## 📊 API Features

### Football Data API
- Live match scores
- Match details and events
- Team information
- League standings

### RapidAPI - API-Football
- Player statistics
- Team statistics
- Detailed match analytics
- Historical data

## 🔄 Switching Between Real and Mock Data

The app automatically uses:
- **Real API**: When valid API keys are configured
- **Mock Data**: When API keys are not configured or invalid

You can switch between them by updating the API keys in the configuration file.
