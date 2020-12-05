#!/bin/bash
sudo apt install gfortran
sudo apt install csh
mkdir ~/tmp
cd ~/tmp
wget http://www-gs.llnl.gov/content/assets/docs/energy/EQ36_80a_Linux.zip
unzip EQ36_80a_Linux.zip
cd Linux
mv EQ3_6v8.0a ~/
rm -rf Linux
cd ~/EQ3_6v8.0a
ls *.tar |xargs -I {} tar xvf {}
find -name "*.gz" |xargs -I {} gunzip {}
cd eqlibg/src
gfortran -c *.f
ar cr eqlibg.a *.o
cd ../../eqlibu/src
gfortran -c *.f
ar cr eqlibu.a *.o
cd ../../eqlib/src
gfortran -c *.f
ar cr eqlib.a *.o

cd ../../eqpt/src
sh makelinks
gfortran *.f *.a -o eqpt
cp eqpt ../../bin/
cd ../../xcon3/src
sh makelinks
gfortran *.f *.a -o xcon3
cp xcon3 ../../bin/
cd ../../xcon6/src
sh makelinks
gfortran *.f *.a -o xcon6
cp xcon6 ../../bin/
cd ../../eq3nr/src
sh makelinks
gfortran *.f *.a -o eq3nr
cp eq3nr ../../bin/
cd ../../eq6/src
sh makelinks
gfortran *.f *.a -o eq6
gfortran *.f *.a -o eq6
cp eq6 ../../bin/

cd ~/EQ3_6v8.0a

cat eq36cfg >> ~/.cshrc

cd scripts/
ln -s runeq36 runeq3
ln -s runeq36 runeq6

sudo mkdir /usr/tmp
sudo chmod ugo+rw /usr/tmp

cd ../db/
csh ../scripts/runeqpt all



