package easy.hub.evt
{
    import flash.events.*;

    public class WorkEvt extends Event
    {
        public var progress:Number;
        public var pause:Boolean;
        public var isNext:Object;
        public static const PREFIX:String = "WorkEvt_";
        public static const SEEK:String = PREFIX + "SEEK";
        public static const PAUSE:String = PREFIX + "PAUSE";
        public static const RESUME:String = PREFIX + "RESUME";

        public function WorkEvt(param1:String, param2:Boolean = true, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new WorkEvt(type, bubbles, cancelable);
            _loc_1.progress = this.progress;
            _loc_1.pause = this.pause;
            _loc_1.isNext = this.isNext;
            return _loc_1;
        }// end function

    }
}
