#!/bin/sh

callSite() {
  {
    echo "Calling website status with application id: $1..."
    ANSWER=`curl -X POST -F 'appReceiptNum='$1 -F 'initCaseSearch=CHECK STATUS' https://egov.uscis.gov/casestatus/mycasestatus.do`
    echo "Done."
  } 2> /dev/null

  echo "Parsing response (expected response: $2)..."
  {
    if echo "$ANSWER" | grep -E "($2</h1>)"; then
      STATUS="Status: still the same ("$2")";
    else
      STATUS="STATUS CHANGED!!!!!!!!!!";
    fi
  } 2> /dev/null
  echo "Done."

  echo $STATUS

}

showHelp() {
  usage="  usage: ./areWeThereYet.sh -a <APPLICATION_ID> -s <EXPECTED_STATUS>

  List of status
        1              Request For Evidence Was Received
        2              Request for Additional Evidence Was Mailed
        3              Case Was Received and A Receipt Notice Was Emailed
        \n
  example: ./areWeThereYet.sh -a WAC1234567890 -s 1
  \n"

  echo "$usage"
}

REQUEST_FOR_EVIDENCE_WAS_RECEIVED="Request For Evidence Was Received"
REQUEST_FOR_ADDITIONAL_EVIDENCE_WAS_MAILED="Request for Additional Evidence Was Mailed"
CASE_WAS_RECEIVED_AND_A_RECEIPT_NOTICE_WAS_EMAILED="Case Was Received and A Receipt Notice Was Emailed"

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
application_id=""
expected_status=""

while getopts "h?s:a:" opt; do
    case "$opt" in
    h|\?)
        showHelp
        exit 0
        ;;
    s)  expected_status=$OPTARG
        ;;
    a)  application_id=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))

[ "${1:-}" = "--" ] && shift

if [ "$application_id" == "" ] ; then
    echo "Missing -a <APPLICATION_ID>!"
    showHelp
    exit 0
fi

if [ "$expected_status" == "" ] ; then
    echo "Missing -s <EXPECTED_STATUS>!"
    showHelp
    exit 0
fi

case $expected_status in
1)
  expected_status=$REQUEST_FOR_EVIDENCE_WAS_RECEIVED
  ;;
2)
  expected_status=$REQUEST_FOR_ADDITIONAL_EVIDENCE_WAS_MAILED
  ;;
3)
  expected_status=$CASE_WAS_RECEIVED_AND_A_RECEIPT_NOTICE_WAS_EMAILED
  ;;
*)
  echo "ERROR! Unexpected status."
  showHelp
  exit 0
esac

echo "status $expected_status appid $application_id"
callSite "$application_id" "$expected_status"
