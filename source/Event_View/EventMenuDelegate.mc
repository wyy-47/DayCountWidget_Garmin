import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Application.Storage;

//! This is the menu input delegate for the main menu of the application
class EventMenuDelegate extends WatchUi.Menu2InputDelegate {

    //! Constructor
    public function initialize() {
        Menu2InputDelegate.initialize();
    }

    public function onSelect(item as MenuItem) as Void {
        var id = item.getId() as String;
        if (id.equals("edit")){
            System.println("edit selected");
            WatchUi.pushView(new $.NewEvent(), new $.NewEventDelegate(), WatchUi.SLIDE_UP);
        }else if (id.equals("delete")){
            System.println("delete selected");
            WatchUi.pushView(new $.DeleteView(), new $.DeleteDelegate(), WatchUi.SLIDE_UP);
        } else if (id.equals("info")){
            System.println("infoPage selected");
            WatchUi.pushView(new $.InfoView(), new $.InfoDelegate(), WatchUi.SLIDE_UP);
        } else if (id.equals("glance")){
            var location = Storage.getValue("selectedEvent");
            var gDate = Storage.getValue(location);
            Storage.setValue("glance", gDate);
            System.println("glanced selected: " + Storage.getValue("glance"));
        }
    }

    //! Handle the back key being pressed
    public function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }
}