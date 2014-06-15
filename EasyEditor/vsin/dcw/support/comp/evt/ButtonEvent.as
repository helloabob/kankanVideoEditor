package vsin.dcw.support.comp.evt
{
    import flash.events.*;

    public class ButtonEvent extends Event
    {
        public var isChecked:Boolean;
        public static const BUTTON_CHECKED:String = "BUTTON_CHECKED";

        public function ButtonEvent(param1:String, param2:Boolean = true, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new ButtonEvent(type, bubbles, cancelable);
            _loc_1.isChecked = this.isChecked;
            return _loc_1;
        }// end function

    }
}
