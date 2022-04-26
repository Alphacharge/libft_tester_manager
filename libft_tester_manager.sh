#!/bin/bash
#Version 1.0.1 from rbetz from 21.04.2022
#Added SSH Suppression and changed links from ssh to https#
#Added the opportunity to check a specific tester and without new install

#Variable Things
read -p $'\e\033[0;32mDo you want to install it? (y | n):\e\033[0m' install
if [[ $install == "y" ]]
then
	read -p $'\e\033[0;32mInsert the Intra of the Person you are evaluating:\e\033[0m' intra
	read -p $'\033[0;32mInsert the link to the git Repo:\033[0m' git
	tester="all"
else
	read -p $'\033[0;32mDo you want a specific test?(empty/all | unit | war | lib | pain | split | norm):\033[0m' tester
fi

#Constant Things
unit="https://github.com/alelievr/libft-unit-test.git"
libtest="https://github.com/Tripouille/libftTester.git"
war="https://github.com/y3ll0w42/libft-war-machine.git"
split="https://github.com/Ysoroko/FT_SPLIT_TESTER.git"
pain="https://github.com/Bluegales/libft-pain.git"

if [[ $install == "y" ]]
then
	#Suppress Fingerprint Messages
	ssh-keygen -F github.com || ssh-keyscan github.com >> ~/.ssh/known_hosts

	#Create Workdir
	mkdir "tmp_eva_$intra"
	touch "tmp_eva_lastid"
	echo "$intra" > tmp_eva_lastid
	cd "tmp_eva_$intra"

	echo -e '\033[0;33mCloning Repos.....\033[0m'

	git clone "$git" "libft_$intra"
	git clone "$unit" "unit"
	git clone "$libtest" "libtest"
	git clone "$war" "war"
	git clone "$split" "split"
	git clone "$pain" "pain"

	echo -e '\033[0;32mDone.\033[0m'
else
#	intra="$(find . -type d -name 'tmp_eva*' | head -n 1 | cut -d_ -f3)"
	intra="$(head -n1 tmp_eva_lastid)"
	if [[ -d "tmp_eva_$intra" ]]
	then
		cd "tmp_eva_$intra"
	else
		echo "Directory not found!"
		exit 1
	fi
fi

if [[ $install == "y" || $tester == "norm" ]]
then
	echo -e '\033[0;33mChecking Norm.....\033[0m'
	norminette "libft_$intra"
	echo -e '\033[0;32mDone.\033[0m'
fi

if [[ $tester == "unit" || $tester == "all" || $tester == "" ]]
then
	if [[ $install == "y" ]]
	then
		read -p $'\033[0;31mPress Enter to continue with Unittest.\033[0m' x
		sed -i '' '18d' unit/Makefile
		sed -i '' "18i\\
\	\	LIBFTDIR=../libft_$intra" unit/Makefile
	fi
	make -C ./unit/
	make f -C ./unit/
	echo -e '\033[0;32mDone.\033[0m'
fi
if [[ $tester == "war" || $tester == "all" || $tester == "" ]]
then
	if [[ $install == "y" ]]
	then
		read -p $'\033[0;31mPress Enter to continue with Warmachine.\033[0m' x
		./war/grademe.sh
		sed -i '' '8d' war/my_config.sh
		sed -i '.sh' "8i\\
\	\	PATH_LIBFT=../libft_$intra" war/my_config.sh
	fi
	./war/grademe.sh
	echo -e '\033[0;32mDone.\033[0m'
fi
if [[ $tester == "lib" || $tester == "all" || $tester == "" ]]
then
	if [[ $install == "y" ]]
	then
		read -p $'\033[0;31mPress Enter to continue with LibftTester.\033[0m' x
		sed -i '' '4d' libtest/Makefile
		sed -i '' "4i\\
\	\	LIBFT_PATH=../libft_$intra\\
\	\	" libtest/Makefile
	fi
	make -C ./libtest/
	echo -e '\033[0;32mDone.\033[0m'
fi
if [[ $tester == "pain" || $tester == "all" || $tester == "" ]]
then
	if [[ $install == "y" ]]
	then
		read -p $'\033[0;31mPress Enter to continue with pain.\033[0m' x
		sed -i '' '2d' pain/pain.sh
		sed -i '' '2d' pain/pain.sh
		sed -i '' '9d' pain/pain.sh
		sed -i '.sh' "2i\\
\	\	LIBFT=../libft_$intra\\
\	\	" pain/pain.sh
		sed -i '.sh' "9i\\
\	\	make -C ../libft_$intra/\\
\	\	" pain/pain.sh
	fi
	cd pain
	./pain.sh
	cd ..
	echo -e '\033[0;32mDone.\033[0m'
fi
if [[ $tester == "split" || $tester == "all" || $tester == "" ]]
then
	if [[ $install == "y" ]]
	then
		read -p $'\033[0;31mPress Enter to continue with Splittester.\033[0m' x
		sed -i '' '17d' split/Makefile
sed -i '' "17i\\
SRC	=	../libft_$intra/*.c \\\\
" split/Makefile
	fi
	make -C ./split/
	echo -e '\033[0;32mDone.\033[0m'
fi
echo -e '\033[0;32mExit Programm. Good Luck\033[0m'
