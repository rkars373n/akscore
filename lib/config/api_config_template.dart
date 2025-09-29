// API Configuration Template
// Copy this file to api_config.dart and add your actual API keys
// Keep api_config.dart private and don't commit it to version control

class ApiConfig {
  // Football Data API Key
  // Get your free API key from: https://www.football-data.org/client/register
  static const String footballDataApiKey = 'YOUR_FOOTBALL_DATA_API_KEY';
  
  // RapidAPI Key for API-Football
  // Get your API key from: https://rapidapi.com/api-sports/api/api-football
  static const String rapidApiKey = 'YOUR_RAPID_API_KEY';
  
  // API Base URLs
  static const String footballDataBaseUrl = 'https://api.football-data.org/v4';
  static const String rapidApiBaseUrl = 'https://api-football-v1.p.rapidapi.com/v3';
  
  // Rate limiting (requests per minute)
  static const int footballDataRateLimit = 10; // Free tier limit
  static const int rapidApiRateLimit = 100; // Free tier limit
}
