# Update system
sudo apt update -y
sudo apt upgrade -y

# Install dependencies
sudo apt install -y wget tar openjdk-17-jdk

# Create /app directory
sudo mkdir -p /app && cd /app

# Download Nexus
sudo wget https://download.sonatype.com/nexus/3/nexus-3.79.1-04-linux-x86_64.tar.gz

# Extract and rename
sudo tar -xvf nexus-3.79.1-04-linux-x86_64.tar.gz
sudo mv nexus-3.79.1-04 nexus

# Create nexus user
sudo adduser --disabled-password --gecos "" nexus

# Change ownership
sudo chown -R nexus:nexus /app/nexus
sudo chown -R nexus:nexus /app/sonatype*

# Ensure nexus runs as nexus user
sudo sed -i 's/^#run_as_user=""/run_as_user="nexus"/' /app/nexus/bin/nexus

# Create systemd service
sudo tee /etc/systemd/system/nexus.service > /dev/null << EOL
[Unit]
Description=Nexus Repository Manager
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus
ExecStart=/app/nexus/bin/nexus start
ExecStop=/app/nexus/bin/nexus stop
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd and enable service
sudo systemctl daemon-reload
sudo systemctl enable nexus
sudo systemctl start nexus
sudo systemctl status nexus
