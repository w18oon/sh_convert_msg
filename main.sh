#!/bin/bash

datetime=""
filename='message.run.stat_2023_05_07_20_50_52'
n=1

echo "DATETIME|PID|MSGNAME|TRECV|CRECV|TSEND|CSEND|TSUC|CSUC|TFAIL|CFAIL|PNAME"

while read line; do

chk_delimeter=$(echo $line |grep "-")
if [[ -n "$chk_delimeter" ]]; then
  continue
fi

chk_datetime=$(echo $line |grep ^"|" |awk '{ print $4 " " $5}')
if [[ -n "$chk_datetime" ]]; then
  # echo $chk_datetime
  datetime="${chk_datetime}"
  # echo $datetime
  continue
fi

wc_w=$(echo $line |wc -w)
if [[ $wc_w -eq 0 ]]; then
  continue
fi

chk_desc=$(echo $line |grep "Message")
if [[ -n "$chk_desc" ]]; then
  continue
fi

chk_header=$(echo $line |grep "PID")
if [[ -n "$chk_header" ]]; then
  # header=$(echo $line |awk 'BEGIN { OFS="|"} {$1=$1; print $0}')
  # echo "header=>${header}"
  continue
fi

if [[ -z "$datetime" ]]; then
  continue
fi

msg=$(echo $line |awk 'BEGIN { OFS="|"} {$1=$1; print $0}')

echo "$datetime|$msg"

done < $filename