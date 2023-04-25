import Toybox.Application.Storage;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

class ConfirmationView extends WatchUi.View{
    function initialize(){
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.LayoutDateNew(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        var date = findDrawableById("dateNew") as Text;
        var prop = Storage.getValue("dateNew");
        //date.setText(prop);
        if (prop instanceof String) {
            date.setText(prop);
            date.setColor(Graphics.COLOR_WHITE);
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
class ConfirmationDelegate extends WatchUi.BehaviorDelegate {

    //! Constructor
    public function initialize() {
        BehaviorDelegate.initialize();
    }

    //! Handle a button being pressed and released
    //! @param evt The key event that occurred
    //! @return true if handled, false otherwise
    public function onKey(evt as KeyEvent) as Boolean {
        var key = evt.getKey();
        if ((WatchUi.KEY_ESC == key) || (WatchUi.KEY_ENTER == key)) {
            return pushPicker();
        }
        return false;
    }

    //! Push a new picker view
    //! @return true if handled, false otherwise
    public function pushPicker() as Boolean {
        // if (editmenu!=null){
        //     WatchUi.popView(WatchUi.SLIDE_UP);
        //     // WatchUi.pushView(editmenu, new $.EventMenuDelegate(null, null, null, true), WatchUi.SLIDE_UP);
        //     //if this workd, pass in the new date and return the event id or bool to indicate the event needed update
        // }
        // else{
        //     // WatchUi.switchToView(new $.Rez.Menus.MainMenu(), new DayCountView(), SLIDE_IMMEDIATE);
        //     WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        // }
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        // WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        // WatchUi.pushView(new $.Rez.Menus.MainMenu(), new DayCountView(), SLIDE_IMMEDIATE);
        return true;
    }

}