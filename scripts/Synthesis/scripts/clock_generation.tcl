# ALL values are in picosecond

#set PERIOD 10000
set ClkTop $DESIGN
set ClkDomain $DESIGN
set ClkName myCLK
set ClkLatency 500
set ClkRise_uncertainty 500
set ClkFall_uncertainty 500
set ClkSlew 500
set InputDelay 500
set OutputDelay 500

## Set the clock accordingly with the power setting
if {$POWER_MODE == "GPLVT"} {
    echo "High frequency set !"
    set PERIOD 6667
} else {
    set PERIOD 10000
}

## Mind to set the correct clok port name
set PORT_CLK_NAME "clk"

msg "Clock Setting:" lines
msg "Period: ${PERIOD}ps"
msg "Latency: ${ClkLatency}ps"
msg "Uncertinity Rise: ${ClkRise_uncertainty}ps | Fall ${ClkFall_uncertainty}ps"
msg "Clock Slew (Ununsed ?): ${ClkSlew}ps" uline

define_clock -name $ClkName -period $PERIOD -design $ClkTop -domain $ClkDomain [find / -port $PORT_CLK_NAME]

set_attribute clock_network_late_latency $ClkLatency $ClkName
set_attribute clock_source_late_latency  $ClkLatency $ClkName 

set_attribute clock_setup_uncertainty $ClkLatency $ClkName
set_attribute clock_hold_uncertainty $ClkLatency $ClkName 

set_attribute slew_rise $ClkRise_uncertainty $ClkName 
set_attribute slew_fall $ClkFall_uncertainty $ClkName
 
external_delay -input $InputDelay  -clock [find / -clock $ClkName] -name in_con  [find /des* -port ports_in/*]
external_delay -output $OutputDelay -clock [find / -clock $ClkName] -name out_con [find /des* -port ports_out/*]
