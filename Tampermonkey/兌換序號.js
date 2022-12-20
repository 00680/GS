// ==UserScript==
// @name         快樂玩自動兌換序號
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  快樂玩自動兌換序號
// @author       You
// @match        *https://www.mangot5.com/Index/Billing/couponList*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=tampermonkey.net
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
