@echo off
set xv_path=E:\\Softwares\\Vivado\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto e1270ed870e447edb4acf4f937430c6d -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot tb_PWM_behav xil_defaultlib.tb_PWM xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
