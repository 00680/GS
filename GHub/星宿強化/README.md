## 新增至GHub
[GHub 說明書](https://www.logitech.com/assets/65550/ghub.pdf#page=97)

## 須注意事項
1. 以 `系統管理員` 開啟GHub
2. 開啟 `鎖定滑鼠`
3. 星宿放到第一行左邊第一格
4. 預留第二行左邊第一格 + 任意一格空位防止爆滿

## 開始強化
1. 開啟強化版面
2. 開啟 `CAPSLOCK`
3. 左/右擊滑鼠開始強化

## 停止強化
1. 關閉 `CAPSLOCK` 

## 已知問題
1. 強化後調位導致無法繼續強化
   1. 可先刪除 56-60行
   ```
    moveMouse(absSecondBoxX, absSecondBoxY) --第二格
    leftClick() --拎起
    moveMouse(absFirstBoxX, absFirstBoxY) --第一格
    leftClick() --放低
    rightClick()
    ```
   2. 或 第一行第一格, 第二行第一格分別放上不同星宿 同時強化
