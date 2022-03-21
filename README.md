# ICP Automation
## Introduction
This is work in progress automation of toolchain for IC Project course.

## Initial setup
Add custom commands to your command line and then reload terminal by executing the following:
```
touch ~/.bash_aliases
echo "alias icp='source [your_folder]/scripts/setup_icp'" >> ~/.bash_aliases
echo "alias run='source [your_folder]/scripts/run'" >> ~/.bash_aliases
reset
```

## Considerations
* `setup_icp` script can stop working if the institution changes their tools and their directories.



## TODO
* What is modelsim.ini?
* Add synthesis script
* Improve simulation script
* Add library list script
* Add layout script
