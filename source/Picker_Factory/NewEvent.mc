import Toybox.Application.Storage;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.Time;

//! Picker that allows the user to choose a date
class NewEvent extends WatchUi.Picker {

    //! Constructor
    public function initialize() {
        //Storage.setValue("dateOne", null);
        var title = new WatchUi.Text({:text=>$.Rez.Strings.datePickerTitle, :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM, :color=>Graphics.COLOR_WHITE});
        var separator = new WatchUi.Text({:text=>$.Rez.Strings.dateSeparator, :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER, :color=>Graphics.COLOR_WHITE});
        Picker.initialize({:title=>title, :pattern=>[new $.NewEventFactory(1, 12, 1, {}), separator, new $.NewEventFactory(1, 31, 1, {}),
            separator, new $.NewEventFactory(18, 26, 1, {:font=>Graphics.FONT_SYSTEM_NUMBER_MEDIUM})]});
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

    var editparentitem;
    //! Constructor
    public function initialize(editparentitem) {
        PickerDelegate.initialize();
        self.editparentitem = editparentitem;
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
        var month = values[0];
        var day = values[2];
        var options = {
            "yr" => 2000+values[4],
            "mm" => values[0],
            "dd" => values[2]
        };
        var editedoptions = {
            :year => 2000+values[4],
            :month => values[0],
            :day => values[2]
        };
        System.println("this is options:" + editedoptions);
        var editedmoment = Gregorian.moment(editedoptions);
        System.println("editedmoment: " + editedmoment.value()/86400);
        var info = Gregorian.utcInfo(editedmoment, Time.FORMAT_SHORT);
        System.println("info: " + info.day);
        // System.println("this is the input month: " + info.month.format("%02u"));
        if (values[0]<10){
            month = "0" + values[0];
        }
        if (values[2] < 10){
            day = "0" + values[2];
        }
        var year = "20"+values[4];
        var today = new Time.Moment(Time.now().value());
        if ((day != null) && (year != null)) {
            var date = month + separator + day + separator + year;
            var eSelected = Storage.getValue("selectedEvent");
            System.println("in new event, eselected " + eSelected);
            if (eSelected != null){
                Storage.setValue("dateNew", date);
                Storage.setValue(eSelected, options);
                Storage.setValue("glance", options);
                Storage.setValue("selectedEvent", null);
                //-----update item------
                var countedDays = today.subtract(editedmoment).value()/86400;
                if (editedmoment.greaterThan(today)){
                    countedDays = "In " + countedDays.toString() + " days";
                }else{
                    countedDays = countedDays.toString() + " days";
                }
                editparentitem.setLabel(year + "-" + month + "-" + day);
                editparentitem.setSubLabel(countedDays);
                //-----done updateing-------
            }
            else if (Storage.getValue("dateOne") == null){
                Storage.setValue("dateOne", options);
                Storage.setValue("dateNew", date);
            }else if (Storage.getValue("dateTwo") == null){
                Storage.setValue("dateTwo", options);
                Storage.setValue("dateNew", date);
            }else if (Storage.getValue("dateThree") == null){
                Storage.setValue("dateThree", options);
                Storage.setValue("dateNew", date);
            }
        }

        // WatchUi.popView(WatchUi.SLIDE_RIGHT);
        WatchUi.switchToView(new $.ConfirmationView(), new $.ConfirmationDelegate(), WatchUi.SLIDE_IMMEDIATE);
        
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
