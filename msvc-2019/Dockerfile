FROM branislav1991/windows-dev:v1

ENV MSVS_VERSION="16" \
    MSVS_URL="https://aka.ms/vs" \
    MSVS_DIST_NAME="vs_community.exe" \
    VSWHERE_URL="https://github.com/Microsoft/vswhere/releases/download" \
    VSWHERE_VERSION="2.8.4" \
    VSWHERE_DIST_NAME="vswhere.exe"

ADD ["scripts", "C:/scripts/"]

RUN powershell -ExecutionPolicy Bypass -File "C:\scripts\install.ps1" && \
    powershell "Remove-Item -Path 'C:\scripts' -Recurse -Force"