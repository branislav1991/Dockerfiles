FROM mcr.microsoft.com/dotnet/framework/runtime:3.5

ENV DOWNLOAD_DIR="C:\download" \
    SEVEN_ZIP_VERSION="19.00" \
    SEVEN_ZIP_DOWNLOAD_URL="http://www.7-zip.org/a" \
    SEVEN_ZIP_HOME="C:\Program Files\7-Zip" \
    GIT_VERSION="2.30.0"

ADD ["scripts", "C:/scripts/"]

RUN mkdir "%DOWNLOAD_DIR%" && \
    powershell -ExecutionPolicy Bypass -File "C:\scripts\install.ps1"

RUN choco install anaconda3 -y --params '"/AddToPath"'

RUN powershell "Remove-Item -Path 'C:\scripts' -Recurse -Force"