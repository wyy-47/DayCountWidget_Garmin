using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
class Alert {
    hidden var eYear, eMonth, eDay, eName;
    var options = {
        :year => 2022,
        :month => 10,
        :day => 06
    };

    var now = Gregorian.moment(options);
    var info = Gregorian.utcInfo(now, Time.FORMAT_SHORT);

//     System.println(Lang.format("$1$-$2$-$3$", [
//             info.year.format("%04u"),
//             info.month.format("%02u"),
//             info.day.format("%02u")]));
}
function getEventYear(){
    return eYear;
}

function getEventMonth(){
    return eMonth;
}

function getEventDay(){
    return eDay;
}

function getEventName(){
    return eName;
}

function initialize(userInput){

}