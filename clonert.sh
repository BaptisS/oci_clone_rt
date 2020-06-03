#!/bin/bash
echo ""
echo "Please provide the SOURCE route table OCID :" 
read srcrt_id
echo ""
echo "Please provide the DESTINATION route table OCID :"
echo "Important : Destination route table  will be overwritten with the content of the source RT" 
read dstrt_id

rm -f src_rt.json


srcrt_data=$(oci network route-table get --rt-id $srcrt_id)
#echo "[" >> src_rt.json
echo $srcrt_data | jq '.[] | ."route-rules"' >> src_rt.json 

oci network route-table update --rt-id $dstrt_id --route-rules file://src_rt.json --force

#rm -f src_rt.json
