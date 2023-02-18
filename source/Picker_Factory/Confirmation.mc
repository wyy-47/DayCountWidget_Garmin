import Toybox.Application.Storage;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

class ConfirmationView extends WatchUi.View{
    function initialize(){
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
        if(Storage.getValue("dateThree")!= null){
            setLayout(Rez.Layouts.LayoutThree(dc));
            System.println("confirmation layout 3");
        }else if (Storage.getValue("dateTwo")!= null) {
            setLayout(Rez.Layouts.LayoutTwo(dc));
            System.println("confirmation layout 2");
        }else {
            setLayout(Rez.Layouts.LayoutOne(dc));
            System.println("confirmation layout 1");
        }
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        var date = findDrawableById("dateThree") as Text;
       
        var prop = Storage.getValue("dateThree");
        System.println(prop);
        //date.setText(prop);
        if (prop instanceof String) {
            System.println("instance of");
            date.setText(prop);
            date.setColor(Graphics.COLOR_WHITE);
        }

        // if (Storage.getValue("dateOne") == null){
        //             Storage.setValue("dateOne", date);
        //         }else if (Storage.getValue("dateTwo") == null){
        //             Storage.setValue("dateTwo", date);
        //         }else if (Storage.setValue("dateThree") == null){
        //             Storage.setValue("dateThree", date)
        //         }else{

        //         }

        // // set the color of each Text object
        // prop = Storage.getValue("color");
        // if (prop instanceof Number) {
        //     date.setColor(prop);
        // }
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.clear();

        dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Graphics.FONT_SMALL, "Saved!", Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }
}

//! Input handler for the main view
class ConfirmationDelegate extends WatchUi.BehaviorDelegate {

    //! Constructor
    public function initialize() {
        BehaviorDelegate.initialize();
    }

    // //! Handle the menu event
    // //! @return true if handled, false otherwise
    // public function onMenu() as Boolean {
    //     return pushPicker();
    // }

    //! Handle a button being pressed and released
    //! @param evt The key event that occurred
    //! @return true if handled, false otherwise
    public function onKey(evt as KeyEvent) as Boolean {
        var key = evt.getKey();
        if ((WatchUi.KEY_ESC == key) || (WatchUi.KEY_ENTER == key)) {
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