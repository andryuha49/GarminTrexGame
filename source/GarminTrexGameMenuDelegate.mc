using Toybox.WatchUi;
using Toybox.System;

class GarminTrexGameMenuDelegate extends WatchUi.MenuInputDelegate {
    hidden var gameManager;

    function initialize(pGameManager) {
        MenuInputDelegate.initialize();
        gameManager = pGameManager;
    }

    function onMenuItem(item) {
        if (item == :play) {
            var curentGame = gameManager.makeNewGame();
            curentGame.start(1);
        } else if (item == :about) {
            WatchUi.pushView(new GarminTrexGameAboutView(), new GarminTrexGameAboutViewDelegate(), WatchUi.SLIDE_UP);
        } else if (item == :exit) {
            System.exit();
        }
    }
}
