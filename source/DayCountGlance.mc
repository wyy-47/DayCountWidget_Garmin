using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.WatchUi;
using Toybox.Graphics;
import Toybox.Application.Storage;

(:glance) class dayCountGlanceView extends WatchUi.GlanceView {

    var options, eMoment, info, gDate, countedDays;
    function initialize(){
        GlanceView.initialize();
    }

    function onShow(){

    }
    
    function onUpdate(dc) {
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    	dc.drawRectangle(0, 0, dc.getWidth(), dc.getHeight());
        if (gDate == null){
            //dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawText (dc.getWidth()/2, dc.getHeight()/2, Graphics.FONT_GLANCE, "Empty", Graphics.TEXT_JUSTIFY_LEFT);
        }else{
            gDate = Storage.getValue("glance");
            System.println(gDate);
            options = {:year => gDate.get("yr"), :month => gDate.get("mm"), :day => gDate.get("dd")};
            System.println(options);
            eMoment = Gregorian.moment(options);
            info = Gregorian.info(eMoment, Time.FORMAT_SHORT);
            gDate = Lang.format("$1$-$2$-$3$", [info.year.format("%04u"),info.month.format("%02u"),info.day.format("%02u")]);
            countedDays = today.subtract(eMoment).value()/86400;
            if (eMoment.greaterThan(today)){
                countedDays = "In " + countedDays.toString() + " days";
            }else{
                countedDays = countedDays.toString() + " days";
            }
            dc.drawText(100, 100, Graphics.FONT_SYSTEM_SMALL, gDate, Graphics.TEXT_JUSTIFY_LEFT);
        }
        
    }
}

class dayCountGlanceViewDelegate extends WatchUi.GlanceViewDelegate{
    function initialize(){
        GlanceViewDelegate.initialize();
    }
}