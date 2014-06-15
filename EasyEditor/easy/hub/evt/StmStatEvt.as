package easy.hub.evt
{
    import flash.events.*;

    public class StmStatEvt extends Event
    {
        public var height:Number;
        private static const PREFIX:String = "StmStatEvt_";
        public static const PAUSE:String = PREFIX + "PAUSE";
        public static const RESUME:String = PREFIX + "RESUME";
        public static const START:String = PREFIX + "START";
        public static const META_LOADED:String = PREFIX + "META_LOADED";

        public function StmStatEvt(param1:String, param2:Boolean = true, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new StmStatEvt(type, bubbles, cancelable);
            _loc_1.height = this.height;
            return _loc_1;
        }// end function

    }
}
