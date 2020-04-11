# Update and Upgrade
sudo apt-get update
sudo apt-get upgrade
# GIT
echo "-----------------------------------------"
echo "Do you want to set up GIT ?"
select yn in "Yes" "No"; do
  case $yn in
    Yes )
      sudo apt install git -y
      git config --global color.ui true
      # Give permission to access external drive
      git config --add --global core.filemode false
      # Remember credential after first pull or push
      git config --global credential.helper store
      # Add name and email to global
      while true; do
        echo "-----------------------------------------"
        read -p "Enter your global user.name (git): " git_username
        read -p "Enter your global user.email: " git_email
        echo "Github username will be: $git_username"
        echo "Github email will bee: $git_email"
        read -p "Are you sure? " yn
        case $yn in
          [Yy]* )
            git config --global user.name "$git_username"
            git config --global user.email "$git_email"
            echo "user: $git_username - email: $git_email"
            break;;
          [Nn]* )
            echo "Enter again, please"
            ;;
          * )
            echo "Please answer yes or no."
            ;;
        esac
      done

      # Generate Key and authorized_keys file
      mkdir ~/.ssh -p
      ssh-keygen -t rsa -b 4096 -C "$git_email" -P '' -f ~/.ssh/id_rsa
      cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
      chmod 0600 ~/.ssh/authorized_keys
      echo "-----------------------------------------"
      echo "You must copy public key below and add to github"
      cat ~/.ssh/id_rsa.pub
      # Check connection to Github
      echo "-----------------------------------------"
      echo "Do you wanna check connection?"
      select yn in "Yes" "No"; do
        case $yn in
          Yes )
            ssh -T git@github.com -o PreferredAuthentications=publickey -i ~/.ssh/id_rsa;
            break;;
          No )
            echo "If something happened, u must add key manully later.";
            break;;
        esac
      done
      break
      ;;
    No  )
      break
      ;;
  esac
done

##########################

###############################################################
# NEOVIM
echo "-----------------------------------------"
echo "Do you want to set up NEOVIM ?"
select yn in "Yes" "No"; do
  case $yn in
    Yes )
      # Install neovim
      sudo apt install neovim -y
      # Install python
      sudo apt install python python3 -y
      # Install pip
      sudo python3 -m pip install pip --upgrade --force
      sudo python -m pip install pip --upgrade --force
      # Install c/c++ stuff
      sudo apt install g++ gcc make cmake -y
      # Other stuff
      sudo apt install build-essential python3-dev -y

      # Plugin
      # 1st, create ~/.config/nvim/init.vim
      mkdir ~/.config/nvim -p
      touch ~/.config/nvim/init.vim
      # 2nd, install Vim-Plug
      curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      # 3rd, get public config file from github.com/msaio
      curl -fLo ~/.config/nvim/init.vim https://raw.githubusercontent.com/msaio/SetupEnvWSL/master/init.vim
      # 4th, install plugin
      nvim +PlugInstall +qall
      python3 ~/.config/nvim/plugged/YouCompleteMe/install.py --all
      break
      ;;
    No  )
      break
      ;;
  esac
done
##########################

