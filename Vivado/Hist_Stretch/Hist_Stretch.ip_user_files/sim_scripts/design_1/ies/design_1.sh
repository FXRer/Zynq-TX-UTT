#!/bin/bash -f
# Vivado (TM) v2016.1 (64-bit)
#
# Filename    : design_1.sh
# Simulator   : Cadence Incisive Enterprise Simulator
# Description : Simulation script for compiling, elaborating and verifying the project source files.
#               The script will automatically create the design libraries sub-directories in the run
#               directory, add the library logical mappings in the simulator setup file, create default
#               'do/prj' file, execute compilation, elaboration and simulation steps.
#
# Generated by Vivado on Wed Jun 22 01:42:02 CEST 2016
# IP Build 1537824 on Fri Apr  8 04:28:57 MDT 2016 
#
# usage: design_1.sh [-help]
# usage: design_1.sh [-lib_map_path]
# usage: design_1.sh [-noclean_files]
# usage: design_1.sh [-reset_run]
#
# Prerequisite:- To compile and run simulation, you must compile the Xilinx simulation libraries using the
# 'compile_simlib' TCL command. For more information about this command, run 'compile_simlib -help' in the
# Vivado Tcl Shell. Once the libraries have been compiled successfully, specify the -lib_map_path switch
# that points to these libraries and rerun export_simulation. For more information about this switch please
# type 'export_simulation -help' in the Tcl shell.
#
# You can also point to the simulation libraries by either replacing the <SPECIFY_COMPILED_LIB_PATH> in this
# script with the compiled library directory path or specify this path with the '-lib_map_path' switch when
# executing this script. Please type 'design_1.sh -help' for more information.
#
# Additional references - 'Xilinx Vivado Design Suite User Guide:Logic simulation (UG900)'
#
# ********************************************************************************************************

# Directory path for design sources and include directories (if any) wrt this path
ref_dir="."

# Override directory with 'export_sim_ref_dir' env path value if set in the shell
if [[ (! -z "$export_sim_ref_dir") && ($export_sim_ref_dir != "") ]]; then
  ref_dir="$export_sim_ref_dir"
fi

# Command line options
# Script info
echo -e "design_1.sh - Script generated by export_simulation (Vivado v2016.1 (64-bit)-id)\n"

# Main steps
run()
{
  check_args $# $1
  setup $1 $2
  execute
}

# RUN_STEP: <execute>
execute()
{
  XILINX_VIVADO=/opt/Xilinx/Vivado/2016.1
  export XILINX_VIVADO
  irun -V93 -RELAX \
       -64bit \
       -timescale 1ps/1ps \
       -top xil_defaultlib.design_1 \
       -f run.f \
       -top glbl \
       glbl.v \
       -sv \
       +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" \
       +incdir+"$ref_dir/../../../ipstatic/axis_infrastructure_v1_1/hdl/verilog" \
       +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
       +incdir+"../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" \
       +incdir+"../../../ipstatic/axis_infrastructure_v1_1/hdl/verilog" \
       +incdir+"../../../ipstatic/processing_system7_bfm_v2_0/hdl"
}

# STEP: setup
setup()
{
  case $1 in
    "-lib_map_path" )
      if [[ ($2 == "") ]]; then
        echo -e "ERROR: Simulation library directory path not specified (type \"./design_1.sh -help\" for more information)\n"
        exit 1
      fi
     create_lib_mappings $2
     touch hdl.var
    ;;
    "-reset_run" )
      reset_run
      echo -e "INFO: Simulation run files deleted.\n"
      exit 0
    ;;
    "-noclean_files" )
      # do not remove previous data
    ;;
    * )
     create_lib_mappings $2
     touch hdl.var
  esac

  # Add any setup/initialization commands here:-

  # <user specific commands>

}

