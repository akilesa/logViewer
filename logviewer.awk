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
 # FPAT = "(^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9],[0-9][0-9][0-9])|(INFO|DEBUG|ERROR|WARN|TRACE|FATAL)|(\[)"
}

{
    $0 = gensub(/ +/, "\t", "2")
    $0 = gensub(/ +\[/, "\t", "1")
    $0 = gensub(/\] +\[/, "\t", "1")
    $0 = gensub(/\] +- +/, "\t", "1")    
    #print $1
}

$2 ~ /(INFO|DEBUG|ERROR|WARN|TRACE|FATAL)/ {
    print "</td></tr>\n"
    printf ("<tr class='level%s'>", $2)
    print "<td>" $1 "</td><td>" $2 "</td><td>" $3 "</td><td>" $4 "</td><td>" $5
}

$2 !~ /(INFO|DEBUG|ERROR|WARN|TRACE|FATAL)/ {print "<BR>" $0}

END {
    print "</td></tr>\n"	 \
  "</table>\n"   \
  " </body>\n" \
  " </html>"
}
