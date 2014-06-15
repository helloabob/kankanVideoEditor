package easy.hub.evt
{
    import flash.events.*;

    public class TimerEvt extends Event
    {
        public const AVOID_TRACING:int = 0;
        public var flyTime:Number;
        public var datLoaded:Number;
        private static const PREFIX:String = "TimerEvt_";
        public static const TIME:String = PREFIX + "TIME";

        public function TimerEvt(param1:String, param2:Boolean = true, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new TimerEvt(type, bubbles, cancelable);
            _loc_1.flyTime = this.flyTime;
            _loc_1.datLoaded = this.datLoaded;
            return _loc_1;
        }// end function

    }
}