###############################################################
# BASH_IT or OH_MY_ZSH
echo "-----------------------------------------"
echo "Do you want to set up SHELL?"
select yn in "Yes" "No"; do
  case $yn in
    Yes )
      # Select (Can be install alongside in next setup)
      echo "BASH-IT or OH_MY_ZSH ?"
      select choice in "BASH-IT" "OhMyZSH"; do
        case $choice in
          BASH-IT )
            shell="bash_it"
            break
            ;;
          OhMyZSH )
  	  		  shell="oh_my_zsh"
			      break
			      ;;
	      esac
      done
      echo "-----------------------------------------"
      echo "Ok, let's install $shell"
      case $shell in
        bash_it )
          # 1st, download bash_it
          git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
          # 2nd, install bash_it
          ~/.bash_it/install.sh -s
          # 3rd, get public config file from github.com/msaio
          curl -fLo ~/.bashrc https://raw.githubusercontent.com/msaio/SetupEnvWSL/master/.bashrc;
          # 4th, bash_it as default
          sudo chsh -s /bin/bash
          ;;
        oh_my_zsh )
          # 1st, install zsh
          sudo apt install zsh -y
          # 2nd, Download oh_my_zsh
          git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
          # 3rd, Install
          cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
          # 4th, BulletTrain theme
          curl -Lo $ZSH_CUSTOM/themes/bullet-train.zsh-theme https://raw.githubusercontent.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme
		      sed -i "s/ZSH_THEME.*/ZSH_THEME\=\"bullet-train\"/g" ~/.zshrc
		      # 5th, zsh as default
		      sudo chsh -s /bin/zsh
          ;;
      esac
      break
      ;;
    No  )
      break
      ;;
  esac
done
##########################

###############################################################
echo "-----------------------------------------"
# GUI FOR WSL
echo "Do you want to set up GUI?"
select yn in "Yes" "No"; do
  case $yn in
    Yes )
      echo "Are you using WSL1 or WSL2 ?"
      select edition in "WSL1" "WSL2"; do
        case $edition in
          WSL1  )
            if [ $shell == "oh_my_zsh" ]
            then
              echo "export DISPLAY=:0" >> ~/.zshrc
            elif [ $shell == "bash_it" ]
            then
              echo "export DISPLAY=:0" >> ~/.bashrc
            fi
            break
            ;;
          WSL2  )
            # Get the real IP from physics PC
						# Choose the ip is the same with the real ip
            ip1=$(ipconfig.exe | grep IPv4 | cut -d: -f2 | cut -d' ' -f2 | head -1)
						ip2=$(ipconfig.exe | grep IPv4 | cut -d: -f2 | cut -d' ' -f2 | tail -1)
						select rip in $ip1 $ip2; do
							case rip in
								$ip1	)
									theip=$ip1
									break
									;;
								$ip2	)
									theip=$ip2
									break
									;;
							esac
						done

            if [ $shell == "oh_my_zsh" ]
            then
              echo "#export DISPLAY=$theip:0" >> ~/.zshrc
            elif [ $shell == "bash_it" ]
            then
              echo "#export DISPLAY=$theip:0" >> ~/.bashrc
            fi
            break
            ;;
        esac
      done
			echo "------------"
			echo "Because of lagging, slow resposive, i comment the line, so you need to uncomment to get it work"
			echo "One more thing: "
      echo "You must install x-server"
      echo "I highly recommend using X410 from Microsoft store if you have plenty money"
      echo "If not, Xming/Xserver is your best choice"
      echo "Highly recommend this:"
			echo "------------"
      echo "https://sourceforge.net/projects/xming/"
			echo "------------"
      break
      ;;
    No  )
      break
      ;;
  esac
done
##########################

###############################################################
# OH MY TMUX
echo "-----------------------------------------"
echo "Do you want to set up TMUX?"
select yn in "Yes" "No"; do
  case $yn in
    Yes )
      # 1st, Get dependencies
      sudo apt install awk perl sed tmux -y
      # 2nd, Download
      cd
      git clone https://github.com/gpakosz/.tmux.git
      # 3rd, Set up
      ln -s -f .tmux/.tmux.conf
      cp .tmux/.tmux.conf.local .
      # 4th, Get public settings
      curl -fLo ~/.tmux.conf.local https://raw.githubusercontent.com/msaio/SetupEnvWSL/master/.tmux.conf.local
      break
      ;;
    No  )
      break
      ;;
  esac
done
##########################
echo "-----------------------------------------"
echo "OK, thank you for using this installation."
echo "Reopen terminal to take fully effect."
echo "-----------------------------------------"
echo "------------------END--------------------"
