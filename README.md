
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
git clone https://github.com/yourusername/your-repo-name.git
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
   .pp.ps1
   ```

2. **Automate the Script**

   Consider setting up a scheduled task to run the script periodically if your IP changes frequently.

## Troubleshooting

- **Error Handling:** If there are issues with the API calls, the script will output detailed error messages to help diagnose the problem.

- **Ensure Internet Connection:** The script needs to access both the public IP service and the Cloudflare API. Ensure you have an active internet connection when running the script.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Contributing

Feel free to submit issues or pull requests if you have suggestions or improvements.

## Contact

For questions or support, please reach out via [GitHub Issues](https://github.com/yourusername/your-repo-name/issues).
