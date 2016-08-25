function get_osinfo()
{
    #_master=`echo"/var/tmp/$(hostname -s).html"`
    echo "<html><head>" >> $_master
    echo "</head><body>" >> $_master
    echo "<table border=1>" >> $_master
    echo "<tr><td bgcolor=lightblue>Hostname</td><td colspan=2>$(hostname -s)</td></tr>" >> $_master
    echo "<tr><td bgcolor=lightblue>Hostname (FQD)</td><td colspan=2>$(hostname -f)</td></tr>">> $_master
    echo "<tr><td bgcolor=lightblue><strong>Primary IP Address</strong></td><td colspan=2>$(hostname -i)</td></tr>">> $_master
    echo "<tr><td bgcolor=lightblue>Release</td><td colspan=2>$(cat /etc/redhat-release)</td></tr>">> $_master
    echo "<tr><td bgcolor=lightblue>Date</td><td colspan=2>$(date +'%m-%d-%Y')</td></tr>">> $_master
    echo "<tr><td bgcolor=lightblue>Time</td><td colspan=2>$(date | cut -d' ' -f4,5)</td></tr>">> $_master
    _lte_name=`getent passwd $_lte_id | cut -d":" -f5`
    echo "<tr><td bgcolor=lightblue>Linux TE</td><td colspan=2>$_lte_name</td></tr>">> $_master
    echo "<tr><td bgcolor=lightblue>Linux TE ID</td><td colspan=2>$_lte_id</td></tr>">> $_master
    echo "<tr><td bgcolor=lightblue colspan=3>Ethernet Devices:</td></tr>">> $_master
    _eth_num=`ifconfig -a | egrep '^e' | wc -l`
    for i in $(seq 1 $_eth_num);
    do
        _eth_dev=`ifconfig -a | egrep '^e' | awk '{print $1}' |  cut -d":" -f1  | sed -n -e "$i{p}"`
        _ip=`ifconfig $_eth_dev | grep inet | grep -v inet6 | sed -e 's/^\s*//' -e '/^$/d' |cut -d' ' -f2 | sed -e 's/addr://'`
        _nmask=`ifconfig $_eth_dev | grep inet | grep -v inet6 | sed -e 's/^\s*//' -e '/^$/d' |cut -d' ' -f5`
        j=`echo $_nmask | wc -c`
        if [ $j -le 1 ]
        then
            _nmask=`ifconfig eth0 | grep inet | grep -v inet6 | sed -e 's/^\s*//' -e '/^$/d' | awk '{print $4}' | cut -d":" -f2`
        fi
        echo "<tr><td bgcolor=lightblue>$_eth_dev</td><td>IP Address</td><td>$_ip</td></tr>">> $_master
        echo "<tr><td></td><td>Netmask</td><td>$_nmask</td></tr>">> $_master
    done
    _was_ver=`find /opt -name WAS.product | xargs -I _ver cat _ver | grep "<version>" | sed -e "s/<version>//" | sed -e "s#</version>##" | sort -rn | head -1`
    _ln_count=`find /opt -name WAS.product | wc -l`
    if [ $_ln_count -gt 0 ]
    then
        echo "<tr><td bgcolor=yellow><strong>WAS Version:</strong></td><td bgcolor=yellow colspan=2><font color=blue><strong >$_was_ver</strong></font></td></tr>">>$_master
    else
        echo "<tr><td bgcolor=yellow><strong>WAS Version:</strong></td><td bgcolor=yellow colspan=2><font color=blue><strong>Not Installed</strong></font></td></tr>">>$_master
    fi


}


function check_dhcp()
{
    rpm -qa dhclient|grep dhc*
    if [ $? -ne 0  ]
    then
        echo "<tr><td>&nbspcheck DHCP&nbsp&nbsp&nbsp</td><td bgcolor=red>Not installed&nbsp&nbsp</td><td bgcolor=red>Failed&nbsp&nbsp</td></tr>">> $_master
    else
        echo "DHCP is installed."
        echo
        echo "<tr><td>check DHCP</td><td bgcolor=3FD33C >Installed</td><td bgcolor=3FD33C >Passed</td></tr>">> $_master
    fi
}


