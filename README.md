# ICP Automation
## Introduction
This is work in progress automation of toolchain for IC Project course.

## Initial setup
Add custom commands to your command line and then reload the terminal:
```
touch ~/.bash_aliases
echo "alias icp='source [your_folder]/scripts/setup_icp'" >> ~/.bash_aliases
echo "alias ictool='source [your_folder]/scripts/ictool'" >> ~/.bash_aliases
```

## Script call structure
```
setup_icp
│   project_dirs  (user defined)

ictool
|   lib_list (user defined)
|   compile_list (user defined)
|
└── simulate (WIP)
│   │   waves.do (user defined)
│
└── synthesis (TODO)
|   |   (TODO)
│    
└── layout (TODO)
│    
└── power (WIP)
    |   power.tcl
```

## Considerations
* `setup_icp` script can stop working if the institution changes tools and their directories.
