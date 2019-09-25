rem @echo off
rem title 银企日志备份 备份时间:%CurDate%

rem ======================================================================
rem STEP1 start:获取系统执行该任务的时间                                 =
rem ======================================================================
echo 获取系统时间
set CurYear=%Date:~0,4%

set CurMonth=%Date:~5,2%
if %CurMonth% LSS 10 set CurMonth=0%Date:~6,1%

set CurDay=%Date:~8,2%
if %CurDay% LSS 10 set CurDay=0%Date:~9,1%

set Curhore=%time:~0,2%
if %Curhore% LSS 10 set Curhore=0%time:~1,1%

set Curminute=%time:~3,2%
if %Curminute% LSS 10 set Curminute=0%time:~4,1%

set Cursecond=%time:~6,2%
if %Cursecond% LSS 10 set Cursecond=0%time:~7,1%

set CurDate=%CurYear%%CurMonth%%CurDay%_%Curhore%%Curminute%%Cursecond%


rem ===================================================
rem STEP2 start:环境变量设置                          =
rem STEP2.1:源文件路径                                =
rem STEP2.2:压缩路径                                  =
rem STEP2.3:rar环境变量添加                           =
rem STEP2.4:获取所需备份文件的日期（上月15号）        =
rem ===================================================
set FilePath=C:\Users\Administrator\Desktop\新建文件夹

set BackPath=C:\Log_M_B2EC%CurDate%.rar

set Path=%Path%;"C:\Program Files\WinRAR"

if %CurMonth% LSS 10 (set /a LastMonth=%Date:~6,1%-1)
if not %CurMonth% LSS 10 (set /a LastMonth=%Date:~5,2%-1)


rem 设置备份日期:等于EQU;不等于NEQ;少于LSS;少于等于LEQ;大于GTR;大于等于GEQ.
rem case1:当前月份为1月,则压缩去年12月前的文件;
rem case2:当前月份为2-9月份,则压缩当年上月前的文件,月份前补齐0;
rem case3:当前月份为10-12月份,则压缩当年上月的文件,月份前不用补齐0.
echo 上月月份为:%LastMonth%
if %LastMonth% LSS 10 if %LastMonth% GEQ 1 (set LastMonth_Temp=0%LastMonth% & set /a LastYear=%CurYear%)

if %LastMonth% LSS 1 (set LastMonth_Temp=12 & set /a LastYear=%CurYear%-1)

if %LastMonth% LEQ 12 if %LastMonth% GEQ 10 (set /a LastMonth_Temp=%LastMonth% & set /a LastYear=%CurYear%)

set LastMonth=%LastMonth_Temp%

rem 去除LastMonth变量中的空格
set "LastMonth=%LastMonth: =%"

set BakUpDate=%LastYear%-%LastMonth%-15


rem ===================================================
rem STEP3 start:切换到源文件路径(去除)                =
rem ===================================================
rem C:
rem cd %FilePath%

rem ================================================================================================
rem STEP4 start:开始压缩                                                                           =
rem "C:\Program Files\WinRAR\Rar.exe" a -r %BackPath% *.log(需与STEP3共用)                         =
rem forfiles /p %FilePath% /m *.log /d -1 /c "cmd /c rar a %BackPath% @path"                       =
rem ================================================================================================
echo 开始压缩银企日志，备份源文件路径：%FilePath%，备份目标路径：%BackPath%，备份日期：%BakUpDate%

rem a:添加文件到压缩文档 -r:递归子目录 -tb:处理YYYY-MM-DD之前修改过的文件 -ep1:从名称里排除根目录
rar a -r -tb%BakUpDate% -ep1 "%BackPath%" "%FilePath%\*.log"

echo 结束压缩银企日志

rem ============================================================================
rem STEP5 start:清理已压缩的源文件(去除)                                       =
rem ============================================================================
rem echo 开始清除银企日志源文件

rem del %FilePath%\*.log
rem forfiles /p %FilePath% /m *.log /d -1 /c "cmd /c del /f /q /a @path"

rem echo 结束清除银企日志

rem ===================================================
rem STEP6 END                                         =
rem ===================================================

pause
