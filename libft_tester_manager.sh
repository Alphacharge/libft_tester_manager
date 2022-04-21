#!/bin/bash
#Version 1.0.0 from rbetz from 21.04.2022

#Variable Things
read -p $'\e\033[0;32mInsert the Intra of the Person you are evaluating:\e\033[0m' intra
read -p $'\033[0;32mInsert the link to the git Repo:\033[0m' git

#Constant Things
unit="git@github.com:alelievr/libft-unit-test.git"
libtest="git@github.com:Tripouille/libftTester.git"
war="git@github.com:y3ll0w42/libft-war-machine.git"
split="git@github.com:Ysoroko/FT_SPLIT_TESTER.git"
pain="git@github.com:Bluegales/libft-pain.git"

#Create Workdir
mkdir "tmp_eva_$intra"
cd "tmp_eva_$intra"

echo -e '\033[0;33mCloning Repos.....\033[0m'

git clone "$git" "libft_$intra"
git clone "$unit" "unit"
git clone "$libtest" "libtest"
git clone "$war" "war"
git clone "$split" "split"
git clone "$pain" "pain"

echo -e '\033[0;32mDone.\033[0m'
echo -e '\033[0;33mChecking Norm.....\033[0m'

norminette "libft_$intra"

echo -e '\033[0;32mDone.\033[0m'
read -p $'\033[0;31mPress Enter to continue with Unittest.\033[0m' x

sed -i '' '18d' unit/Makefile
sed -i '' "18i\\
LIBFTDIR=../libft_$intra" unit/Makefile
make -C ./unit/
make f -C ./unit/

echo -e '\033[0;32mDone.\033[0m'
read -p $'\033[0;31mPress Enter to continue with Warmachine.\033[0m' x

./war/grademe.sh
sed -i '' '8d' war/my_config.sh
sed -i '.sh' "8i\\
PATH_LIBFT=../libft_$intra" war/my_config.sh
./war/grademe.sh

echo -e '\033[0;32mDone.\033[0m'
read -p $'\033[0;31mPress Enter to continue with LibftTester.\033[0m' x

sed -i '' '4d' libtest/Makefile
sed -i '' "4i\\
LIBFT_PATH=../libft_$intra\\
" libtest/Makefile
make -C ./libtest/

echo -e '\033[0;32mDone.\033[0m'
read -p $'\033[0;31mPress Enter to continue with pain.\033[0m' x

sed -i '' '2d' pain/pain.sh
sed -i '' '2d' pain/pain.sh
sed -i '' '9d' pain/pain.sh
sed -i '.sh' "2i\\
LIBFT=../libft_$intra\\
" pain/pain.sh
sed -i '.sh' "9i\\
make -C ../libft_$intra/\\
" pain/pain.sh
cd pain
./pain.sh
cd ..

echo -e '\033[0;32mDone.\033[0m'
read -p $'\033[0;31mPress Enter to continue with Splittester.\033[0m' x

sed -i '' '17d' split/Makefile
sed -i '' "17i\\
SRC	=	../libft_$intra/*.c \\\\
" split/Makefile
make -C ./split/

echo -e '\033[0;32mDone.\033[0m'
echo -e '\033[0;32mExit Programm. Good Luck\033[0m'
