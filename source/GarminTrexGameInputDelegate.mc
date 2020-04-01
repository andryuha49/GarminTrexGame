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
        if (key == WatchUi.KEY_ENTER || key == WatchUi.KEY_UP) {
            onGameTap();
        }
        return true;
    }

    function onKeyPressed(keyEvent) {
        var key = keyEvent.getKey();
        if (key == WatchUi.KEY_DOWN) {
            onCrouch(true);
        }
        return true;
    }

    function onKeyReleased(keyEvent) {
        var key = keyEvent.getKey();
        if (key == WatchUi.KEY_DOWN) {
            onCrouch(false);
        }
        return true;
    }

    function onTap(clickEvent) {
        onGameTap();
        return true;
    }

    function onSwipe(swipeEvent) {
        return true;
    }

    hidden function openMenu() {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new GarminTrexGameMenuDelegate(gameManager), WatchUi.SLIDE_UP);
    }

    hidden function onGameTap() {
        var currentGame = gameManager.getCurrentGame();
        if (currentGame == null) {
            currentGame = gameManager.makeNewGame();
        }
        currentGame.onTap();
    }

    hidden function onCrouch(crouched) {
        var currentGame = gameManager.getCurrentGame();
        if (currentGame != null) {
            currentGame.crouch(crouched);
        }
    }
}