# Check if Python is installed
$pythonCheck = python --version 2>$null
if ($?) {
    Write-Host "Python is already installed. Version: $pythonCheck"
} else {
    Write-Host "Python not found. Downloading and installing..."

    # Define Python version and download URL
    $pythonVersion = "3.12.1"
    $pythonInstaller = "python-installer.exe"
    $downloadUrl = "https://www.python.org/ftp/python/$pythonVersion/python-$pythonVersion-amd64.exe"

    # Download Python installer
    Invoke-WebRequest -Uri $downloadUrl -OutFile $pythonInstaller

    # Install Python for the current user (no admin rights needed)
    Start-Process -FilePath $pythonInstaller -ArgumentList "/quiet InstallAllUsers=0 PrependPath=1" -NoNewWindow -Wait

    # Cleanup installer
    Remove-Item $pythonInstaller -Force

    # Verify installation
    $pythonCheck = python --version 2>$null
    if ($?) {
        Write-Host "Python installed successfully! Version: $pythonCheck"
    } else {
        Write-Host "Installation failed. Please install manually."
        exit 1
    }
}

# Ensure pip is installed and upgraded
Write-Host "Upgrading pip..."
python -m ensurepip --default-pip
python -m pip install --upgrade pip

# Install pynput library
$library = "pynput"
Write-Host "Installing Python library: $library..."
python -m pip install --user $library

# Verify installation
$libCheck = python -c "import $library; print('$library installed successfully!')" 2>$null
if ($?) {
    Write-Host $libCheck
} else {
    Write-Host "Failed to install $library. Try installing it manually."
}

