# ICP Automation
## Introduction
This project is automation of toolchain for IC Project course.

## Initial setup
In the main directory run the following in command line and then reload the terminal:
```
touch ~/.bash_aliases
echo "alias icp='source $PWD/scripts/setup_icp'" >> ~/.bash_aliases
echo "alias ictool='source $PWD/scripts/ictool'" >> ~/.bash_aliases
```
After this `setup_icp` can be easily called by `icp`.

## What it does
`setup_icp` : sets up environment (QuestaSim, Genus, Encounter, PrimeTime and STM Libraries) for Digital IC design. 

`ictool` : toolchain script.

## Script call structure
```
setup_icp
│   project_dirs    (user defined)

ictool
|   lib_list        (user defined)
|   lib_prefs       (user defined)
|   file_list       (user defined)
|
└── simulate (WIP)
|   |   sim_prefs   (user defined)
│   │   waves.do    (user defined)
|   |   vcd.do      (user defined)
│
└── synthesis
|   └──synthesis.tcl
|       |   synth_prefs.tcl  (user defined) 
│       
└── layout (TODO)
|   |   (TODO)
│    
└── power (WIP)
    |   power.tcl (WIP)
```

## Considerations
* `setup_icp` script can stop working if the institution changes tools and their directories.
