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
    if (document.querySelectorAll(".sendItemButton").length > 0) {
        gachaMall.openModal($("#processingModal"));

        setTimeout(function () {
            // confirmModal complate message HTML
            $("#complateMessage").html("");
            multiSendItemProc();
        }, 1000);
    }
})();
