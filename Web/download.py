import requests
import sys
import platform

# LINKS TO FILES
vs = "https://aka.ms/win32-x64-user-stable"
vs32 = "https://aka.ms/win32-user-stable"
jcp = "https://aka.ms/vscode-java-installer-win"
jdk = "https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.9%2B11/OpenJDK11U-jdk_x64_windows_hotspot_11.0.9_11.msi"
jdk32 = "https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.8%2B10/OpenJDK11U-jdk_x86-32_windows_hotspot_11.0.8_10.msi"


def downloader(file_location, file_name, link):
    '''
    Returns value 0 if failed to download files
    '''
    status = 1
    while(status == 1):
        try:
            with open(file_location, "wb") as f:
                print("\nDownloading %s .." % file_name)
                response = requests.get(link, stream=True, timeout=5, allow_redirects=True)
                total_length = response.headers.get('content-length')
                if total_length is None:
                    f.write(response.content)
                else:
                    dl = 0
                    total_length = int(total_length)
                    for data in response.iter_content(chunk_size=4096):
                        dl += len(data)
                        f.write(data)
                        done = int(50 * dl / total_length)
                        sys.stdout.write("\r[%s%s]" % ('=' * done, ' ' * (50-done)))
                        sys.stdout.flush()
            status = 2
        except:
            print("\nNo Internet Connection / Error Writing File")
            try:
                print("Enter 1 to try again OR 0 to exit")
                status = int(input("Enter:"))
            except:
                status = 1
    return status


if platform.architecture()[0] == '64bit':
    if sys.argv[1] == 'vs':
        if(downloader("data/VS.exe", "VS Code", vs) == 0):
            exit(1)
    else:
        if(downloader("data/JDK.msi", "Adobe Open JDK", jdk) == 0):
            exit(1)
else:
    if sys.argv[1] == 'vs':
        if(downloader("data/VS.exe", "VS Code", vs32) == 0):
            exit(1)
    else:
        if(downloader("data/JDK.msi", "Adobe Open JDK", jdk32) == 0):
            exit(1)

if(downloader("data/JavaCodingPack.exe", "Java Coding Pack", jcp) == 0):
    exit(1)

# If successful
exit(0)
