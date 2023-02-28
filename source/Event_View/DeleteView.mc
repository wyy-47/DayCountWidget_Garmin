import Toybox.Application.Storage;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

class DeleteView extends WatchUi.View{
    function initialize(){
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.LayoutDelete(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    
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
class DeleteDelegate extends WatchUi.BehaviorDelegate {

    //! Constructor
    public function initialize() {
        BehaviorDelegate.initialize();
    }

    //! Handle a button being pressed and released
    //! @param evt The key event that occurred
    //! @return true if handled, false otherwise
    public function onKey(evt as KeyEvent) as Boolean {
        var key = evt.getKey();
        if (WatchUi.KEY_ENTER == key) {
            var location = Storage.getValue("selectedEvent");
            Storage.setValue(location, null);
            return pushPicker();
        } else if (WatchUi.KEY_ESC == key){
            WatchUi.popView(SLIDE_RIGHT);
        }
        return false;
    }

    //! Push a new picker view
    //! @return true if handled, false otherwise
    public function pushPicker() as Boolean {
        System.println(Storage.getValue("dateOne"));
        var sub1 = Storage.getValue("dateOne");
        var sub2 = Storage.getValue("dateTwo");
        var sub3 = Storage.getValue("dateThree");
        var menu = new WatchUi.Menu2({:title=>"Saved Events"});
        // Add menu items for demonstrating toggles, checkbox and icon menu items
        menu.addItem(new WatchUi.MenuItem(sub1, days.toString(), "e1", null));
        menu.addItem(new WatchUi.MenuItem("Event 2", sub2, "e2", null));
        menu.addItem(new WatchUi.MenuItem("Event 3", sub3, "e3", null));
            //menu.addItem(new WatchUi.MenuItem(testYear, null, null, null));
        WatchUi.pushView(menu, new $.SavedEventsDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}