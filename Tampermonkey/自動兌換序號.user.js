// ==UserScript==
// @name         快樂玩自動兌換序號
// @namespace    GS tam
// @version      0.1
// @description  快樂玩自動兌換序號
// @author       00680
// @match        https://www.mangot5.com/Index/Billing/couponList*
// @grant        none
// ==/UserScript==

(function () {
  'use strict';

  if ($('input.btn.btn-danger')[0]) {
    $('input.btn.btn-danger')[0].click();
    $('button#couponCheckBtn').click();
    setTimeout(() => {
      alert = () => {};
      $('input[type=text]#couponSerial').attr('readonly') &&
        $('button#couponUseBtn').click();
    }, 1000);
  }
})();
