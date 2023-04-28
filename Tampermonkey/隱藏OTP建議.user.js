// ==UserScript==
// @name         隱藏OTP建議
// @namespace    GS tam
// @version      0.1
// @description  隱藏OTP建議
// @author       00680
// @match        https://www.mangot5.com/Index/Member/Login*
// @grant        none
// ==/UserScript==

(function () {
  'use strict';

  if ($('#validCode')) {
    $('#validCode').attr("autocomplete", "off")
  }
})();
