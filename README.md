# ICP Automation
## Introduction
This project is automation of toolchain for IC Project course.

## Initial setup
In the main directory run the following in command line and then reload the terminal:
```
touch ~/.bash_aliases
echo "alias icp='source $PWD/scripts/setup_icp'" >> ~/.bash_aliases
echo "alias map_files='source $SCRIPT_DIR/map_files'" >> ~/.bash_aliases
```
After this `setup_icp` can be easily called by `icp' from any directory.

## What commands do
`setup_icp` : sets up environment (QuestaSim, Genus, Encounter, PrimeTime and STM Libraries) for Digital IC design. \
`map_files` : sets environment variables like file and library names that are then used by different programs. \
`ictool` : toolchain script.

## Script call structure
```
setup_icp
│   project_dirs    (user defined)

map_files
|   lib_list        (user defined)
|   lib_prefs       (user defined)
|   file_list       (user defined)

ictool
└── simulate
|   |   sim_prefs   (user defined)
│   │   waves.do    (user defined)
|   |   vcd.do      (user defined)
│
└── synthesis
|   └── synthesis.tcl
|       |   synth_prefs.tcl  (user defined) 
│       
└── layout
|   └── pnr_flow.tcl
|       |   mmmc.view   (user defined)
|       |   pad.io      (user defined)
│    
└── power
    |   power.tcl
```

## Examples
### Setup Environment:
This allows user to call `genus`, `primetime`, `encounter`, `vsim` etc from command line:
```
icp
```
### Update project files
This command should be run after `icp`, it updates the environt variables that are needed for `ictool`.
```
map_files
```
### Synthesis:
```
ictool -o synth -p LPHVT -c bc -v 1.05 -t 105
```
If the options `-p LPHVT -c bc -v 1.05 -t 105` are not specified, then the defaults are used from `lib_prefs` file

### Simulation:
```
ictool -o sim
```
And then choosing a simulation option: \
`b` - behavioural model \
`s` - post-synthesis design \
`l` - post-layout design \
`vcd` - post-layout simulation that generates vcd file

### Layout:
```
ictool -o layout
```
### Power simulation:
```
ictool -o power
```

## Considerations
* `setup_icp` script can stop working if the institution changes tools and their directories.
