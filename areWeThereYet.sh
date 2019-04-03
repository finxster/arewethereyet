#!/bin/sh
{
  echo "Calling website status..."
  ANSWER=`curl -X POST -F 'appReceiptNum=<APPLICATION_ID>' -F 'initCaseSearch=CHECK STATUS' https://egov.uscis.gov/casestatus/mycasestatus.do`
  echo "Done."
} 2> /dev/null

echo "Parsing response..."
{
  if echo "$ANSWER" | grep -E "(Request For Evidence Was Received</h1>)"; then
    STATUS="Status: still the same (Request For Evidence Was Received)";
  elif echo "$ANSWER" | grep -E "(Request for Additional Evidence Was Mailed</h1>)"; then
    STATUS="Status: still the same (Request for Additional Evidence Was Mailed)";
  else
    STATUS="STATUS CHANGED!!!!!!!!!!";
  fi
} 2> /dev/null
echo "Done."

echo $STATUS
