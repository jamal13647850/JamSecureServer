#!/usr/bin/env bash
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export PATH=$PATH:/usr/local/bin
echoColoredText(){
    
    local color=$1
    local text=$2
    
    # ----------------------------------
    # Colors
    # ----------------------------------
    NOCOLOR='\033[0m'
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    ORANGE='\033[0;33m'
    BLUE='\033[0;34m'
    PURPLE='\033[0;35m'
    CYAN='\033[0;36m'
    LIGHTGRAY='\033[0;37m'
    DARKGRAY='\033[1;30m'
    LIGHTRED='\033[1;31m'
    LIGHTGREEN='\033[1;32m'
    YELLOW='\033[1;33m'
    LIGHTBLUE='\033[1;34m'
    LIGHTPURPLE='\033[1;35m'
    LIGHTCYAN='\033[1;36m'
    WHITE='\033[1;37m'

    echo -e "${!color}${text}${NOCOLOR}"
    
}

printColoredText(){
    
    local color=$1
    local text=$2
    
    # ----------------------------------
    # Colors
    # ----------------------------------
    NOCOLOR='\033[0m'
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    ORANGE='\033[0;33m'
    BLUE='\033[0;34m'
    PURPLE='\033[0;35m'
    CYAN='\033[0;36m'
    LIGHTGRAY='\033[0;37m'
    DARKGRAY='\033[1;30m'
    LIGHTRED='\033[1;31m'
    LIGHTGREEN='\033[1;32m'
    YELLOW='\033[1;33m'
    LIGHTBLUE='\033[1;34m'
    LIGHTPURPLE='\033[1;35m'
    LIGHTCYAN='\033[1;36m'
    WHITE='\033[1;37m'

    
    printf "${!color}${text}${NOCOLOR}"
    
}

error_exit(){
  echoColoredText "RED" "ERROR:"  
  echo "$1" 1>&2
  exit 1
}

showDevider() {
    local count=$1
    j=0
    while [[ $j -lt $count ]]; do   
    printf "-" 
    sleep 0.1 
    ((j++)) 
    done
    echo "-"
}

wellcome(){
  printColoredText "WHITE" "Hi
Welcome to the "
printColoredText "LIGHTCYAN" "JamSecureServer "
printColoredText "WHITE" "program.
This is a program by "
echoColoredText "LIGHTCYAN" "Seyed Jamal Ghasemi."
printColoredText "WHITE" "My email is "
echoColoredText "LIGHTCYAN" "jamal13647850@gmail.com"
echoColoredText "RED" "To use this program, it is necessary to have basic information about working with the server."
printColoredText "WHITE" "This program is created to make things easier and save time."
}

upadteSystem(){
  echoColoredText "GREEN" "Start update system"
  sudo yum update
  echoColoredText "GREEN" "End update system"
}

installNano(){
  echoColoredText "BLUE" "Do you want install nano?y/n"
  read answer

  if [[ $answer = "y" ]]; then
    echoColoredText "GREEN" "Start Install nano"
    sudo yum install nano
    echoColoredText "GREEN" "End Install nano"
  elif [[ $answer = "n" ]]; then
    echoColoredText "GREEN" "ok"
  else
    installNano  
  fi
}

addNewuser(){
  echoColoredText "BLUE" "Do you want add new user and add to the wheel group?y/n"
  read answer

  if [[ $answer = "y" ]]; then
    echoColoredText "GREEN" "Start add new user"
    echoColoredText "BLUE" "Please enter username: "
    read username
    sudo useradd -m $username
    sudo usermod -aG wheel $username
    sudo passwd $username
    echoColoredText "GREEN" "End add new user"
  elif [[ $answer = "n" ]]; then
    echoColoredText "GREEN" "ok"  
  else
    addNewuser  
  fi
}

