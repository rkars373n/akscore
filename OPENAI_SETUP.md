# 🤖 OpenAI Extension Setup Guide

## Issue
The VS Code OpenAI extension is showing this error:
```
Error: The OPENAI_API_KEY environment variable is missing or empty
```

## Solutions

### 🔑 Method 1: Environment Variable (Recommended)

#### For Windows:

**PowerShell:**
```powershell
# Set for current session
$env:OPENAI_API_KEY = "sk-your-api-key-here"

# Set permanently (requires restart)
[Environment]::SetEnvironmentVariable("OPENAI_API_KEY", "sk-your-api-key-here", "User")
```

**Command Prompt:**
```cmd
setx OPENAI_API_KEY "sk-your-api-key-here"
```

**System Properties:**
1. Press `Win + R`, type `sysdm.cpl`
2. Go to Advanced → Environment Variables
3. Add new User Variable:
   - Name: `OPENAI_API_KEY`
   - Value: `sk-your-api-key-here`

#### For macOS/Linux:
```bash
# Add to ~/.bashrc or ~/.zshrc
export OPENAI_API_KEY="sk-your-api-key-here"

# Reload shell
source ~/.bashrc
```

### ⚙️ Method 2: VS Code Settings

1. Open VS Code Settings (`Ctrl+,` or `Cmd+,`)
2. Search for "openai"
3. Find "Openai: Api Key" setting
4. Enter your API key: `sk-your-api-key-here`

Or edit `settings.json`:
```json
{
  "openai.apiKey": "sk-your-api-key-here"
}
```

### 📁 Method 3: Project Configuration

Create a `.env` file in your project root:
```env
OPENAI_API_KEY=sk-your-api-key-here
```

### 🔐 Getting Your OpenAI API Key

1. **Visit OpenAI Platform:**
   - Go to https://platform.openai.com/api-keys
   - Sign in to your OpenAI account

2. **Create New API Key:**
   - Click "Create new secret key"
   - Give it a name (e.g., "VS Code Extension")
   - Copy the key (starts with `sk-`)

3. **Important Notes:**
   - Keep your API key secure
   - Never commit it to version control
   - The key starts with `sk-`

### 🧪 Testing the Configuration

1. **Restart VS Code** after setting the environment variable
2. **Open Command Palette** (`Ctrl+Shift+P`)
3. **Type "OpenAI"** and look for OpenAI commands
4. **Try using the extension** - it should work now

### 🛠️ Troubleshooting

#### If still not working:

1. **Check Environment Variable:**
   ```powershell
   # PowerShell
   echo $env:OPENAI_API_KEY
   
   # Command Prompt
   echo %OPENAI_API_KEY%
   ```

2. **Restart VS Code completely**

3. **Check VS Code Output:**
   - Go to View → Output
   - Select "OpenAI" from dropdown
   - Look for error messages

4. **Verify API Key Format:**
   - Should start with `sk-`
   - Should be 51+ characters long
   - No spaces or extra characters

#### Alternative: Use Settings Instead

If environment variables don't work:
1. Open VS Code Settings
2. Search "openai"
3. Set "Openai: Api Key" directly in settings
4. Restart VS Code

### 🔒 Security Best Practices

1. **Never commit API keys to Git**
2. **Use environment variables in production**
3. **Rotate API keys regularly**
4. **Monitor API usage in OpenAI dashboard**

### 📞 Support

If you're still having issues:
1. Check the VS Code OpenAI extension documentation
2. Verify your OpenAI account has API access
3. Ensure you have sufficient API credits
4. Try regenerating your API key

Your OpenAI extension should now work properly! 🚀
