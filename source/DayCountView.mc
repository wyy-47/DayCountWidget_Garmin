import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Application.Storage;
import Toybox.Lang;
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
            var today = new Time.Moment(Time.today().value());

            var sub1 = Storage.getValue("dateOne");
            var sub2 = Storage.getValue("dateTwo");
            var sub3 = Storage.getValue("dateThree");
            var countedDays1, countedDays2, countedDays3;
            var eMoment, countedDays, info, options;

            if(sub1 == null){
                sub1 = "Empty";
                countedDays1 = null;
            }else{
                options = {:year => sub1.get("yr"), :month => sub1.get("mm"), :day => sub1.get("dd")};
                System.println(options);
                eMoment = Gregorian.moment(options);
                info = Gregorian.info(eMoment, Time.FORMAT_SHORT);
                sub1 = Lang.format("$1$-$2$-$3$", [info.year.format("%04u"),info.month.format("%02u"),info.day.format("%02u")]);
                countedDays = today.subtract(eMoment).value()/86400;
                if (eMoment.greaterThan(today)){
                    countedDays1 = "In " + countedDays.toString() + " days";
                }else{
                    countedDays1 = countedDays.toString() + " days";
                }

                System.println("this is the subtraction1: " + countedDays1);
            }

            if(sub2 == null){
                sub2 = "Empty";
                countedDays2 = null;
            }else{
                options = {:year => sub2.get("yr"), :month => sub2.get("mm"), :day => sub2.get("dd")};
                System.println(options);
                eMoment = Gregorian.moment(options);
                info = Gregorian.info(eMoment, Time.FORMAT_SHORT);
                sub2 = Lang.format("$1$-$2$-$3$", [info.year.format("%04u"),info.month.format("%02u"),info.day.format("%02u")]);
                countedDays = today.subtract(eMoment).value()/86400;
                if (eMoment.greaterThan(today)){
                    countedDays2 = "In " + countedDays.toString() + " days";
                }else{
                    countedDays2 = countedDays.toString() + " days";
                }

                System.println("this is the subtraction2: " + countedDays2);
            }

            if(sub3 == null){
                sub3 = "Empty";
                countedDays3 = null;
            }else{
                options = {:year => sub3.get("yr"), :month => sub3.get("mm"), :day => sub3.get("dd")};
                System.println(options);
                eMoment = Gregorian.moment(options);
                info = Gregorian.info(eMoment, Time.FORMAT_SHORT);
                sub3 = Lang.format("$1$-$2$-$3$", [info.year.format("%04u"),info.month.format("%02u"),info.day.format("%02u")]);
                countedDays = today.subtract(eMoment).value()/86400;
                if (eMoment.greaterThan(today)){
                    countedDays3 = "In " + countedDays.toString() + " days";
                }else{
                    countedDays3 = countedDays.toString() + " days";
                }
                
                System.println("this is the subtraction3: " + countedDays3);
            }

            var menu = new WatchUi.Menu2({:title=>"Saved Events"});
            // Add menu items for demonstrating toggles, checkbox and icon menu items
            menu.addItem(new WatchUi.MenuItem(sub1, countedDays1, "e1", null));
            menu.addItem(new WatchUi.MenuItem(sub2, countedDays2, "e2", null));
            menu.addItem(new WatchUi.MenuItem(sub3, countedDays3, "e3", null));
            //menu.addItem(new WatchUi.MenuItem(testYear, null, null, null));
            WatchUi.pushView(menu, new $.SavedEventsDelegate(), WatchUi.SLIDE_UP);
        } 
        else if (item == :Item2) {
            System.println("Item 2");
            if ((Storage.getValue("dateOne") != null)&&(Storage.getValue("dateTwo") != null)&&(Storage.getValue("dateThree") != null)){
                WatchUi.pushView(new $.SpaceFull(), new $.SpaceFullDelegate(), WatchUi.SLIDE_UP);
            }else{
                WatchUi.pushView(new $.NewEvent(), new $.NewEventDelegate(), WatchUi.SLIDE_UP);
            }
        }
    }

    function onKey(keyEvent) {
        System.println(keyEvent.getKey()); // e.g. KEY_MENU = 7
        return true;
    }
}
