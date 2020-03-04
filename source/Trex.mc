
class Trex extends GameCharacter {
    hidden const trexHeight = 47;
    hidden const trexJumpSpeed = 0.7;
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
        var jumpSpeed = 5.5;
        if (isJumping == true) {
            if (isJumpingUp == true) {
                var y = yPosition - jumpSpeed;
                if (y > topJumpPosition) {
                    yPosition = y;
                } else {
                    isJumpingUp = false;
                    isJumpingDown = true;
                }
            } else {
                var y = yPosition + jumpSpeed;
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
        //WatchUi.animate( bitmap, :locY, WatchUi.ANIM_TYPE_LINEAR, defaultYPosition, topJumpPosition, trexJumpSpeed, method(:makeJumpDownAnimation) );
    }

    function makeJumpDownAnimation() {
        //WatchUi.animate( bitmap, :locY, WatchUi.ANIM_TYPE_LINEAR, topJumpPosition, defaultYPosition, trexJumpSpeed, method(:doneJumping) );
    }

    function doneJumping() {
        //isJumping = false;
    }
}