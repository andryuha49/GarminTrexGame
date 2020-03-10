using Toybox.Math;

module TrexGame {
    class Obstacle extends GameCharacter {
        hidden const speed = 7;

        hidden var groundYPosition;
        hidden var screenWidth;
        hidden var step = 0;

        var isPtarodactyl = false;
        var isPtarodactylUp = false;

        hidden const obsticles = {
            0 => Rez.Drawables.sCactus1,
            1 => Rez.Drawables.sCactus2,
            2 => Rez.Drawables.sCactus3,
            3 => Rez.Drawables.bCactus1,
            4 => Rez.Drawables.bCactus2,
            5 => Rez.Drawables.bCactus3,

            6 => Rez.Drawables.pterodactylUp
        };

        function initialize(pGroundYPosition, pScreenWidth) {
            GameCharacter.initialize(Rez.Drawables.sCactus1, pScreenWidth, 0);

            groundYPosition = pGroundYPosition;
            screenWidth = pScreenWidth;

            makeNewObsticle();
        }

        function move() {
            var width = bitmap.getDimensions()[0];
            if (step - width > screenWidth) {
                makeNewObsticle();
            }
            xPosition = screenWidth - step;
            bitmap.setLocation(xPosition, yPosition);
            step = step + speed;
        }

        function draw(dc) {
            if (isPtarodactyl == true) {
                if (isPtarodactylUp == true) {
                    bitmap.setBitmap(Rez.Drawables.pterodactylUp);
                    isPtarodactylUp = false;
                } else {
                    bitmap.setBitmap(Rez.Drawables.pterodactylDown);
                    isPtarodactylUp = true;
                }
            }

            bitmap.draw(dc);
        }

        function getDimensions() {
            return bitmap.getDimensions();
        }

        function makeNewObsticle() {
            step = 0;
            var random = Math.rand() % 7; // 7 - max obstacles count

            bitmap.setBitmap(obsticles[random]);
            // is pterodactyl
            if (random == 6) {
                makePtarodactyl();
            } else {
                makeCactus();
            }
        }

        function makePtarodactyl() {
            isPtarodactyl = true;
            isPtarodactylUp = true;
            var height = bitmap.getDimensions()[1];
            var positio = Math.rand() % 2;
            yPosition = groundYPosition - height - (positio == 0 ? 20 : 50);
        }

        function makeCactus() {
            isPtarodactyl = false;
            var height = bitmap.getDimensions()[1];
            yPosition = groundYPosition - height;
        }
    }
}