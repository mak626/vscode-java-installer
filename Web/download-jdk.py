import requests
import sys
import platform

jcp = 'https://aka.ms/vscode-java-installer-win'


def progress(file_location, file_name, link):
    choice = 1
    while(choice == 1):
        try:
            with open(file_location, "wb") as f:

                print("\nDownloading %s .." % file_name)
                response = requests.get(
                    link, stream=True, timeout=5, allow_redirects=True)
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
                        sys.stdout.write("\r[%s%s]" %
                                         ('=' * done, ' ' * (50-done)))
                        sys.stdout.flush()
            choice = 2
        except:
            print("\nNo Internet Connection / Error Writing File")
            try:
                print("Enter 1 to try again OR 0 to exit")
                choice = int(input("Enter:"))
            except:
                choice = 1
    return choice


if(progress("data/JavaCodingPack.exe", "Java Coding Pack", jcp) == 0):
    exit(0)
