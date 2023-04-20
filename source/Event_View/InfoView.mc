import Toybox.Application.Storage;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
using Toybox.Math;
using Toybox.Time;
using Toybox.Time.Gregorian;

class InfoView extends WatchUi.View{
    var today, countedDays, todayDetail;
    
    function initialize(){
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.LayoutSelected(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        var selected = Storage.getValue("selectedEvent");
        var prop, propD, options, eMoment;
        var info = "";
        var date = findDrawableById("selectedEvent") as Text;
        var days = findDrawableById("infoDays") as Text;
        if (Storage.getValue(selected) != null){
            today = new Time.Moment(Time.today().value());
            prop = Storage.getValue(selected); 
            options = {:year => prop.get("yr"), :month => prop.get("mm"), :day => prop.get("dd")};
            System.println(options);
            eMoment = Gregorian.moment(options);
            info = Gregorian.utcInfo(eMoment, Time.FORMAT_SHORT);
            prop = Lang.format("$1$-$2$-$3$", [info.year.format("%04u"),info.month.format("%02u"),info.day.format("%02u")]);
            countedDays = today.subtract(eMoment).value()/86400;
            if (eMoment.greaterThan(today)){
                propD = "In " + countedDays.toString() + " days";
            }else{
                propD = countedDays.toString() + " days";
            }
        }else{
            prop = "Empty";
            propD = "";
        }
        days.setText(propD);
        date.setText(prop);

        var mm, yrs, rest, tmm, tyr;
        todayDetail = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        System.println("this is in info checking today.year outside of if: " + todayDetail.year);
        tyr = todayDetail.year;
        tmm = todayDetail.month;
        yrs = info.year;
        mm = info.month;

        //!!!thoughts!!! with GPT: while current_year < end_date.year or current_month <= end_date.month
        // then find days in each month, by using the end date of month minus the 1 day of month
        // and compare that with today's day in month 
        // works but too much memory (24kb)
        // var curmonth, opttest2, daycount, dummyyr, dummymm, dummy;
        // var monthcount = 0;
        // if ((yrs < tyr) or (mm <= tmm)){
        //     while ((yrs < tyr) or (mm <= tmm)){
        //         dummyyr = yrs + 1;
        //         dummymm = mm + 2;
        //         if (mm == 12){
        //             yrs = yrs + 1;
        //             dummyyr = yrs + 1;
        //             mm = 0;
        //             dummymm = 2;
        //         } else if (mm == 11){
        //             dummyyr = yrs + 1;
        //             dummymm = 1;
        //         }
        //         curmonth = {:year => yrs, :month => mm+1, :day => 1};
        //         System.println("infoview, call dic: " + curmonth[:month]);
        //         opttest2 = {:year => dummyyr, :month => dummymm, :day => 1};
        //         var testmon1 = Gregorian.moment(curmonth);
        //         var testmon2 = Gregorian.moment(opttest2);
        //         System.println("in infoview, month value: " + testmon1.subtract(testmon2).value()/86400); //obj: 202
        //         // System.println("infoview, call dic: " + curmonth[:month]);
        //         monthcount += 1;
        //         mm += 1;
        //         System.println("infoview, monthcount: " + monthcount);
        //     }
        // }
            

        // // another ways of counting attempt
        // if (((tyr-yrs)>1) && (todayDetail.month-info.month)<0){
        //     System.println((todayDetail.year - info.year));
        // }

        //another attempt assuming a month is 30 days
        // if ((countedDays > 30) && (countedDays < 365)){
        //     mm = Math.floor(countedDays/30) + "months" + (countedDays%30) + "days";
        //     System.println("this is new attempt months: " + mm);
        // }
        // else if (countedDays > 365){
        //     var dummy;
        //     dummy = Math.floor(countedDays/365);
        //     yr = dummy + "years" + Math.floor((countedDays-dummy*365)/30) + "months" + (countedDays%30) + "days";
        //     System.println("this is new attempt yrs: " + yr);
        // }

        // if(countedDays > 7){
        //     weeks = Math.floor(countedDays / 7) + " weeks " + (countedDays%7) + "days";
        //     System.println("this is attempted weeks: " + weeks);
        //     if(countedDays > 30){
        //         months = Math.floor(countedDays/30);
        //         rest = countedDays - months*30;
        //         weeks = Math.floor(rest/7) + "weeks" + (rest%7) + "days";
        //         System.println(months + weeks);
        //     }
        // } 
         
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }
}

//! Input handler for the main view
class InfoDelegate extends WatchUi.BehaviorDelegate {

    //! Constructor
    public function initialize() {
        BehaviorDelegate.initialize();
    }

    //! Handle a button being pressed and released
    //! @param evt The key event that occurred
    //! @return true if handled, false otherwise
    public function onKey(evt as KeyEvent) as Boolean {
        var key = evt.getKey();
        if (WatchUi.KEY_ESC == key) {
            return pushPicker();
        }
        return false;
    }

    //! Push a new picker view
    //! @return true if handled, false otherwise
    public function pushPicker() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

}