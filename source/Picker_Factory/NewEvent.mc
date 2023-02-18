//
// Copyright 2015-2021 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

import Toybox.Application.Storage;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

//! Picker that allows the user to choose a date
class NewEvent extends WatchUi.Picker {

    //! Constructor
    public function initialize() {
        var months = [$.Rez.Strings.month01, $.Rez.Strings.month02, $.Rez.Strings.month03,
                      $.Rez.Strings.month04, $.Rez.Strings.month05, $.Rez.Strings.month06,
                      $.Rez.Strings.month07, $.Rez.Strings.month08, $.Rez.Strings.month09,
                      $.Rez.Strings.month10, $.Rez.Strings.month11, $.Rez.Strings.month12] as Array<Symbol>;
        var title = new WatchUi.Text({:text=>$.Rez.Strings.datePickerTitle, :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM, :color=>Graphics.COLOR_WHITE});
        var separator = new WatchUi.Text({:text=>$.Rez.Strings.dateSeparator, :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER, :color=>Graphics.COLOR_WHITE});
        Picker.initialize({:title=>title, :pattern=>[new $.WordFactory(months, {}), separator, new $.NewEventFactory(1, 31, 1, {}),
            separator, new $.NewEventFactory(18, 26, 1, {:font=>Graphics.FONT_SYSTEM_NUMBER_MEDIUM})]});

        // if ((Storage.getValue("dateThree") != null)){
        //     WatchUi.pushView(new $.ConfirmationView(), new $.ConfirmationDelegate(), WatchUi.SLIDE_IMMEDIATE);
        // }
    }

    //! Update the view
    //! @param dc Device Context
    public function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}

//! Responds to a date picker selection or cancellation
class NewEventDelegate extends WatchUi.PickerDelegate {

    //! Constructor
    public function initialize() {
        PickerDelegate.initialize();
    }

    //! Handle a cancel event from the picker
    //! @return true if handled, false otherwise
    public function onCancel() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

    //! Handle a confirm event from the picker
    //! @param values The values chosen in the picker
    //! @return true if handled, false otherwise
    public function onAccept(values as Array<Number?>) as Boolean {
        var separator = WatchUi.loadResource($.Rez.Strings.dateSeparator) as String;
        var monthResource = values[0];
        if (monthResource != null) {
            var month = WatchUi.loadResource(monthResource as Symbol) as String;
            var day = values[2];
            var year = "20"+values[4];
            if ((day != null) && (year != null)) {
                var date = month + separator + day + separator + year;
                if (Storage.getValue("dateOne") == null){
                    Storage.setValue("dateOne", date);
                }else if (Storage.getValue("dateTwo") == null){
                    Storage.setValue("dateTwo", date);
                }else if (Storage.getValue("dateThree") == null){
                    Storage.setValue("dateThree", date);
                }
            }    
        }
        WatchUi.pushView(new $.ConfirmationView(), new $.ConfirmationDelegate(), WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
}

// this is example of own exception
// class NoMoreSpace extends Lang.Exception {
//     //! Constructor
//     //! @param msg Message explaining cause
//     function initialize(msg) {
//         Exception.initialize();
//         self.mMessage = msg;
//     }
// }
