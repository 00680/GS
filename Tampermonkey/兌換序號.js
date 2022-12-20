// ==UserScript==
// @name         快樂玩自動兌換序號
// @version      0.1
// @description  快樂玩自動兌換序號
// @author       00680
// @match        *https://www.mangot5.com/Index/Billing/couponList*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    $('input[type=text]#couponSerial').change(
        () => {
            $('button#couponCheckBtn').click();

            setTimeout(()=>{
                $('input[type=text]#couponSerial').attr('readonly') && alert = () => {} && $('button#couponUseBtn').click();
            }, 1000);

            return;
        }
    )
})();
