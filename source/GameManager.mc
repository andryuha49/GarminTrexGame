using Toybox.Application;

class GameManager {
    var game;

    function initialize() {

    }

    function getCurrentGame() {
        return game;
    }

    function makeNewGame() {
        if(game != null) {
            game.end();
        }
        game = new TrexGame.TrexGameProcess();
        game.start(1);

        return game;
    }

    function drawGameLayout(dc) {
        var game = new TrexGame.TrexGameProcess();
        game.drawLayout(dc);
    }
}