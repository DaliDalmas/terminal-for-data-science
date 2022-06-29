# data gotten from https://github.com/footballcsv/england
# echo https://raw.githubusercontent.com/footballcsv/england/master/1990s/1996-97/eng.1.csv

base_link=https://raw.githubusercontent.com/footballcsv/england/master/
for decade in {1990,2000,2010,2020}
do
	year=${decade}
	for season in {1..10}
	do
		if [ ${decade} == 1990 ]
		then
			season=$((90+${season}))
			if [ ${year} == 1999 ]
			then
				season=00
			fi
		elif [ ${decade} == 2000 ]
		then
			season=0${season}
			if [ $year == 2009 ]
			then
				season=10
			fi
		elif [ ${decade} == 2010 ]
		then
			season=$((10+${season}))
                elif [ ${decade} == 2020 ]
                then
                        season=$((20+${season}))				
		fi	
		for file in {1..5}
		do
			file_link=${decade}s/${year}-${season}/eng.${file}.csv
			the_link=${base_link}${file_link}
			downloaded_file=${year}_${season}_eng.${file}.csv
			curl -o ${downloaded_file} ${the_link}
			
			head_of_downloaded_file=`head -n 1 ${downloaded_file}`
			if [[ ${head_of_downloaded_file} == "404: Not Found" ]]
			then
				rm ${downloaded_file}
			fi
			
		done
	year=$(($year+1))
	done
done
