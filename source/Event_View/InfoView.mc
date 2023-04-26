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
        var prop, propD, options, eMoment, propDtM;
        var infuture = false;
        var info = "";
        var date = findDrawableById("selectedEvent") as Text;
        var days = findDrawableById("infoDays") as Text;
        var dToMon = findDrawableById("daysToMonth") as TextArea;
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
                infuture = true;
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

        var resultyr = 0;
        var resultmonth = 0;

        if (countedDays < 31){
            if (countedDays > 28 and mm == 2){
            countedDays -= 28;
            resultmonth += 1;
            }
        }
        else{
            // shows 10 month and -20 days
            if(infuture){
                tyr = info.year;
                tmm = info.month-1;
                yrs = todayDetail.year;
                mm = todayDetail.month;
            }
            while ((yrs < tyr) or (mm < tmm)){
                if (mm ==12){
                    countedDays -= 31;
                    resultmonth += 1;
                    mm = 1;
                    yrs += 1;
                }
                else if (mm == 1 or mm ==3 or mm ==5 or mm ==7 or mm ==8 or mm ==10){
                    countedDays -= 31;
                    resultmonth += 1;
                    mm += 1;
                }
                else if (mm == 2){
                    countedDays -= 28;
                    resultmonth += 1;
                    mm += 1;
                }
                else{
                    countedDays -= 30;
                    resultmonth += 1;
                    mm += 1;
                }
            }
        }

        if (resultmonth > 12){
            resultyr = Math.floor(resultmonth/12);
            resultmonth = resultmonth - resultyr*12;
            propDtM = resultyr + " year " + resultmonth + " month " + countedDays + " days";
        }
        else if (resultmonth == 0){
            propDtM = "";
        }
        else{
            propDtM = resultmonth + " month " + countedDays + " days";
        }
        dToMon.setText(propDtM);
        System.println("infoview, new yr,m,d: " + resultyr + resultmonth + countedDays);
         
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