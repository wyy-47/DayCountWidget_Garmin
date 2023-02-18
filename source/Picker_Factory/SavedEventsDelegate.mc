import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

//! This is the menu input delegate for the main menu of the application
class SavedEventsDelegate extends WatchUi.Menu2InputDelegate {

    //! Constructor
    public function initialize() {
        Menu2InputDelegate.initialize();
    }

    public function onSelect(item as MenuItem) as Void {
        var id = item.getId() as String;
        if (id.equals("e1")){
            System.println("event 1 selected");
            WatchUi.pushView(new $.Event1View(), new $.Event1Delegate(), WatchUi.SLIDE_UP);
        }
        else if (id.equals("e2")){
            System.println("event 2 selected");
        }
        else if (id.equals("e2")){
            System.println("event 3 selected");
        }
    }

    //! Handle the back key being pressed
    public function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }
}
