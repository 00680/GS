@echo off
chcp 65001>NUL

set /P orig_path=原始路徑:
if  not defined orig_path (
    echo 請輪入原始路徑!
    pause
    exit 
) else if not exist %orig_path%\Online (
    echo 無效巨商資料夾
    pause
    exit 
)

set /P dest_path=目標路徑:
if  not defined dest_path (
    echo 請輪入目標路徑!
    pause
    exit 
) else if not exist %dest_path% (
    echo %dest_path% 不存在...建立中
    mkdir %dest_path% 
)

:: https://github.com/byungmeo/GersangStation/blob/master/GersangStation/Modules/ClientCreator.cs#L127-L135
for %%F in (%orig_path%\*) do (
    if not %%~xF == .tmp ( 
        if not %%~xF == .dmp (
            if not %%~xF == .bmp (
                echo 正複製 %%F 至 %dest_path%\%%~xnF 
                COPY /Y %%F %dest_path% >NUL
                echo 已複製 %%F 至 %dest_path%\%%~xnF & echo:
            )
        )
    )
)

:: https://github.com/byungmeo/GersangStation/blob/master/GersangStation/Modules/ClientCreator.cs#L139-L146
for /d %%D in (%orig_path%\*) do (
    if not %%~nD == Online (
        if not %%~nD == XIGNCODE (
            if not exist %dest_path%\%%~nD (
                echo 正建立連結 %%D 至 %dest_path%\%%~nD
                mklink /d "%dest_path%\%%~nD" "%%D">NUL
                echo 已連結 %%D 至 %dest_path%\%%~nD & echo:
            )
        )
    )
)

if exist %dest_path%\XIGNCODE (
    rmdir /s /q %dest_path%\XIGNCODE
)

xcopy %orig_path%\XIGNCODE\ %dest_path%\XIGNCODE\>NUL

if not exist %dest_path%\Online (
    mkdir %dest_path%\Online
)

:: https://github.com/byungmeo/GersangStation/blob/master/GersangStation/Modules/ClientCreator.cs#L160-L179
for %%F in (%orig_path%\Online\*) do (
    if not %%~xnF == KeySetting.dat ( 
        if not %%~xnF == PetSetting.dat ( 
            if not %%~xnF == AKinteractive.cfg ( 
                if not %%~xnF == CombineInfo.txt ( 
                    IF EXIST %dest_path%\Online\%%~xnF (
                        del %dest_path%\Online\%%~xnF
                    )
                    echo 正建立連結 %%F 至 %dest_path%\Online\%%~xnF
                    mklink %dest_path%\Online\%%~xnF %%F > NUL
                    echo 已連結 %%F 至 %dest_path%\Online\%%~xnF & echo:
                ) else (
                    echo 正複製 %%F 至 %dest_path%\Online\%%~xnF 
                    COPY /Y %%F %dest_path%\Online >NUL
                    echo 已複製 %%F 至 %dest_path%\Online\%%~xnF & echo:
                )
            ) else (
                echo 正複製 %%F 至 %dest_path%\Online\%%~xnF 
                COPY /Y %%F %dest_path%\Online >NUL
                echo 已複製 %%F 至 %dest_path%\Online\%%~xnF & echo:
            )
        ) else (
            echo 正複製 %%F 至 %dest_path%\Online\%%~xnF 
            COPY /Y %%F %dest_path%\Online >NUL
            echo 已複製 %%F 至 %dest_path%\Online\%%~xnF & echo:
        )
    ) else (
        echo 正複製 %%F 至 %dest_path%\Online\%%~xnF 
        COPY /Y %%F %dest_path%\Online >NUL
        echo 已複製 %%F 至 %dest_path%\Online\%%~xnF & echo:
    )
)

:: https://github.com/byungmeo/GersangStation/blob/master/GersangStation/Modules/ClientCreator.cs#L182-L188
for /d %%D in (%orig_path%\Online\*) do (
    if not exist %dest_path%\Online\%%~nD (
        echo 正建立連結 %%D 至 %dest_path%\Online\%%~nD
        mklink /d "%dest_path%\Online\%%~nD" "%%D">NUL
        echo 已連結 %%D 至 %dest_path%\Online\%%~nD & echo:
    )
)

For %%A in ("%dest_path%") do (
    Set Name=%%~nxA
)

echo 正建立桌面連結...
mklink %USERPROFILE%\Desktop\%Name%_Run.exe %dest_path%\Run.exe  > NUL
echo %USERPROFILE%\Desktop\%Name%_Run.exe 已建立 & echo:

echo 完成! & echo:

pause
