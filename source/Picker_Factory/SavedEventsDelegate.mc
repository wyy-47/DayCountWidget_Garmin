import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Application.Storage;

//! This is the menu input delegate for the main menu of the application
class SavedEventsDelegate extends WatchUi.Menu2InputDelegate {
    var parentmainmenu;
    //! Constructor
    public function initialize(parentmainmenu) {
        Menu2InputDelegate.initialize();
        self.parentmainmenu = parentmainmenu;
    }

    public function onSelect(item as MenuItem) as Void {
        var id = item.getId() as String;
        var menu = new WatchUi.Menu2({:title=>"Actions"});
        // Add menu items for demonstrating toggles, checkbox and icon menu items
        menu.addItem(new WatchUi.MenuItem("Info", null, "info", null));
        menu.addItem(new WatchUi.MenuItem("Set Glance", null, "glance", null));
        menu.addItem(new WatchUi.MenuItem("Edit", null, "edit", null));
        menu.addItem(new WatchUi.MenuItem("Delete", null, "delete", null));
        if (id.equals("e1")){
            System.println("event 1 selected");
            Storage.setValue("selectedEvent", "dateOne");
            WatchUi.pushView(menu, new $.EventMenuDelegate(parentmainmenu, "e1", menu), WatchUi.SLIDE_UP);
        }
        else if (id.equals("e2")){
            Storage.setValue("selectedEvent", "dateTwo");
            System.println("event 2 selected");
            WatchUi.pushView(menu, new $.EventMenuDelegate(), WatchUi.SLIDE_UP);
        }
        else if (id.equals("e3")){
            Storage.setValue("selectedEvent", "dateThree");
            System.println("event 3 selected");
            WatchUi.pushView(menu, new $.EventMenuDelegate(), WatchUi.SLIDE_UP);
        }
    }

    //! Handle the back key being pressed
    public function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }
}
