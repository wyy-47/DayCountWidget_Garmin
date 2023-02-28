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
            System.println("this is today: " + today);

            var sub1 = Storage.getValue("dateOne");
            var sub2 = Storage.getValue("dateTwo");
            var sub3 = Storage.getValue("dateThree");
            var countedDays1;
            var countedDays2;
            var countedDays3;

            if(sub1 == null){
                sub1 = "Empty";
                countedDays1 = null;
            }else{
                var i = sub1.find("-");
                var month1 = sub1.substring(0, i).toLongWithBase(10).toNumber();
                var tRest = sub1.substring(i+1, sub1.length());
                i = tRest.find("-");
                var day1 = tRest.substring(0, i).toLongWithBase(10).toNumber();
                var year1 = tRest.substring(i+1, sub1.length()).toLongWithBase(10).toNumber();
                var options1 = {:year => year1, :month => month1, :day => day1};
                System.println(options1);
                var mom1 = Gregorian.moment(options1);
                var info1 = Gregorian.info(mom1, Time.FORMAT_SHORT);
                countedDays1 = today.subtract(mom1).value();
                countedDays1 = (days/86400).toString();

                System.println("this is the subtraction: " + countedDays1);
                System.println(format("$1$-$2$-$3$", [
                    info1.year.format("%04u"),
                    info1.month.format("%02u"),
                    info1.day.format("%02u")
                ]));
            }

            var menu = new WatchUi.Menu2({:title=>"Saved Events"});
            // Add menu items for demonstrating toggles, checkbox and icon menu items
            menu.addItem(new WatchUi.MenuItem(sub1, countedDays1, "e1", null));
            menu.addItem(new WatchUi.MenuItem("Event 2", sub2, "e2", null));
            menu.addItem(new WatchUi.MenuItem("Event 3", sub3, "e3", null));
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

    public function onKey(evt as KeyEvent) as Boolean {
        var key = evt.getKey();
        if (WatchUi.KEY_ESC == key) {
            System.println("on main page exit");
            return System.exit();
        }
        return false;
    }
}
