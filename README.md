
# Cloudflare Dynamic IP Whitelist Script

This PowerShell script dynamically updates the Cloudflare firewall to whitelist your current public IP address. It ensures that only the latest IP is whitelisted by removing any previous IPs from the whitelist, helping maintain a secure environment while using dynamic IP addresses.

## Features

- **Automatic IP Detection:** The script retrieves your current public IP address.
- **Cloudflare Integration:** Automatically updates your Cloudflare account to whitelist the detected IP address.
- **IP Change Detection:** Compares the current IP with the last logged IP and updates the whitelist only if there's a change.
- **Automatic Removal of Old IP:** If the IP has changed, the script removes the previous IP from the whitelist before adding the new one.
- **Error Handling:** Includes error handling to manage issues with Cloudflare API calls.

## Prerequisites

- **Cloudflare Account:** You need an active Cloudflare account with API access enabled.
- **PowerShell:** The script is designed to run on PowerShell.

## Setup

### 1. Clone the Repository

```bash
https://github.com/quetzalism/Cloudflare-Dynamic-IP-Whitelist-Script-For-Powershell
```

### 2. Create a `creds.json` File

In the same directory as the script, create a `creds.json` file with the following structure:

```json
{
    "zoneID": "your_zone_id",
    "email": "your_email",
    "apiKey": "your_api_key"
}
```

- **zoneID:** Your Cloudflare Zone ID.
- **email:** Your Cloudflare account email.
- **apiKey:** Your Cloudflare API key.

### 3. (Optional) `last_ip.json`

The script automatically creates a `last_ip.json` file in the same directory to track the last whitelisted IP. You do not need to create this file manually; it will be generated on the first run.

## Usage

1. **Run the Script**

   Execute the PowerShell script to check your current IP and update the Cloudflare whitelist accordingly:

   ```powershell
   ./app.ps1
   ```

2. **Automate the Script**

   Consider setting up a scheduled task to run the script periodically if your IP changes frequently.

## Setting Up a Scheduled Task for the Script

To automate the execution of your PowerShell script, you can set up a scheduled task in Windows. Follow these steps:

### 1. Open Task Scheduler
- Press `Win + S` and type "Task Scheduler".
- Click on **Task Scheduler** to open it.

### 2. Create a New Task
- In the Task Scheduler window, click on **Create Task** in the right-hand Actions pane.

### 3. General Settings
- **Name**: Give your task a name (e.g., "Cloudflare IP Whitelist Update").
- **Description**: Optionally, provide a description.
- **Security options**: Choose "Run whether user is logged on or not" and check "Run with highest privileges".

### 4. Triggers
- Go to the **Triggers** tab.
- Click **New** to create a new trigger.
- Set the **Begin the task** dropdown to "On a schedule".
- Set up the frequency and timing based on your needs (e.g., daily, weekly).
- Click **OK** when done.

### 5. Actions
- Go to the **Actions** tab.
- Click **New** to create a new action.
- Set **Action** to "Start a program".
- In the **Program/script** field, enter `powershell.exe`.
- In the **Add arguments (optional)** field, enter the following:

  ```plaintext
  -ExecutionPolicy Bypass -File "C:\path\to\your\script\app.ps1"
  ```

  Replace `C:\path\to\your\script\app.ps1` with the actual path to your script.

- Click **OK** when done.

### 6. Conditions (Optional)
- Go to the **Conditions** tab.
- Adjust conditions based on your preferences, such as only running when the computer is idle or connected to AC power.

### 7. Settings
- Go to the **Settings** tab.
- Ensure "Allow task to be run on demand" is checked.
- You can also set options like "If the task fails, restart every" and "Stop the task if it runs longer than".

### 8. Save the Task
- Click **OK** to save the task.
- If prompted, enter your password to allow the task to run with the required permissions.

### 9. Test the Task
- In the Task Scheduler, right-click the task you created and select **Run** to test it.

This setup will ensure that your PowerShell script runs at the scheduled intervals, automatically updating the Cloudflare whitelist with your current IP.

## Troubleshooting

- **Error Handling:** If there are issues with the API calls, the script will output detailed error messages to help diagnose the problem.

- **Ensure Internet Connection:** The script needs to access both the public IP service and the Cloudflare API. Ensure you have an active internet connection when running the script.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Contributing

Feel free to submit issues or pull requests if you have suggestions or improvements.

## Tips
https://paypal.me/Evpj
