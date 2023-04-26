using Toybox.WatchUi;
using Toybox.System;
import Toybox.Application.Storage;

class McConfirmationDelegate extends WatchUi.ConfirmationDelegate {
    var parentitem;
    function initialize(parentitem) {
        ConfirmationDelegate.initialize();
        self.parentitem = parentitem;
        System.println("mc confirm parent item " + parentitem);
    }

    function onResponse(response) {
        if (response == WatchUi.CONFIRM_NO) {
            System.println("Cancel");
        } else {
            var location = Storage.getValue("selectedEvent");
            if (parentitem != null){
                System.println("the parent id is delete");
                Storage.setValue(location, null);
                parentitem.setLabel("Empty");
                parentitem.setSubLabel(null);
                System.println("this is in delete: " + location);
            }else{
                var gDate = Storage.getValue(location);
                Storage.setValue("glance", gDate);
                System.println("glanced selected: " + Storage.getValue("glance"));
            }
        }
    }
}