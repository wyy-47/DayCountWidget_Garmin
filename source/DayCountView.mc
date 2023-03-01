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
            var mm, dd, yr, eMoment, countedDays;
            var leftOver, i, options;

            if(sub1 == null){
                sub1 = "Empty";
                countedDays1 = null;
            }else{
                i = sub1.find("-");
                mm = sub1.substring(0, i).toLongWithBase(10).toNumber();
                leftOver = sub1.substring(i+1, sub1.length());
                i = leftOver.find("-");
                dd = leftOver.substring(0, i).toLongWithBase(10).toNumber();
                yr = leftOver.substring(i+1, sub1.length()).toLongWithBase(10).toNumber();
                options = {:year => yr, :month => mm, :day => dd};
                System.println(options);
                eMoment = Gregorian.moment(options);
                // var info1 = Gregorian.info(mom1, Time.FORMAT_SHORT);
                countedDays = today.subtract(eMoment).value()/86400;
                Storage.setValue("cDays1", countedDays);
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
                i = sub2.find("-");
                mm = sub2.substring(0, i).toLongWithBase(10).toNumber();
                leftOver = sub2.substring(i+1, sub2.length());
                i = leftOver.find("-");
                dd = leftOver.substring(0, i).toLongWithBase(10).toNumber();
                yr = leftOver.substring(i+1, sub2.length()).toLongWithBase(10).toNumber();
                options = {:year => yr, :month => mm, :day => dd};
                System.println(options);
                eMoment = Gregorian.moment(options);
                countedDays = today.subtract(eMoment).value()/86400;
                Storage.setValue("cDays2", countedDays);
                if (eMoment.greaterThan(today)){
                    countedDays2 = "In " + countedDays.toString() + " days";
                }else{
                    countedDays2 = countedDays.toString() + " days";
                }

                System.println("this is the subtraction2: " + countedDays1);
            }

            if(sub3 == null){
                sub3 = "Empty";
                countedDays3 = null;
            }else{
                i = sub3.find("-");
                mm = sub3.substring(0, i).toLongWithBase(10).toNumber();
                leftOver = sub3.substring(i+1, sub3.length());
                i = leftOver.find("-");
                dd = leftOver.substring(0, i).toLongWithBase(10).toNumber();
                yr = leftOver.substring(i+1, sub3.length()).toLongWithBase(10).toNumber();
                options = {:year => yr, :month => mm, :day => dd};
                System.println(options);
                eMoment = Gregorian.moment(options);
                countedDays = today.subtract(eMoment).value()/86400;
                Storage.setValue("cDays3", countedDays);
                if (eMoment.greaterThan(today)){
                    countedDays3 = "In " + countedDays.toString() + " days";
                }else{
                    countedDays3 = countedDays.toString() + " days";
                }

                System.println("this is the subtraction3: " + countedDays1);
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
