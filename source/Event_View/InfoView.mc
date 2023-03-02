import Toybox.Application.Storage;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
using Toybox.Math;
using Toybox.Time.Gregorian;

class InfoView extends WatchUi.View{
    function initialize(){
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.LayoutSelected(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        var selected = Storage.getValue("selectedEvent");
        var date, prop, options, eMoment, info;
        var dSelected = 0;
        date = findDrawableById("selectedEvent") as Text;
        if (Storage.getValue(selected) != null){
            prop = Storage.getValue(selected); 
            options = {:year => prop.get("yr"), :month => prop.get("mm"), :day => prop.get("dd")};
            System.println(options);
            eMoment = Gregorian.moment(options);
            info = Gregorian.info(eMoment, Time.FORMAT_SHORT);
            prop = Lang.format("$1$-$2$-$3$", [info.year.format("%04u"),info.month.format("%02u"),info.day.format("%02u")]);
        }else{
            prop = "Empty";
        }
        date.setText(prop);
        date.setColor(Graphics.COLOR_WHITE);
        
        if(selected.equals("dateOne")){
            dSelected = Storage.getValue("cDays1");
        } else if(selected.equals("dateTwo")){
            dSelected = Storage.getValue("cDays2");
        } else if(selected.equals("dateThree")){
            dSelected = Storage.getValue("cDays3");
        }

        var weeks, months, yrs;

        if(dSelected > 7){
            weeks = Math.floor(dSelected / 7) + " weeks " + (dSelected%7) + "days";
            System.println("this is attempted weeks: " + weeks);
        } 

    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }
}

//! Input handler for the main view
class InfoDelegate extends WatchUi.BehaviorDelegate {

    //! Constructor
    public function initialize() {
        BehaviorDelegate.initialize();
    }

    //! Handle a button being pressed and released
    //! @param evt The key event that occurred
    //! @return true if handled, false otherwise
    public function onKey(evt as KeyEvent) as Boolean {
        var key = evt.getKey();
        if (WatchUi.KEY_ESC == key) {
            return pushPicker();
        }
        return false;
    }

    //! Push a new picker view
    //! @return true if handled, false otherwise
    public function pushPicker() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

}