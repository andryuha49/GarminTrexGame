using Toybox.System;
using Toybox.WatchUi;

class GarminTrexGameInputDelegate extends WatchUi.InputDelegate {
    hidden var gameManager;

    function initialize(pGameManager) {
        InputDelegate.initialize();
        gameManager = pGameManager;
    }

    function onKey(keyEvent) {
        var key = keyEvent.getKey();
        if (key == WatchUi.KEY_MENU) {
            openMenu();
        }
        if (key == WatchUi.KEY_ESC) {
            openMenu();
        }
        if (key == WatchUi.KEY_ENTER) {
            onGameTap();
        }
        return true;
    }

    function onTap(clickEvent) {
        onGameTap();
        return true;
    }

    function onSwipe(swipeEvent) {
        // System.println(swipeEvent.getDirection()); // e.g. SWIPE_DOWN = 2
        return true;
    }

    hidden function openMenu() {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new GarminTrexGameMenuDelegate(gameManager), WatchUi.SLIDE_UP);
    }

    hidden function onGameTap() {
        var curentGame = gameManager.getCurrentGame();
        if (curentGame == null) {
            curentGame = gameManager.makeNewGame();
        }
        curentGame.onTap();
    }
}