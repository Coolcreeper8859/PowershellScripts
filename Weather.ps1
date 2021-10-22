$day = (get-date).DayOfWeek
if ($day -eq "Sunday") {
"   _____                 _             " | Add-Content c:\Temp\Weather.txt
"  / ____|               | |            " | Add-Content c:\Temp\Weather.txt
" | (___  _   _ _ __   __| | __ _ _   _ " | Add-Content c:\Temp\Weather.txt
"  \___ \| | | | '_ \ / _' |/ _' | | | |" | Add-Content c:\Temp\Weather.txt
"  ____) | |_| | | | | (_| | (_| | |_| |" | Add-Content c:\Temp\Weather.txt
" |_____/ \__,_|_| |_|\__,_|\__,_|\__, |" | Add-Content c:\Temp\Weather.txt
"                                  __/ |" | Add-Content c:\Temp\Weather.txt
"                                 |___/ " | Add-Content c:\Temp\Weather.txt
}
if ($day -eq "Monday") {
"  __  __                 _             " | Add-Content c:\Temp\Weather.txt
" |  \/  |               | |            " | Add-Content c:\Temp\Weather.txt
" | \  / | ___  _ __   __| | __ _ _   _ " | Add-Content c:\Temp\Weather.txt
" | |\/| |/ _ \| '_ \ / _' |/ _' | | | |" | Add-Content c:\Temp\Weather.txt
" | |  | | (_) | | | | (_| | (_| | |_| |" | Add-Content c:\Temp\Weather.txt
" |_|  |_|\___/|_| |_|\__,_|\__,_|\__, |" | Add-Content c:\Temp\Weather.txt
"                                  __/ |" | Add-Content c:\Temp\Weather.txt
"                                 |___/ " | Add-Content c:\Temp\Weather.txt
}
if ($day -eq "Tuesday") {
"  _______                  _             " | Add-Content c:\Temp\Weather.txt
" |__   __|                | |            " | Add-Content c:\Temp\Weather.txt
"    | |_   _  ___  ___  __| | __ _ _   _ " | Add-Content c:\Temp\Weather.txt
"    | | | | |/ _ \/ __|/ _' |/ _' | | | |" | Add-Content c:\Temp\Weather.txt
"    | | |_| |  __/\__ \ (_| | (_| | |_| |" | Add-Content c:\Temp\Weather.txt
"    |_|\__,_|\___||___/\__,_|\__,_|\__, |" | Add-Content c:\Temp\Weather.txt
"                                    __/ |" | Add-Content c:\Temp\Weather.txt
"                                   |___/ " | Add-Content c:\Temp\Weather.txt
}
if ($day -eq "Wednesday") {
" __          __      _                          _             " | Add-Content c:\Temp\Weather.txt
" \ \        / /     | |                        | |            " | Add-Content c:\Temp\Weather.txt
"  \ \  /\  / /__  __| | ___ _ __   ___  ___  __| | __ _ _   _ " | Add-Content c:\Temp\Weather.txt
"   \ \/  \/ / _ \/ _' |/ _ \ '_ \ / _ \/ __|/ _' |/ _' | | | |" | Add-Content c:\Temp\Weather.txt
"    \  /\  /  __/ (_| |  __/ | | |  __/\__ \ (_| | (_| | |_| |" | Add-Content c:\Temp\Weather.txt
"     \/  \/ \___|\__,_|\___|_| |_|\___||___/\__,_|\__,_|\__, |" | Add-Content c:\Temp\Weather.txt
"                                                         __/ |" | Add-Content c:\Temp\Weather.txt
"                                                        |___/ " | Add-Content c:\Temp\Weather.txt
}
if ($day -eq "Thursday") {
"  _______ _                        _             " | Add-Content c:\Temp\Weather.txt
" |__   __| |                      | |            " | Add-Content c:\Temp\Weather.txt
"    | |  | |__  _   _ _ __ ___  __| | __ _ _   _ " | Add-Content c:\Temp\Weather.txt
"    | |  | '_ \| | | | '__/ __|/ _' |/ _' | | | |" | Add-Content c:\Temp\Weather.txt
"    | |  | | | | |_| | |  \__ \ (_| | (_| | |_| |" | Add-Content c:\Temp\Weather.txt
"    |_|  |_| |_|\__,_|_|  |___/\__,_|\__,_|\__, |" | Add-Content c:\Temp\Weather.txt
"                                            __/ |" | Add-Content c:\Temp\Weather.txt
"                                           |___/ " | Add-Content c:\Temp\Weather.txt
}
if ($day -eq "Friday") {
"  ______    _     _             " | Add-Content c:\Temp\Weather.txt
" |  ____|  (_)   | |            " | Add-Content c:\Temp\Weather.txt
" | |__ _ __ _  __| | __ _ _   _ " | Add-Content c:\Temp\Weather.txt
" |  __| '__| |/ _' |/ _' | | | |" | Add-Content c:\Temp\Weather.txt
" | |  | |  | | (_| | (_| | |_| |" | Add-Content c:\Temp\Weather.txt
" |_|  |_|  |_|\__,_|\__,_|\__, |" | Add-Content c:\Temp\Weather.txt
"                           __/ |" | Add-Content c:\Temp\Weather.txt
"                          |___/ " | Add-Content c:\Temp\Weather.txt
}
if ($day -eq "Saturday") {
"   _____       _                 _             " | Add-Content c:\Temp\Weather.txt
"  / ____|     | |               | |            " | Add-Content c:\Temp\Weather.txt
" | (___   __ _| |_ _   _ _ __ __| | __ _ _   _ " | Add-Content c:\Temp\Weather.txt
"  \___ \ / _' | __| | | | '__/ _' |/ _' | | | |" | Add-Content c:\Temp\Weather.txt
"  ____) | (_| | |_| |_| | | | (_| | (_| | |_| |" | Add-Content c:\Temp\Weather.txt
" |_____/ \__,_|\__|\__,_|_|  \__,_|\__,_|\__, |" | Add-Content c:\Temp\Weather.txt
"                                          __/ |" | Add-Content c:\Temp\Weather.txt
"                                         |___/ " | Add-Content c:\Temp\Weather.txt
}
(curl http://wttr.in/?n"&"1).Content | ForEach-Object { $_ -replace '\x1b\[[0-9;]*m','' } | ForEach-Object { $_ -replace 'Follow @igor_chubin for wttr.in updates','' } | Add-Content c:\Temp\Weather.txt
Start-Process -FilePath notepad -ArgumentList '/P C:\Temp\Weather.txt'
Start-Sleep 2
Remove-Item C:\Temp\Weather.txt