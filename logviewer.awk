#!/usr/bin/awk -f
BEGIN {
print "<html>\n" \
  " <head>\n" \
  " <link rel='stylesheet' type='text/css' href='logviewer.css'>\n" \
  " </head>\n" \
  " <body>\n" \
  " <table class = 'LogTable'>\n" \
  " <tr><td colspan='5'>"
 FS = "\t"
 curThreadNum = 0
}

{
    $0 = gensub(/ +/, "\t", "2")
    $0 = gensub(/ +\[/, "\t", "1")
    $0 = gensub(/\] +\[/, "\t", "1")
    $0 = gensub(/\] +- +/, "\t", "1")    
}

$2 ~ /(INFO|DEBUG|ERROR|WARN|TRACE|FATAL)/ {
    if ($3 in threadArray) {
	#threadArray[$3] = ++ curThreadNum
    } else {
	threadArray[$3] = ++ curThreadNum
    }
    print "</td></tr>\n"
    printf ("<tr class='level%s thread%s'>", $2, threadArray[$3])
    print "<td>" $1 "</td><td>" $2 "</td><td>" $3 "</td><td>" $4 "</td><td>" $5
}

$2 !~ /(INFO|DEBUG|ERROR|WARN|TRACE|FATAL)/ {print "<BR>" $0}

END {
    print "</td></tr>\n"	 \
  "</table>\n"   \
  " </body>\n" \
  " </html>"
}
