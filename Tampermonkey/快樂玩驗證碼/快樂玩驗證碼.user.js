// ==UserScript==
// @name         快樂玩驗證碼
// @namespace    GS tam
// @version      0.1
// @description  快樂玩驗證碼
// @author       00680
// @match        https://www.mangot5.com/Index/Member/Login*
// @require      https://raw.githubusercontent.com/jiangts/JS-OTP/master/dist/jsOTP-es5.min.js
// @grant        none
// ==/UserScript==

(function() {
    'use strict';
    const codeField = document.getElementById('validCode');
    codeField.type = 'password';
    codeField.maxLength = 16;
    codeField.addEventListener("change", () => {
        if (codeField.value.length === 16){
            const totp = new jsOTP.totp();
            codeField.value = totp.getOtp(codeField.value);
        }
    })
})();
