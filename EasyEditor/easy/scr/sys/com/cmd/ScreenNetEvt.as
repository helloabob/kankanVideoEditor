package easy.scr.sys.com.cmd
{
    import flash.events.*;

    public class ScreenNetEvt extends Event
    {
        public var totTime:Number;
        public var totBytes:Number;
        public static const CLIP_INFO_LOADED:String = "CLIP_INFO_LOADED";
        public static const CLIP_ALL_URLS_LOADED:String = "CLIP_ALL_URLS_LOADED";
        public static const CONNECTED:String = "CONNECTED";

        public function ScreenNetEvt(param1:String, param2:Boolean = true, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new ScreenNetEvt(type, bubbles, cancelable);
            _loc_1.totBytes = this.totBytes;
            _loc_1.totTime = this.totTime;
            return _loc_1;
        }// end function

    }
}
