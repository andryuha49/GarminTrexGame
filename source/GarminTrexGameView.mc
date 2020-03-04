using Toybox.WatchUi;
using Toybox.Timer;

using Toybox.Math;

class GarminTrexGameView extends WatchUi.View {
    var gameManager;

    var timer;
    var tic = 30;
    var myBitmap;

    var screenWidth;
    
    
    function initialize(pGameManager) {
        View.initialize();
        gameManager = pGameManager;

        timer = new Timer.Timer();
    }

    // Load your resources here
    function onLayout(dc) {
        screenWidth = dc.getWidth();
        gameManager.drawLayout(dc);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        var game = gameManager.getCurrentGame();
        if (game != null) {
            game.onUpdate(dc);
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
}