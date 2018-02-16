#!/bin/sh
{
  echo "Calling website status..."
  ANSWER=`curl -X POST -F 'appReceiptNum=<APPLICATION_ID>' -F 'initCaseSearch=CHECK STATUS' https://egov.uscis.gov/casestatus/mycasestatus.do`
  echo "Done."
} 2> /dev/null

echo "Parsing response..."
{
  if echo "$ANSWER" | grep -E "(Request For Evidence Was Received</h1>)"; then
    STATUS="Status: still the same";
  else
    STATUS="STATUS CHANGED!!!!!!!!!!";
  fi
} 2> /dev/null
echo "Done."

echo $STATUS
