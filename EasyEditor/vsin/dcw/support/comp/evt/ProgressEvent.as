package vsin.dcw.support.comp.evt
{
    import flash.events.*;

    public class ProgressEvent extends Event
    {
        public var progress:Number = 0;
        public var fromUser:Boolean = false;
        public static const TRACK_DOWN:String = "TRACK_DOWN";
        public static const PROGRESS_CHANGE:String = "PROGRESS_CHANGE";

        public function ProgressEvent(param1:String, param2:Boolean = true, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new ProgressEvent(type, bubbles, cancelable);
            _loc_1.progress = this.progress;
            _loc_1.fromUser = this.fromUser;
            return _loc_1;
        }// end function

    }
}
