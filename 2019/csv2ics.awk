#!/usr/bin/sh
awk -F"," -f - "$@" << 'EOF'
#!/usr/bin/awk -f
BEGIN{ print "BEGIN:VCALENDAR\n\
PRODID:EJC2019SCHEDULESCRIPT\n\
VERSION:2.0\n\
X-WR-CALNAME:EJC2019SCHEDULE\n\
CALSCALE:GREGORIAN\n\
BEGIN:VTIMEZONE\n\
TZID:Europe/London\n\
X-LIC-LOCATION:Europe/London\n\
BEGIN:DAYLIGHT\n\
TZOFFSETFROM:+0000\n\
TZOFFSETTO:+0100\n\
TZNAME:BST\n\
DTSTART:19700329T010000\n\
RRULE:FREQ=YEARLY;BYMONTH=3;BYDAY=-1SU\n\
END:DAYLIGHT\n\
BEGIN:STANDARD\n\
TZOFFSETFROM:+0100\n\
TZOFFSETTO:+0000\n\
TZNAME:GMT\n\
DTSTART:19701025T020000\n\
RRULE:FREQ=YEARLY;BYMONTH=10;BYDAY=-1SU\n\
END:STANDARD\n\
END:VTIMEZONE";
}
{
printf "BEGIN:VEVENT\n\
DTSTAMP:%sZ\n\
UID:%sZ-EJC2019-%03d\n\
DTSTART;TZID=Europe/London:%s\n\
DTEND;TZID=Europe/London:%s\n\
SUMMARY:%s\n",strftime("%Y%d%mT%H%M%S",systime()),strftime("%Y%d%mT%H%M%S",systime()),NR,strftime("%Y%d%mT%H%M%S",mktime($1)),strftime("%Y%d%mT%H%M%S",mktime($1)+60*60),$2;
if($4!="") printf "URL:%s\n", $4;
printf "DESCRIPTION:%s\n",$2;
if($3!="") printf "LOCATION:%s\n",$3;
if($5!="") printf "GEO:%f;%f\n",$5,$6;
print "END:VEVENT";
}
END{
print "END:VCALENDAR";
}
EOF
