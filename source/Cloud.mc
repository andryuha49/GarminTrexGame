class Cloud {
    hidden var cloudBitmap;
    hidden var cloudYPosition = 30;
    hidden var screenWidth;
    hidden var step = 0;

    function initialize(pScreenWidth) {
        screenWidth = pScreenWidth;

        cloudBitmap = new WatchUi.Bitmap({:rezId=>Rez.Drawables.cloud,:locX=>pScreenWidth,:locY=>cloudYPosition});
    }

    function draw(dc) {
        cloudBitmap.draw(dc);
    }

    function move() {
        var width = cloudBitmap.getDimensions()[0];
        if (step - width > screenWidth) {
            makeNewCloud();
        }

        cloudBitmap.setLocation(screenWidth - step, cloudYPosition);
        step = step + 0.5;
    }

    hidden function makeNewCloud() {
        step = 0;
        var r = Math.rand() % 2;
        cloudYPosition = r == 0 ? 20 : 30;
    }
}