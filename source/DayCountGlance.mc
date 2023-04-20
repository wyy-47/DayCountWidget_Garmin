using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.WatchUi;
using Toybox.Graphics;
import Toybox.Application.Storage;

(:glance) 
class dayCountGlanceView extends WatchUi.GlanceView {

    function initialize(){
        GlanceView.initialize();
    }

    function onLayout(dc as Dc) as Void {

    }

    function onShow(){
    }
    
    function onUpdate(dc) {
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    	//dc.drawRectangle(0, 0, dc.getWidth(), dc.getHeight());
        var options, eMoment, info, gDate, countedDays;
        var today = new Time.Moment(Time.today().value());
        var dy = dc.getFontHeight(Graphics.FONT_TINY);
        var dw = dc.getWidth();
        var dh = dc.getHeight();
        gDate = Storage.getValue("glance");
        if (gDate == null){
            System.println("this is glance dc width: " + dc.getWidth());
            System.println("this is glance : " );
            dc.drawText (dw/2, dh/2-(dy/2), Graphics.FONT_TINY, "Empty", Graphics.TEXT_JUSTIFY_CENTER);
        }else{
            System.println(dy);
            options = {:year => gDate.get("yr"), :month => gDate.get("mm"), :day => gDate.get("dd")};
            eMoment = Gregorian.moment(options);
            info = Gregorian.utcInfo(eMoment, Time.FORMAT_SHORT);
            gDate = Lang.format("$1$-$2$-$3$", [info.year.format("%04u"),info.month.format("%02u"),info.day.format("%02u")]);
            countedDays = today.subtract(eMoment).value()/86400;
            if (eMoment.greaterThan(today)){
                countedDays = "In " + countedDays.toString() + " days";
            }else{
                countedDays = countedDays.toString() + " days";
            }
            dc.drawText(dc.getWidth()/2, dy/4, Graphics.FONT_TINY, gDate, Graphics.TEXT_JUSTIFY_CENTER);
            dc.drawText(dc.getWidth()/2, dh/2, Graphics.FONT_TINY, countedDays, Graphics.TEXT_JUSTIFY_CENTER);
        }
    }
}

class dayCountGlanceViewDelegate extends WatchUi.GlanceViewDelegate{
    function initialize(){
        GlanceViewDelegate.initialize();
    }
}