#Pre-Migration Activities and Validation
#!/bin/bash
#---------------------------------------------------
#Script Name        : _Server_Info_2.0.sh
#Author             : Syambabu Pothini
#Creation Date      : 4/06/2016
#Pupose             : To gather basic server info
#Applicable Hosts   : Linux RHEL 6
#Modifications      :
#---------------------------------------------------

_lte_id=`who am i | awk {'print $1'}`
if [[ ("$_lte_id" == 'root') || ("$_lte_id" == "")]]
then
_lte_id=`who | awk '{print $1}' | head -1`
fi

while :
do

cat << EOF

    Is following your ID?? [y/n]
    $_lte_id
EOF

read _res
if [ "$_res" == "y" ]
then
    break
else
    echo "    Enter you ID:"
    read _lte_id
fi
done

cat << EOF

Enter the type of task you would like to perform:

    Pre-migration Validation         [1]
    Post-migration Validation        [2]
EOF
read _choice
clear
cat << EOF

Enter all the server name line by line, then hit 'enter' and 'Ctrl+d' when done

*** Run script seperately for LDAP servers and ADS servers ****

EOF
_serv_names=$(</dev/stdin)
clear
function update_master_file()
{

_file="/mnt/migrate/_Migration_Docs/_Scripts/_Migration_Master"
_mstate=$1
_serv_count=`grep -i $_serv $_file | wc -l`
if [ $_serv_count -eq 0 ]
then
echo "\$$_serv:::::::\$">>$_file
fi
_line=`grep -ni $_serv /mnt/migrate/_Migration_Docs/_Scripts/_Migration_Master | cut -d: -f1`
_appid=`grep -ni $_serv /mnt/migrate/_Migration_Docs/_Scripts/_Migration_Master | cut -d: -f3`
_appname=`grep -ni $_serv /mnt/migrate/_Migration_Docs/_Scripts/_Migration_Master | cut -d: -f4`
_inf=`grep -ni $_serv /mnt/migrate/_Migration_Docs/_Scripts/_Migration_Master | cut -d: -f5`
_preqa=`grep -ni $_serv /mnt/migrate/_Migration_Docs/_Scripts/_Migration_Master | cut -d: -f6`
_postqa=`grep -ni $_serv /mnt/migrate/_Migration_Docs/_Scripts/_Migration_Master | cut -d: -f7`
_mvgrp=`grep -ni $_serv /mnt/migrate/_Migration_Docs/_Scripts/_Migration_Master | cut -d: -f8`
_spinst=`grep -ni $_serv /mnt/migrate/_Migration_Docs/_Scripts/_Migration_Master | cut -d: -f9`

if [ $_mstate -eq 1 ]
then
if [ -f /mnt/migrate/_Migration_Docs/_Server_Validations/Pre_QA_$_serv.html ]
then
if [ "$_preqa" == "" ]
then
_record=$(echo "\$$_serv:$_appid:$_appname:$_inf:Pre_QA_$_serv.html:$_postqa:$_mvgrp:$_spinst")
sed -i "${_line}s/.*/$_record/" $_file
fi
fi
fi

if [ $_mstate -eq 2 ]
then
if [ -f /mnt/migrate/_Migration_Docs/_Server_Validations/Post_QA_$_serv.html ]
then
if [ "$_postqa" == "" ]
then
_record=$(echo "\$$_serv:$_appid:$_appname:$_inf:$_preqa:Post_QA_$_serv.html:$_mvgrp:$_spinst")
sed -i "${_line}s/.*/$_record/" $_file
fi
fi
fi
}
function main()
{

    if [ $_choice -eq 1 ]
    then
     ssh $_lte_id@$_serv1 <<OEOF
pbrun /bin/su - <<IEOF
~$_lte_id/_Scripts/_Migration_Validation_2.0.sh $_lte_id $_choice 1>/dev/null 2>/dev/null; cat ~$_lte_id/Pre_QA_$_serv.html
#su - $_lte_id -c "rm -rf ~$_lte_id/Pre_QA_$_serv.html"
IEOF
OEOF
else
    ssh $_lte_id@$_serv1 <<OEOF
pbrun /bin/su - <<IEOF
~$_lte_id/_Scripts/_Migration_Validation_2.0.sh $_lte_id  $_choice 1>/dev/null 2>/dev/null; cat ~$_lte_id/Post_QA_$_serv.html
#su - $_lte_id -c "rm -rf ~$_lte_id/Post_QA_$_serv.html"
IEOF
OEOF
fi

}
for _serv in $(echo $_serv_names | awk '{print $0}' RS=' ')
do
    _serv1=$_serv
    _serv=$(ssh $_lte_id@$_serv1 "hostname -s")
    _serv=`echo $_serv | sed -E "s/.gso.aexp.com//"`
    _serv=`echo $_serv | sed -E "s/.trcw.us.aexp.com//"`
    _serv=`echo $_serv | sed -E "s/.phx.aexp.com//"`
    cat<< EOF

    Performing Validation on $_serv....

EOF
	clear
    rsync -avzh /mnt/migrate/_Migration_Docs/_Scripts $_lte_id@$_serv1:~$_lte_id/
    echo
echo "Validating server info..."
echo

    if [ $_choice -eq 1 ]
    then
    main > /mnt/migrate/_Migration_Docs/_Server_Validations/Pre_QA_$_serv.html
    update_master_file $_choice
    else
    main > /mnt/migrate/_Migration_Docs/_Server_Validations/Post_QA_$_serv.html
    update_master_file 2
   fi
done

