using Toybox.Timer;
using Toybox.WatchUi;
using Toybox.Math;
using Toybox.Application;

module TrexGame {
    class TrexGameProcess extends WatchUi.InputDelegate {
        hidden var timerInterval = Constants.START_TIMER_INTERVAL;

        hidden var restartBtn;
        hidden var gameTimer;
        hidden var scoreTimer;
        hidden var score = 0;
        hidden var highScore = 0;
        hidden var gameLevel = 1;

        hidden var isGameOver = false;

        hidden var screenWidth = 300;
        hidden var screenHeight = 200;
        hidden var screenShape;

        hidden var groundYPosition = 137;

        hidden var backdrop;
        hidden var cloud;
        hidden var clouds = [];

        hidden var cactus;
        hidden var cactuses = [];

        hidden var obstacle;

        hidden var trex;
        hidden var ground;

        var obstacleLines;
        var trexLines;

        function initialize() {
            InputDelegate.initialize();

            var settings = System.getDeviceSettings();
            screenWidth = settings.screenWidth;
            screenHeight = settings.screenHeight;
            screenShape = settings.screenShape;

            backdrop = new Rez.Drawables.backdrop();

            groundYPosition = WatchUi.loadResource(Rez.Strings.properties_GroundPosition).toNumber();
                //Application.AppBase.getProperty("GroundPosition");

            scoreTimer = new Timer.Timer();
        }

        function drawLayout(dc) {
            makeGameObjects();

            backdrop.draw(dc);
            cloud.draw(dc);
            ground.draw(dc);
            trex.draw(dc);
        }

        function start(level) {
            score = 0;
            timerInterval = Constants.START_TIMER_INTERVAL;
            isGameOver = false;
            if (level != null) {
                gameLevel = level;
            }

            makeGameObjects();

            var app = Application.getApp();
            var hiScore = app.getProperty(Enums.Keys.HIGH_SCORE_KEY);
            if (hiScore != null) {
                highScore = hiScore;
            }

            scoreTimer.start(method(:scoreTimerCallback), Constants.SCORE_TIMER_INTERVAL, true);
            restartTimer();

            onTap();
        }

        hidden function restartTimer() {
            if (gameTimer == null) {
                 gameTimer = new Timer.Timer();
            } else {
                gameTimer.stop();
            }
            gameTimer.start( method(:timerCallback), timerInterval, true );
        }

        hidden function makeGameObjects() {
            cloud = new Cloud(groundYPosition, screenWidth);
            ground = new Ground(groundYPosition, screenWidth);
            obstacle = new Obstacle(groundYPosition, screenWidth);
            trex = new Trex(groundYPosition);
        }

        function onTap() {
            if (isGameOver == true) {
                start(gameLevel);
            }
            trex.jump();
            return true;
        }

        function crouch(crouched) {
            trex.crouch(crouched);
        }

        function onUpdate(dc) {
            dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());

            backdrop.draw(dc);
            cloud.draw(dc);
            ground.draw(dc);
            trex.draw(dc);

            obstacle.draw(dc);

            dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
            drawScores(dc);

            if (isGameOver == true) {
                drawGameOver(dc);
            }

            // draw lines ariund the characters for debugging
            // drawLines(dc);
        }

        hidden function drawLines(dc) {
            if (obstacleLines != null) {
                for (var i = 0; i < obstacleLines.size(); i++) {
                    dc.drawLine(obstacleLines[i][0], obstacleLines[i][1], obstacleLines[i][2], obstacleLines[i][3]);
                }
            }

            if (trexLines != null) {
                for (var i = 0; i < trexLines.size(); i++) {
                    dc.drawLine(trexLines[i][0], trexLines[i][1], trexLines[i][2], trexLines[i][3]);
                }
            }
        }

        function end() {
            if (gameTimer != null) {
                gameTimer.stop();
            }
            scoreTimer.stop();
        }

        function timerCallback() {
            // pause for first dino jump
            if (score > 25) {
                obstacle.move();
            }
            ground.move();
            cloud.move();
            trex.move();

            checkBumping();

            WatchUi.requestUpdate();
        }

        function scoreTimerCallback() {
            score = score + 1;
            updateTimer();
        }

        hidden function updateTimer() {
            if (timerInterval > 50 && score % 100 == 0) {
                timerInterval = timerInterval - 10;
                restartTimer();
            }
        }

        hidden function checkBumping() {
            obstacleLines = getCharacterLines(obstacle, 10, 10, 5, 5);
            trexLines = getCharacterLines(trex, 5, 5, 10, 10);

            for (var i = 0; i < obstacleLines.size(); i++) {
                var isIntersection = shapeIntersection(obstacleLines[i], trexLines);
                if (isIntersection == true) {
                    gameOver();
                    return;
                }
            }
        }

