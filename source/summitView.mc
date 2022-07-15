import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class summitView extends WatchUi.WatchFace {

    var bck; // the background
    var centerX;
	var centerY;

    function initialize() {
        WatchFace.initialize();
        centerX = System.getDeviceSettings().screenWidth/2;
		centerY = System.getDeviceSettings().screenHeight/2;
        bck = new WatchUi.Bitmap({ :rezId=>Rez.Drawables.Bck, :locX=>0, :locY=>0 });
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

        drawHands(dc, clockTime, true);
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


    // 
    // utils function
    // 

    // deg to rad
    function degreesToRadians(deg) {
		return (deg * Math.PI / 180);
	}

    function drawHands(dc, clockTime, drawSecondHandAngle) {
        var hourHand;
        var minuteHand;
        var secondHandAngle;

        // draw the hour. Convert it to minutes and compute the angle.
        hourHand = (((clockTime.hour % 12) * 60) + clockTime.min);
        hourHand = hourHand / (12 * 60.0);
        hourHand = hourHand * Math.PI * 2 - degreesToRadians(90);
        drawHand(dc, hourHand, DeviceOverride.HOUR_HAND_LENGTH, 6, Graphics.COLOR_WHITE);

        // draw the minute
        minuteHand = (clockTime.min / 60.0) * Math.PI * 2 - degreesToRadians(90);
        drawHand(dc, minuteHand, DeviceOverride.MINUTE_HAND_LENGTH, 6, Graphics.COLOR_WHITE);

		// clean up the center
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
		dc.fillCircle(centerX, centerY, 8);
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
		dc.setPenWidth(2);
		dc.drawCircle(centerX, centerY, 8);

        // draw the second hand
        if (drawSecondHandAngle) {
        	secondHandAngle = (clockTime.sec / 60.0) * Math.PI * 2 - degreesToRadians(90);
        	drawHand(dc, secondHandAngle, DeviceOverride.SECOND_HAND_LENGTH, 2, DeviceOverride.SECOND_HAND_COLOR);
			dc.setColor(DeviceOverride.SECOND_HAND_COLOR, Graphics.COLOR_TRANSPARENT);
			for (var i=6; i > 0; i--) {
				dc.drawCircle(centerX, centerY, i);
			}
        }
		dc.setPenWidth(1);
	}

    function drawHand(dc, angle, length, width, color) {
    	var endX = Math.cos(angle) * length;
    	var endY = Math.sin(angle) * length;
    	dc.setColor(color,Graphics.COLOR_TRANSPARENT);
    	dc.setPenWidth(width);
    	dc.drawLine(centerX, centerY, centerX+endX, centerY+endY);
    }

}
