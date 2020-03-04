class GameCharacter {
    var bitmap;
    var xPosition = 0;
    var yPosition = 0;

    function initialize(rezId, locX, locY) {
        xPosition = locX;
        yPosition = locY;
        bitmap = new WatchUi.Bitmap({:rezId=>rezId,:locX=>locX,:locY=>locY});
    }

    function getDimensions() {
        return bitmap.getDimensions();
    }

    function getX() {
        return xPosition;
    }

    function getY() {
        return yPosition;
    }
}