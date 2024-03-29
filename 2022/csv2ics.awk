#!/usr/bin/sh
awk -F"," -f - "$@" << 'EOF'
#!/usr/bin/awk -f
BEGIN{ print "BEGIN:VCALENDAR\n\
PRODID:EJC2022SCHEDULESCRIPT\n\
VERSION:2.0\n\
X-WR-CALNAME:EJC2022SCHEDULE\n\
CALSCALE:GREGORIAN\n\
BEGIN:VTIMEZONE\n\
TZID:Europe/Berlin\n\
X-LIC-LOCATION:Europe/Berlin\n\
BEGIN:DAYLIGHT\n\
TZOFFSETFROM:+0100\n\
TZOFFSETTO:+0200\n\
TZNAME:CEST\n\
DTSTART:19700329T010000\n\
RRULE:FREQ=YEARLY;BYMONTH=3;BYDAY=-1SU\n\
END:DAYLIGHT\n\
BEGIN:STANDARD\n\
TZOFFSETFROM:+0200\n\
TZOFFSETTO:+0100\n\
TZNAME:CET\n\
DTSTART:19701025T020000\n\
RRULE:FREQ=YEARLY;BYMONTH=10;BYDAY=-1SU\n\
END:STANDARD\n\
END:VTIMEZONE";
}
{
printf "BEGIN:VEVENT\n\
DTSTAMP:%sZ\n\
UID:%sZ-EJC2022-%03d\n\
DTSTART;TZID=Europe/Berlin:%s\n\
DTEND;TZID=Europe/Berlin:%s\n\
SUMMARY:%s\n",strftime("%Y%m%dT%H%M%S",systime()),strftime("%Y%m%dT%H%M%S",systime()),NR,strftime("%Y%m%dT%H%M%S",mktime($1)),strftime("%Y%m%dT%H%M%S",mktime($1)),$2;
if($4!=""){ printf "URL:%s\n\
DESCRIPTION:%s\\n%s\n", $4,$3,$4;
}else{
printf "DESCRIPTION:%s\n",$3;
}
if($5!="") printf "LOCATION:%f, %f\n",$5,$6;
if($5!="") printf "GEO:%f;%f\n",$5,$6;
print "END:VEVENT";
}
END{
print "END:VCALENDAR";
}
EOF
