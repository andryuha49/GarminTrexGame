using Toybox.System;
using Toybox.WatchUi;

class GarminTrexGameAboutViewDelegate extends WatchUi.InputDelegate {
    function initialize() {
        InputDelegate.initialize();
    }

    function onKey(keyEvent) {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
        return true;
    }

    function onTap(clickEvent) {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
        return true;
    }

    function onSwipe(swipeEvent) {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
        return true;
    }
}