function check_acpi()
{
    rpm -qa|grep -i acpi*
    if [ $? -eq 0 ]
    then
    echo "acpi binaries are installed..."
    echo
    echo "<tr><td>check acpi</td><td bgcolor="3FD33C ">Installed</td><td bgcolor="3FD33C ">Passed</td></tr>">> $_master
    else
    echo "<tr><td>check acpi</td><td bgcolor="red">Not Installed</td><td bgcolor="red">Failed</td></tr>">> $_master
    fi
    STATUS1=`service acpid status|awk '{print $5}'`
    if [ "$STATUS1" != "running..." ]
    then
        echo "<tr><td>check acpi</td><td bgcolor="red">Not Running</td><td bgcolor="red">Failed</td></tr>">> $_master
    else
        echo "<tr><td>check acpi</td><td bgcolor="3FD33C ">Running</td><td bgcolor="3FD33C ">Passed</td></tr>">> $_master
    fi
    echo "Checking for Run Level 3 for acpid:"
    echo
    OPT=`chkconfig --list acpid|awk '{print $5}'`
    if [ "$OPT" == '3:on' ]
    then
    echo "acpd is running on level 3 "
    echo "<tr><td>check acpi</td><td bgcolor="3FD33C ">3:on</td><td bgcolor="3FD33C ">Passed</td></tr>">> $_master
    echo
    else
    echo "acpd is not running on level 3"
    echo "<tr><td>check acpi</td><td bgcolor="red">3:off</td><td bgcolor="red">Failed</td></tr>">> $_master
    echo
    fi
}

function check_diskspace()
{
    echo "<tr><td colspan=3 bgcolor=lightblue><strong>Disk Space Validation (Avail. space in Mb):</strong></td></tr>" >> $_master
    _num=`df -m | grep dev |grep -vE 'tmpfs|adshome' | wc -l`
    for i in $(seq 1 $_num);
    do
       _size=`df -mP | grep dev |grep -vE 'tmpfs|adshome' | sed -n -e "$i{p}" |awk '{print $4}'`
       _dev=`df -mP | grep dev |grep -vE 'tmpfs|adshome' | sed -n -e "$i{p}" |awk '{print $6}'`
       if [ $_size -le 20 ]
       then
           echo "<tr><td>$_dev</td><td bgcolor=red>$_size</td><td bgcolor=red>Failed</td></tr>">> $_master
       else
           echo "<tr><td>$_dev</td><td bgcolor=3FD33C >$_size</td><td bgcolor=3FD33C >Passed</td></tr>">> $_master
       fi
    done


}

function close_html()
{
    echo "</table></body></html>">>$_master
}



function check_nimsoft()
{
    _proc_num=`ps -ef | grep nimbus | grep -v "grep" | grep controller | wc -l`
    if [ $_proc_num -eq 1 ]
    then
        _proc_num=`ps -ef | grep nimbus | grep -v "grep" | grep spooler | wc -l`
        if [ $_proc_num -eq 1 ]
        then
            _proc_num=`ps -ef | grep nimbus | grep -v "grep" | grep hdb | wc -l`
            if [ $_proc_num -eq 1 ]
            then
                echo "<tr><td>check_nimsoft</td><td bgcolor=3FD33C >Running</td><td bgcolor=3FD33C >Passed</td></tr>">>$_master
            else
                echo "<tr><td>check_nimsoft</td><td bgcolor=red>hdb Process</td><td bgcolor=red>failed</td></tr>">>$_master
            fi
        else
            echo "<tr><td>check_nimsoft</td><td bgcolor=red>spooler Process</td><td bgcolor=red>failed</td></tr>">>$_master
         fi
    else
    echo "<tr><td>check_nimsoft</td><td bgcolor=red>Controller Process</td><td bgcolor=red>failed</td></tr>">>$_master
    fi
}

