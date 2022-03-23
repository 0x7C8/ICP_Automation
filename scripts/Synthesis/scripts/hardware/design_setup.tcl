msg "Design setup script started" star

## Flow control {low | medium | high} ps: use high only for bug free design
set SYN_EFF high
set MAP_EFF high
set OPT_EFF high

## Set the default HDL language {v2001 | v1995| vhdl | sv} Default: v2001
set DEF_HDL_LANGUAGE "vhdl"

# put all your design files here
set Design_vhd_Files "TIP_TOP.vhd Controller.vhd MAC.vhd ROM.vhd TOP_Accelerator.vhd Input_matrix.vhd"

#### Set the attributes

## Set the paths to search 
set_attribute script_search_path $PATH_SCRIPT /
## Set the RTL path 
set_attribute init_hdl_search_path $PATH_RTL /

## Set default hdl language as vdhdl
set_attribute hdl_language ${DEF_HDL_LANGUAGE}

## Set the effor to put
set_attribute syn_generic_effort $SYN_EFF /
set_attribute syn_map_effort $MAP_EFF /
set_attribute syn_opt_effort $OPT_EFF /

## Set the log verbose {5:7}
set_attribute information_level 7 /

## LPHVT library paths
if {$POWER_MODE == "LPHVT"} {
  set_attribute init_lib_search_path { \
	/usr/local-eit/cad2/cmpstm/mem2011/SPHD110420-48158@1.0/libs \
  	/usr/local-eit/cad2/cmpstm/stm065v536/IO65LP_TF_BASIC_50A_ST_7M4X0Y2Z_7.2/libs \
	/h/d2/e/al5516gu-s/DIGITAL_ICP_1/IPC_accelerator/LU_PADS_65nm \
	/usr/local-eit/cad2/cmpstm/stm065v536/CORE65LPHVT_5.1/libs \
	/usr/local-eit/cad2/cmpstm/stm065v536/CLOCK65LPHVT_3.1/libs \
  }
## LPSVT libraries paths
} elseif {$POWER_MODE == "LPSVT"} {
  set_attribute init_lib_search_path { \
	/usr/local-eit/cad2/cmpstm/mem2011/SPHD110420-48158@1.0/libs \
	/usr/local-eit/cad2/cmpstm/stm065v536/IO65LP_TF_BASIC_50A_ST_7M4X0Y2Z_7.2/libs \
	/h/d2/e/al5516gu-s/DIGITAL_ICP_1/IPC_accelerator/LU_PADS_65nm \
	/usr/local-eit/cad2/cmpstm/stm065v536/CORE65LPSVT_5.1/libs \
	/usr/local-eit/cad2/cmpstm/stm065v536/CLOCK65LPSVT_3.1/libs \
  }
## GPLVT libraries paths
} elseif {$POWER_MODE == "GPLVT"} {
  set_attribute init_lib_search_path { \
	/usr/local-eit/cad2/cmpstm/mem2011/SPHD110420-48158@1.0/libs \
	/usr/local-eit/cad2/cmpstm/stm065v536/IO65LP_TF_BASIC_50A_ST_7M4X0Y2Z_7.2/libs \
	/h/d2/e/al5516gu-s/DIGITAL_ICP_1/IPC_accelerator/LU_PADS_65nm \
	/usr/local-eit/cad2/cmpstm/stm065v536/CORE65GPLVT_5.1/libs \
	/usr/local-eit/cad2/cmpstm/stm065v536/CLOCK65GPLVT_3.1/libs \
  }
## LPHVT by default
} else {
  set_attribute init_lib_search_path { \
	/usr/local-eit/cad2/cmpstm/mem2011/SPHD110420-48158@1.0/libs \
	/usr/local-eit/cad2/cmpstm/stm065v536/IO65LP_TF_BASIC_50A_ST_7M4X0Y2Z_7.2/libs \
	/h/d2/e/al5516gu-s/DIGITAL_ICP_1/IPC_accelerator/LU_PADS_65nm \
	/usr/local-eit/cad2/cmpstm/stm065v536/CORE65LPHVT_5.1/libs \
	/usr/local-eit/cad2/cmpstm/stm065v536/CLOCK65LPHVT_3.1/libs \
  }
}

msg "Selected power mode is: ${POWER_MODE}" uline
msg "Loading libraries:" lines

## Load the libraries
if {$POWER_MODE == "LPHVT"} {  
  # Low power mode
  echo ${POWER_MODE}
  set_attribute library { \
    CLOCK65LPHVT_nom_1.20V_25C.lib \
    CORE65LPHVT_nom_1.20V_25C.lib \
    IO65LP_TF_BASIC_50A_ST_7M4X0Y2Z_bc_1.25V_105C.lib \
    SPHD110420_nom_1.20V_25C.lib \
    Pads_Oct2012.lib \
  } \
} elseif {$POWER_MODE == "LPSVT"} {
  # High power mode
  echo ${POWER_MODE}
  set_attribute library { \
    CLOCK65LPSVT_nom_1.20V_25C.lib \
    CORE65LPSVT_nom_1.20V_25C.lib \
    IO65LP_TF_BASIC_50A_ST_7M4X0Y2Z_bc_1.25V_105C.lib \
    SPHD110420_nom_1.20V_25C.lib \
    Pads_Oct2012.lib \
  } \
} elseif {$POWER_MODE == "GPLVT"} {
  # High power mode
  echo ${POWER_MODE}
  set_attribute library { \
    CLOCK65GPLVT_nom_1.10V_25C.lib \
    CORE65GPLVT_nom_1.10V_25C.lib \
    IO65LP_TF_BASIC_50A_ST_7M4X0Y2Z_bc_1.10V_105C.lib \
    SPHD110420_wc_1.10V_125C.lib \
    Pads_Oct2012.lib \
  } \
} else {
  # Set the low power by default
  echo ${POWER_MODE}
  set_attribute library { \
    CLOCK65LPHVT_nom_1.20V_25C.lib \
    CORE65LPHVT_nom_1.20V_25C.lib \
    IO65LP_TF_BASIC_50A_ST_7M4X0Y2Z_bc_1.25V_105C.lib \
    SPHD110420_nom_1.20V_25C.lib \
    Pads_Oct2012.lib \
  } \
}

#message "Specify the CAP file"
### Set the CAP file
#set_attribute cap_table_file capfile /
msg "CAP ignored"
