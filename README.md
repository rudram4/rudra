Installation:
Firstly Configure Go
This tool utilizes three seperate tools:
https://github.com/Cyber-Guy1/Subdomainer
https://github.com/projectdiscovery/httpx
https://github.com/bp0lr/gauplus

Installation of subdomainer:
git clone https://github.com/Cyber-Guy1/Subdomainer
chmod +x install && ./install

Installation of httpx:
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

Installation of Gauplus:
go install github.com/bp0lr/gauplus@latest

Installation of Chandrahasa:
Now After installation of three tools, Git-Clone this to the Subdomainer directory
chmod +x chandrahasa.sh
./chandrahasa.sh websitename.com

USAGE:
./chandrahasa.sh websitename.com