function check_ibm_agents()
{
    _3FD33C ="3FD33C "
    _red="red"
    if [ $_val -eq 1 ]
    then
        _3FD33C ="3FD33C "
        _red="3FD33C "
    else
        _3FD33C ="3FD33C "
        _red="red"
    fi

    echo "<tr><td colspan=3 bgcolor=lightblue><strong>check IBM Agent Installs</strong></td></tr>">> $_master
    for _ser in  besclient bgssd dsmcad adsmcad
    do
        STATUS1=`service $_ser status|awk '{print $5}'`
        if [ "$STATUS1" != "running..." ]
        then
            echo "<tr><td>check $_ser</td><td bgcolor=$_3FD33C >Not Running</td><td bgcolor=$_3FD33C >Failed</td></tr>">> $_master
        else
            echo "<tr><td>check $_ser</td><td bgcolor=$_red>Running</td><td bgcolor=$_red>Passed</td></tr>">> $_master
        fi

    OPT=`chkconfig --list $_ser|awk '{print $5}'`
    chkconfig --list $_ser
    if [ $? -eq 0 ]
    then
    if [ "$OPT" == '3:on' ]
    then
    echo "<tr><td>check $_ser</td><td bgcolor=$_red>3:on</td><td bgcolor=$_red>Passed</td></tr>">> $_master
    else
    echo "<tr><td>check $_ser</td><td bgcolor=$_3FD33C >3:off</td><td bgcolor=$_3FD33C >Failed</td></tr>">> $_master
    echo
    fi
    else
    echo "<tr><td>check $_ser</td><td bgcolor=$_3FD33C >chkconfig</td><td bgcolor=$_3FD33C >Not Configured</td></tr>">> $_master
     fi
     done
}


function pre_migration_validation()
{
    ls $_master > /dev/null
    if [ $? -eq 0 ]
    then
    su - $_lte_id -c "echo '' > $_master"
    fi
    get_osinfo
    echo "<tr><td colspan=3 bgcolor=yellow><strong>Pre-migration Validation:</strong></td></tr>" >> $_master
    echo "<tr><td>Start Time</td><td colspan=2>$(date +"%T")</td></tr>">>$_master
    check_dhcp
    check_acpi
    check_diskspace
    check_ibm_agents
    echo "<tr><td>Completion Time</td><td colspan=2>$(date +"%T")</td></tr>">>$_master

}


function post_migration_validation()
{
    ls $_master > /dev/null
    if [ $? -eq 0 ]
    then
    su - $_lte_id -c "echo '' > $_master"
    fi
    get_osinfo
    check_diskspace
    echo "<tr><td colspan=3 bgcolor=yellow><strong>Post-Migration Validation:</strong></td></tr>" >> $_master
    echo "<tr><td>Start Time</td><td colspan=2>$(date +"%T")</td></tr>">>$_master
    check_dhcp
    check_acpi
    check_nimsoft
    check_ibm_agents
    echo "<tr><td>Completion Time</td><td colspan=2>$(date +"%T")</td></tr>">>$_master

}


function main()
{

    case $_val in

    1) pre_migration_validation
    ;;
    2) post_migration_validation
    ;;
    esac

}

_mlist=""
_lte_id=$1
_val=$2
_master=""
_lte_hdir=`getent passwd $_lte_id | cut -d':' -f6`
if [ $_val -eq 1 ]
then
_master=`echo "$_lte_hdir/Pre_QA_$(hostname -s).html"`
else
_master=`echo "$_lte_hdir/Post_QA_$(hostname -s).html"`
fi
su - $_lte_id -c "touch $_master"
su - $_lte_id -c "chmod 777 $_master"
main