changeOtherUserPassword(){
  echoColoredText "BLUE" "Do you want change other user password?y/n"
  read answer

  if [[ $answer = "y" ]]; then
    echoColoredText "GREEN" "Start change user password"
    echoColoredText "BLUE" "Please enter username: "
    read username
    sudo passwd $username
    echoColoredText "GREEN" "End change user password"
  elif [[ $answer = "n" ]]; then
    echoColoredText "GREEN" "ok"  
  else
    changeOtherUserPassword  
  fi
}


changeSSHPort(){
  echoColoredText "BLUE" "Do you want change SSH port?y/n"
  read answer

  if [[ $answer = "y" ]]; then
    echoColoredText "GREEN" "Start change SSH port"
   
    showDevider 30
    echoColoredText "ORANGE" "sshd_config Orginal - Start"
    sleep 3
    showDevider 10
    sudo cat /etc/ssh/sshd_config
    echoColoredText "ORANGE" "sshd_config Orginal - END"
    sleep 3
    showDevider 30

    showDevider 30
    echoColoredText "RED" "sshd_config grep port:"
    sudo cat /etc/ssh/sshd_config |grep port
    showDevider 10
    echoColoredText "RED" "sshd_config grep Port:"
    sudo cat /etc/ssh/sshd_config |grep Port
    showDevider 30

    showDevider 30
    echoColoredText "BLUE" "Please enter text for append new port after it: "
    read parentText
    showDevider 10
    sudo cp -fv /etc/ssh/sshd_config /etc/ssh/sshd_config_BACKUP
    sudo cp -fv /etc/ssh/sshd_config /etc/ssh/sshd_config_CHANGED
    showDevider 10
    echoColoredText "BLUE" "Please enter new SSH Port: "
    read newSSHPort
    sudo sed -i "s/^${parentText}.*/${parentText} \r\n Port ${newSSHPort}/" /etc/ssh/sshd_config_CHANGED
    showDevider 10
    echoColoredText "ORANGE" "Orginall sshd_config:"
    showDevider 10
    sleep 3
    sudo cat /etc/ssh/sshd_config
    showDevider 10
    echoColoredText "ORANGE" "Changed sshd_config:"
    showDevider 10
    sleep 3
    sudo cat /etc/ssh/sshd_config_CHANGED

    changeAnswer="";
    while [ "$changeAnswer" != "y" ] && [ "$changeAnswer" != "n" ]; do   
    echoColoredText "BLUE" "You can see the original and modified sshd_config above.
Are you sure you want to replace the original sshd_config with a modified sshd_config?y/n"
    read changeAnswer 
    done

    echo $changeAnswer

    echoColoredText "GREEN" "End change SSH port"
  elif [[ $answer = "n" ]]; then
    echoColoredText "GREEN" "ok"  
  else
    changeSSHPort  
  fi
}







Menu(){
    echoColoredText "BLUE" "
    0  - Exit
    1  - Update System
    2  - Install Nano
    3  - Add New User
    4  - Change Other User Password
    5  - Change SSH Port
    6  - Renew SSl
    7  - backup
    8  - restore
    9  - localbackup
    20 - All"
    echoColoredText "GREEN" "Whats is your Choices?"

    read mode
    
    case $mode in
        
        0)
            exit 0
        ;;
        
        1)
            upadteSystem
        ;;
        
        2)
            installNano
        ;;
        
        3)
            addNewuser
        ;;
        
        4)
            changeOtherUserPassword
        ;;
        
        5)
            changeSSHPort
        ;;
        
        6)
            renewSSL
        ;;
        
        7)
            ./backup.sh
        ;;
        
        8)
            ./restore.sh
        ;;
        
        9)
            ./localbackup.sh
        ;;
        
        10)
            ./setBackupCron.sh
        ;;
        
        20)
            upadteSystem
            showDevider 10
            installNano
            showDevider 10
            addNewuser
            showDevider 10
            changeOtherUserPassword
            showDevider 10
            changeSSHPort
            showDevider 10
        ;;
        
        *)
            Menu
        ;;
    esac
}