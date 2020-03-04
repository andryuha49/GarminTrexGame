using Toybox.WatchUi;

class GarminTrexGameAboutView extends WatchUi.View {
    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.AboutLayout(dc));
    }
}