// ==UserScript==
// @name         快樂玩自動領取扭蛋
// @namespace    GS tam
// @version      0.1
// @description  快樂玩自動領取扭蛋
// @author       00680
// @match        https://gs.mangot5.com/game/gs/mall/gacha/inventory*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';
    alert = () => {};
    $('button.sendItemButton')[0] && $('button.sendItemButton')[0].click();
})();
