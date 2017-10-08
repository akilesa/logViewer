#!/bin/sh

SOURCE_FILE_NAME=~/data/projects/worldnet/ws/tmp/merchant.log
TARGET_FILE_NAME=testlog.html

RLOGTIME='[0-9]\{4\}-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9],[0-9]\{3\}'
RLOGLEVEL='[A-Z][A-Z]*'
RTHREAD='\[.*\]'

RSUBSTRING='<tr><td>\1</td><td>\2</td><td>\3</td><td>\4</td></tr>'
echo "${RSUBSTRING}_"

SEDEXPR="s_^\($RLOGTIME\) *\(${RLOGLEVEL}\)  *\($RTHREAD\) *- *\(.*\)_${RSUBSTRING}_"
echo $SEDEXPR

echo '<html>
<head>
<link rel="stylesheet" type="text/css" href="logviewer.css">
</head>
<body>
<table class = "LogTable">' > $TARGET_FILE_NAME

sed "$SEDEXPR" < $SOURCE_FILE_NAME  >> $TARGET_FILE_NAME

echo '</table>
</body>
</html>' >> $TARGET_FILE_NAME
