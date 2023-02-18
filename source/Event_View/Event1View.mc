import Toybox.WatchUi;
import Toybox.Application.Storage;
import Toybox.System;

class Event1View extends WatchUi.View{
    function initialize(){
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.LayoutE1(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        var date = findDrawableById("dateThree") as Text;
       
        var prop = Storage.getValue("dateThree");
        System.println(prop);
        //date.setText(prop);
        if (prop instanceof String) {
            System.println("instance of");
            date.setText(prop);
            date.setColor(Graphics.COLOR_WHITE);
        }
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.clear();

        dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Graphics.FONT_SMALL, "Saved!", Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }
}