# Create design library directory paths and define design library mappings in cds.lib
create_lib_mappings()
{
  libs=(xil_defaultlib xpm processing_system7_bfm_v2_0_5 lib_pkg_v1_0_2 fifo_generator_v13_1_0 lib_fifo_v1_0_4 lib_srl_fifo_v1_0_2 lib_cdc_v1_0_2 axi_datamover_v5_1_10 axi_sg_v4_1_2 axi_dma_v7_1_9 proc_sys_reset_v5_0_9 xbip_utils_v3_0_6 axi_utils_v2_0_2 xbip_pipe_v3_0_2 xbip_dsp48_wrapper_v3_0_4 xbip_dsp48_addsub_v3_0_2 xbip_dsp48_multadd_v3_0_2 xbip_bram18k_v3_0_2 mult_gen_v12_0_11 floating_point_v7_1_2 axis_infrastructure_v1_1_0 axis_broadcaster_v1_1_8 generic_baseblocks_v2_1_0 axi_infrastructure_v1_1_0 axi_register_slice_v2_1_8 axi_data_fifo_v2_1_7 axi_crossbar_v2_1_9 blk_mem_gen_v8_3_2 axi_bram_ctrl_v4_0_7 axi_lite_ipif_v3_0_3 axi_timer_v2_0_10 axi_protocol_converter_v2_1_8 axi_clock_converter_v2_1_7 axi_dwidth_converter_v2_1_8)
  file="cds.lib"
  dir="ies"

  if [[ -e $file ]]; then
    if [[ ($1 == "") ]]; then
      return
    else
      rm -rf $file
    fi
  fi

  if [[ -e $dir ]]; then
    rm -rf $dir
  fi

  touch $file
  lib_map_path=""
  if [[ ($1 != "") ]]; then
    lib_map_path="$1"
  fi
  if [[ ($lib_map_path != "") ]]; then
    incl_ref="INCLUDE $lib_map_path/cds.lib"
    echo $incl_ref >> $file
  fi

  for (( i=0; i<${#libs[*]}; i++ )); do
    lib="${libs[i]}"
    lib_dir="$dir/$lib"
    if [[ ! -e $lib_dir ]]; then
      mkdir -p $lib_dir
      mapping="DEFINE $lib $dir/$lib"
      echo $mapping >> $file
    fi
  done
}
# Remove generated data from the previous run and re-create setup files/library mappings
reset_run()
{
  files_to_remove=(ncsim.key irun.key ncvlog.log ncvhdl.log compile.log elaborate.log simulate.log run.log waves.shm INCA_libs)
  for (( i=0; i<${#files_to_remove[*]}; i++ )); do
    file="${files_to_remove[i]}"
    if [[ -e $file ]]; then
      rm -rf $file
    fi
  done
}

# Check command line arguments
check_args()
{
  if [[ ($1 == 1 ) && ($2 != "-lib_map_path" && $2 != "-noclean_files" && $2 != "-reset_run" && $2 != "-help" && $2 != "-h") ]]; then
    echo -e "ERROR: Unknown option specified '$2' (type \"./design_1.sh -help\" for more information)\n"
    exit 1
  fi

  if [[ ($2 == "-help" || $2 == "-h") ]]; then
    usage
  fi

}

# Script usage
usage()
{
  msg="Usage: design_1.sh [-help]\n\
Usage: design_1.sh [-lib_map_path]\n\
Usage: design_1.sh [-reset_run]\n\
Usage: design_1.sh [-noclean_files]\n\n\
[-help] -- Print help information for this script\n\n\
[-lib_map_path <path>] -- Compiled simulation library directory path. The simulation library is compiled\n\
using the compile_simlib tcl command. Please see 'compile_simlib -help' for more information.\n\n\
[-reset_run] -- Recreate simulator setup files and library mappings for a clean run. The generated files\n\
from the previous run will be removed. If you don't want to remove the simulator generated files, use the\n\
-noclean_files switch.\n\n\
[-noclean_files] -- Reset previous run, but do not remove simulator generated files from the previous run.\n\n"
  echo -e $msg
  exit 1
}

# Launch script
run $1 $2
