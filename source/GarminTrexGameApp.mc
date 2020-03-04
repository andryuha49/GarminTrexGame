using Toybox.Application;
using Toybox.WatchUi;

class GarminTrexGameApp extends Application.AppBase {
    var gameManager;

    function initialize() {
        AppBase.initialize();
        gameManager = new GameManager();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [
            new GarminTrexGameView(gameManager),
            new GarminTrexGameInputDelegate(gameManager)
        ];
    }

}
