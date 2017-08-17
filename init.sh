#!/bin/bash
if [ -f "./package_list" ]; then
	tr [a-z] [A-Z] < ./package_list > ./package_list.up
	nothing=$'\n' read -d '' -r -a packages < ./package_list.up
	rm -rf ./package_list.up
fi
for ((index=0;index<${#packages[@]};++index))
#for package in "${packages[@]}"
do 
	echo "$index) ${packages[$index]}"
done


exit

function indicate {
	z="0"
	spin[0]="—"
	spin[1]="\\"
	spin[2]="|"
	spin[3]="/"
	echo -n "${spin[0]}"
	while  kill -0 $pid 2>/dev/null	
	#while [ $z -lt 30 ] 
	do
		for i in "${spin[@]}" 
		do
		       	echo -ne "\b$i"
			sleep 0.1
			z=$[$z+1]
		done
	done
	echo -ne "\b"
}

ERRORMESSAGE=""
echo "Configurating start..."
echo "1) Install VIM..."
sudo apt-get -y install vim > /dev/null & pid=$!
indicate pid
echo "..VIM installed"
echo "2) Configure VIM..."
sudo cp -rf ./.vim ~/ >/dev/null & pid=$!
indicate pid
if [ $? -eq 0 ]
then
	echo "... configure success"
else
	echo "... FAILED ($ERRORMESSAGE)" >&2
fi

