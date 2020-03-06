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
            game.saveScore();
            game.end();
        }
        game = new TrexGame.TrexGame();
        game.start(1);

        return game;
    }

    function drawLayout(dc) {
        var game = new TrexGame.TrexGame();
        game.drawLayout(dc);
    }
}