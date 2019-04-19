# arewethereyet

When applying for the H1B visa, I was really anxious about my visa status.

It is possible to check it online in https://egov.uscis.gov/, using your application id. So I've created this script to check the status for me, instead going every time into a browser and typing my application id.

# usage
Execute the script sending your application id and the expected status as parameter of the script, like:

```
./areWeThereYet.sh -a <APPLICATION_ID> -s <EXPECTED_STATUS>
```

## Current supported status:
```
1 - Request For Evidence Was Received
2 - Request for Additional Evidence Was Mailed 
```
## Example
```
./areWeThereYet.sh -a WAC1234567890 -s 1
```

Any doubts/suggestions, please fill a PR, Issue or send me and email.

# limitations

For now, the script just checks for two status: `Request For Evidence Was Received` and `Request for Additional Evidence Was Mailed`. Any status besides these, it will return a `Status changed` message. In the future, this should be improved. 
