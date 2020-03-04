using Toybox.WatchUi;
using Toybox.System;

class GarminTrexGameMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        if (item == :about) {
            WatchUi.pushView(new GarminTrexGameAboutView(), new GarminTrexGameAboutViewDelegate(), WatchUi.SLIDE_UP);
        } else if (item == :exit) {
            System.exit();
        }
    }

}