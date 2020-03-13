module TrexGame {
    class Trex extends GameCharacter {
        hidden const trexHeight = 47;
        hidden const trexXPosition = 5;

        hidden var trexLeftLegUpBitmap;
        hidden var trexRightLegUpBitmap;

        hidden var isJumping = false;
        hidden var isJumpingUp = false;
        hidden var isJumpingDown = false;

        hidden var isLeftLegUp = null;
        hidden var isBumped = false;

        hidden var topJumpPosition;
        hidden var defaultYPosition;

        function initialize(groundYPosition) {
            defaultYPosition = groundYPosition - trexHeight;
            topJumpPosition = defaultYPosition - trexHeight * 1.7;

            GameCharacter.initialize(Rez.Drawables.dino, trexXPosition, defaultYPosition);
        }

        function draw(dc) {
            if (isBumped == true) {
                bitmap.setBitmap(Rez.Drawables.dinoBump);
            } else if (isJumping) {
                bitmap.setBitmap(Rez.Drawables.dino);
            } else {
                if (isLeftLegUp == null) {
                    bitmap.setBitmap(Rez.Drawables.dino);
                } else if (isLeftLegUp == true) {
                    //isLeftLegUp = false;
                    bitmap.setBitmap(Rez.Drawables.dinoLeftLegUp);
                } else {
                    //isLeftLegUp = true;
                    bitmap.setBitmap(Rez.Drawables.dinoRightLegUp);
                }
            }
            bitmap.draw(dc);
        }

        function move() {
            if (isJumping == true) {
                if (isJumpingUp == true) {
                    var y = yPosition - Constants.PIXELS_SPEED;
                    if (y > topJumpPosition) {
                        yPosition = y;
                    } else {
                        isJumpingUp = false;
                        isJumpingDown = true;
                    }
                } else {
                    var y = yPosition + Constants.PIXELS_SPEED;
                    if (y < defaultYPosition) {
                        yPosition = y;
                    } else {
                        yPosition = defaultYPosition;
                        isJumping = false;
                    }
                }
            } else {
                if (isLeftLegUp == true) {
                    isLeftLegUp = false;
                } else {
                    isLeftLegUp = true;
                }
            }
            bitmap.setLocation(xPosition, yPosition);
        }

        function jump() {
            isBumped = false;
            makeJumpAnimation();
        }

        function bump() {
            isBumped = true;
        }

        hidden function makeJumpAnimation() {
            if (isJumping != true) {
                isJumping = true;
                makeJumpUpAnimation();
            }
        }

        function makeJumpUpAnimation() {
            isJumpingUp = true;
            isJumpingDown = false;
        }
    }
}
