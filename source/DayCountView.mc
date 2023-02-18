import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Application.Storage;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;

class DayCountView extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    public function onMenuItem(item as Symbol) as Void {
        if (item == :Item1) {
            System.println("Item 1");
            var sub1 = Storage.getValue("dateOne");
            var sub2 = Storage.getValue("dateTwo");
            var sub3 = Storage.getValue("dateThree");
            var menu = new WatchUi.Menu2({:title=>"Saved Events"});
            // Add menu items for demonstrating toggles, checkbox and icon menu items
            menu.addItem(new WatchUi.MenuItem("Event 1", sub1, "e1", null));
            menu.addItem(new WatchUi.MenuItem("Event 2", sub2, "e2", null));
            menu.addItem(new WatchUi.MenuItem("Event 3", sub3, "e3", null));
            WatchUi.pushView(menu, new $.SavedEventsDelegate(), WatchUi.SLIDE_UP);
        } 
        else if (item == :Item2) {
            Storage.setValue("dateTwo", null);
            System.println("Item 2");
            if ((Storage.getValue("dateOne") != null)&&(Storage.getValue("dateTwo") != null)&&(Storage.getValue("dateThree") != null)){
                WatchUi.pushView(new $.SpaceFull(), new $.SpaceFullDelegate(), WatchUi.SLIDE_UP);
            }else{
                WatchUi.pushView(new $.NewEvent(), new $.NewEventDelegate(), WatchUi.SLIDE_UP);
            }
        }
    }
}
