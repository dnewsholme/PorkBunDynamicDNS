FROM mcr.microsoft.com/powershell:preview
# Create app directory
WORKDIR /PorkBunDNS
# Install app dependencies
COPY src ./
# Run Command
CMD [ "pwsh","./UpdatePorkBunDNS.ps1" ]