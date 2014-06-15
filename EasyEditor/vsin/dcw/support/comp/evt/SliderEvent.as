package vsin.dcw.support.comp.evt
{
    import flash.events.*;

    public class SliderEvent extends Event
    {
        public var fromUser:Boolean = false;
        public static const THUMB_DOWN:String = "THUMB_DOWN";

        public function SliderEvent(param1:String, param2:Boolean = true, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new SliderEvent(type, bubbles, cancelable);
            _loc_1.fromUser = this.fromUser;
            return _loc_1;
        }// end function

    }
}
