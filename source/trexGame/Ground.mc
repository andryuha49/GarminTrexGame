module TrexGame {
    class Ground {
        hidden const speed = 7;

        hidden var groundYPosition;
        hidden var screenWidth;
        hidden var groundBitmap;
        hidden var step = 0;

        function initialize(pGroundYPosition, pScreenWidth) {
            screenWidth = pScreenWidth;
            groundYPosition = pGroundYPosition - 13;
            groundBitmap = new WatchUi.Bitmap({:rezId=>Rez.Drawables.ground,:locX=>0,:locY=>groundYPosition});
        }

        function draw(dc) {
            groundBitmap.draw(dc);
        }

        function move() {
            var width = groundBitmap.getDimensions()[0];
            if (width < screenWidth + step) {
                step = 0;
            }
            groundBitmap.setLocation(0 - step, groundYPosition);
            step = step + speed;
        }
    }
}