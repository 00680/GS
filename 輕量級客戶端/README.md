# CreateClient.bat — 輕量級客戶端建立腳本說明

## 簡介
`CreateClient.bat` 用來從原始巨商（Gersang）遊戲資料夾建立一個輕量級客戶端。腳本會在目標資料夾中複製必要檔案，並以符號連結（symlink）串接大型資料夾以節省空間與便於維護。

## 前置條件
- 作業系統：Windows
- 需以系統管理員身分執行（建立符號連結需管理員權限）。
- 原始資料夾必須包含 `Online` 子資料夾。

## 使用方式
1. 右鍵以「以系統管理員身分執行」啟動 `CreateClient.bat`。
2. 在提示輸入 `原始路徑` 時，輸入你的巨商原始資料夾路徑（含 `Online`）。
3. 在提示輸入 `目標路徑` 時，輸入要建立輕量級客戶端的路徑（若不存在會自動建立）。

## 腳本會做的事（重點）
- 複製原始資料夾根目錄下的大部分檔案（排除 `.tmp`、`.dmp`、`.bmp` 等類型）。
- 對原始資料夾內的子目錄（不包含 `Online` 與 `XIGNCODE`）建立目標資料夾的符號資料夾連結（`mklink /d`）。
- 若目標資料夾已存在 `XIGNCODE`，會先移除再完整複製原始的 `XIGNCODE`（以確保反作弊相關檔案正確）。
- 確保目標的 `Online` 資料夾存在；對 `Online` 內的檔案，大部分會建立檔案符號連結，但下列檔案會被「複製」而非連結：`KeySetting.dat`、`PetSetting.dat`、`AKinteractive.cfg`、`CombineInfo.txt`。
- 對 `Online` 內的子資料夾會建立符號資料夾連結。
- 在使用者桌面上建立一個指向目標資料夾 `Run.exe` 的連結，名稱為 `<目標資料夾名稱>_Run.exe`。

## 範例
- 原始：`C:\Gersang\GersangStation`
- 目標：`D:\LightClient`
- 結果：`D:\LightClient` 會包含複製的必要檔案、指向原始子資料夾的符號連結，以及桌面上的 `LightClient_Run.exe` 連結指向 `D:\LightClient\Run.exe`。

## 注意事項
- 建立符號連結需要管理員權限；否則 `mklink` 會失敗。
- `XIGNCODE`（防作弊模組）會被完整複製到目標資料夾以避免問題。
- 腳本使用 UTF-8 主控台（`chcp 65001`），並包含對 GersangStation ClientCreator 的參考實作註解。

## 參考資料
- https://github.com/byungmeo/GersangStation