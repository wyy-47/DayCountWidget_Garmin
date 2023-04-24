import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Application.Storage;

//! This is the menu input delegate for the main menu of the application
class EventMenuDelegate extends WatchUi.Menu2InputDelegate {

    //parent var
    var parentmenu, parentmenuid, thismenu;
    //! Constructor
    function initialize(parentmenu, parentmenuid, thismenu) {
        Menu2InputDelegate.initialize();
        self.parentmenu = parentmenu;
        self.parentmenuid = parentmenuid;
        self.thismenu = thismenu;
    }

    public function onSelect(item as MenuItem) as Void {
        var id = item.getId() as String;
        if (id.equals("edit")){
            System.println("edit selected");
            WatchUi.pushView(new $.NewEvent(), new $.NewEventDelegate(thismenu), WatchUi.SLIDE_UP);
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

        //update the prev. menu
        var parentidx = parentmenu.findItemById(parentmenuid);
        var parentitem = parentmenu.getItem(parentidx);
        
        if(parentitem){
            System.println("in eventmenudelegate, i dont understand" + parentitem);
        }
       
    }

    // ! Handle the back key being pressed
    public function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        System.println("back press detected");
    }
}
