#docker build . -t danifran/nanoserver7zip:1709-10.01
# 7 ZIP temporary install image. Used only to decompress the installer
FROM microsoft/windowsservercore as installerhost
ADD http://www.7-zip.org/a/7z1801-x64.exe \7z.exe
RUN powershell Start-Process -Wait -FilePath '\7z.exe' -ArgumentList '/S'


# 7 ZIP target image
FROM microsoft/nanoserver:1709 as targetImage
LABEL Maintainer="Daniele Francioni"
LABEL OsVersion="1709"  7ZipVersion="18.01"

COPY --from=installerhost ["c:/Program files/7-zip", "c:/Program files/7-zip"]
RUN SetX /M PATH "C:\Program Files\7-zip;%PATH%"

CMD powershell