        hidden function getCharacterLines(character, offsetTop, offsetRight, offsetBottom, offsetLeft) {
            var width = character.getDimensions()[0];
            var height = character.getDimensions()[1];

            var x = character.getX();
            var y = character.getY();

            var lines = [
                // top
                [
                    x + offsetLeft,
                    y + offsetTop,
                    x + width - offsetRight,
                    y + offsetTop
                ],
                // right
                [
                    x + width - offsetRight,
                    y + offsetTop,
                    x + width - offsetRight,
                    y + height - offsetBottom
                ],
                // bottom
                [
                    x + width - offsetRight,
                    y + height - offsetBottom,
                    x + offsetLeft,
                    y + height - offsetBottom
                ],
                // left
                [
                    x + offsetLeft,
                    y + height - offsetBottom,
                    x + offsetLeft,
                    y + offsetTop
                ]
            ];

            return lines;
        }

        function gameOver() {
            isGameOver = true;
            end();
            trex.bump();
            updateHighScrore();

            WatchUi.requestUpdate();
        }

        hidden function updateHighScrore() {
            if (score > highScore) {
                highScore = score;
                var app = Application.getApp();
                app.setProperty(Enums.Keys.HIGH_SCORE_KEY, highScore);
            }
        }

        hidden function drawGameOver(dc) {
            if (restartBtn == null) {
                restartBtn = new WatchUi.Bitmap(
                    {:rezId=>Rez.Drawables.restartBtn,:locX=>WatchUi.LAYOUT_HALIGN_CENTER,:locY=>groundYPosition - 65}
                );
            }
            restartBtn.draw(dc);
            dc.drawText(
                screenWidth / 2,
                groundYPosition - 100,
                Graphics.FONT_MEDIUM,
                WatchUi.loadResource(Rez.Strings.gameOver), // GAME OVER
                Graphics.TEXT_JUSTIFY_CENTER
            );
        }

        // check line and shape intersection
        hidden function shapeIntersection(lineCoordinates, shapeLines) {
            for(var i = 0; i < shapeLines.size(); i++) {
                var isIntersection =
                    linesIntersection(
                        lineCoordinates[0], lineCoordinates[1], lineCoordinates[2], lineCoordinates[3],
                        shapeLines[i][0], shapeLines[i][1], shapeLines[i][2], shapeLines[i][3]
                    );
                if (isIntersection == true) {
                    return true;
                }
            }
            return false;
        }

        hidden function linesIntersection(ax1, ay1, ax2, ay2, bx1, by1, bx2, by2) {
             var v1 = (bx2 - bx1) * (ay1 - by1) - (by2 - by1) * (ax1 - bx1);
             var v2 = (bx2 - bx1) * (ay2 - by1) - (by2 - by1) * (ax2 - bx1);
             var v3 = (ax2 - ax1) * (by1 - ay1) - (ay2 - ay1) * (bx1 - ax1);
             var v4 = (ax2 - ax1) * (by2 - ay1) - (ay2 - ay1) * (bx2 - ax1);

             var res = (v1 * v2 < 0) && (v3 * v4 < 0);
             return res;
        }

        hidden function drawScores(dc) {
            drawCurrentScore(dc);
            drawHighScore(dc);
        }

        hidden function drawCurrentScore(dc) {
            var x;
            var y = 2;
            var justify;
            if (screenShape == System.SCREEN_SHAPE_ROUND || screenShape == System.SCREEN_SHAPE_SEMI_ROUND) {
                x = screenWidth / 2;
                justify = Graphics.TEXT_JUSTIFY_CENTER;
            } else {
                x = screenWidth - 5;
                justify = Graphics.TEXT_JUSTIFY_RIGHT;
            }
            dc.drawText(x, y, Graphics.FONT_SMALL, formatScoreNumber(score), justify);
        }

        hidden function drawHighScore(dc) {
            var x;
            var y = 2;
            var justify;
            if (screenShape == System.SCREEN_SHAPE_ROUND || screenShape == System.SCREEN_SHAPE_SEMI_ROUND) {
                x = screenWidth / 2;
                y = screenHeight - 38;
                justify = Graphics.TEXT_JUSTIFY_CENTER;
            } else {
                x = 5;
                justify = Graphics.TEXT_JUSTIFY_LEFT;
            }
            dc.drawText(x, y, Graphics.FONT_SMALL, "HI " + formatScoreNumber(highScore), justify);
        }

        hidden function formatScoreNumber(number) {
            if (number < 10) {
                return "0000" + number;
            }
            if (number < 100) {
                return "000" + number;
            }
            if (number < 1000) {
                return "00" + number;
            }
            if (number < 10000) {
                return "0" + number;
            }
            if (number > 99999) {
                return "99999";
            }
            return "" + number;
        }
    }
}
