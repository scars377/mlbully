@echo off
set user=scars
set pass=scars0407D
set host=220.128.166.83
set local=dist_remote
set remote=/bizdev.medialand.com.tw/scars/got

set protocol=ftp
set key=ssh-rsa 2048 79:4a:85:24:db:85:69:01:72:91:b5:81:35:71:6c:86

if %protocol%==sftp (set key= -hostkey=""%key%"") else (set key=)
start "" "C:\Program Files (x86)\WinSCP\WinSCP.exe" /console /command^
 "open %protocol%://%user%:%pass%@%host%/%key%"^
 "synchronize remote %local% %remote%"^
 "close"^
 "exit"
