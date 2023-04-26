import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Application.Storage;

//! This is the menu input delegate for the main menu of the application
class EventMenuDelegate extends WatchUi.Menu2InputDelegate {

    //parent var
    var parentmenu, parentmenuid;
    //! Constructor
    function initialize(parentmenu, parentmenuid) {
        Menu2InputDelegate.initialize();
        self.parentmenu = parentmenu;
        self.parentmenuid = parentmenuid;
    }

    public function onSelect(item as MenuItem) as Void {
        var parentidx = parentmenu.findItemById(parentmenuid);
        var parentitem = parentmenu.getItem(parentidx);
        var message, dialog;
        var id = item.getId() as String;
        if (id.equals("edit")){
            System.println("edit selected");
            WatchUi.pushView(new $.NewEvent(), new $.NewEventDelegate(parentitem), WatchUi.SLIDE_UP);
        }else if (id.equals("delete")){
            message = "Delete?";
            dialog = new WatchUi.Confirmation(message);
            WatchUi.pushView(dialog, new McConfirmationDelegate(parentitem),WatchUi.SLIDE_IMMEDIATE);
        } else if (id.equals("info")){
            System.println("infoPage selected");
            WatchUi.pushView(new $.InfoView(), new $.InfoDelegate(), WatchUi.SLIDE_UP);
        } else if (id.equals("glance")){
            message = "Set Glance?";
            System.println("seleted glance");
            dialog = new WatchUi.Confirmation(message);
            WatchUi.pushView(dialog, new McConfirmationDelegate(null),WatchUi.SLIDE_IMMEDIATE);
        }
    }

    // ! Handle the back key being pressed
    public function onBack() as Void {
        Storage.setValue("selectedEvent", null);
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        // WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}
