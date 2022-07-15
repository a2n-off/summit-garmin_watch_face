import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class summitView extends WatchUi.WatchFace {

    var bck;

    function initialize() {
        WatchFace.initialize();
        bck = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.Bck,
            :locX=>0,
            :locY=>0,
        });
    }

    // Load your resources here
    function onLayout(dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc) as Void {
        // get local time, UTC time and UTC date
		var timeNow = Time.now();
		var clockTime = Time.Gregorian.info(timeNow, Time.FORMAT_MEDIUM);
		var dateStr = clockTime.day_of_week.substring(0,3).toUpper() + " " + clockTime.day.format("%02d");

		// clear the screen
		dc.setColor( Graphics.COLOR_TRANSPARENT, Graphics.COLOR_BLACK );
		dc.clear();
        // draw the background
		bck.draw(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
