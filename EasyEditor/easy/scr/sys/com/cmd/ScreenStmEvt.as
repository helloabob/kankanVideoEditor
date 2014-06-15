package easy.scr.sys.com.cmd
{
    import flash.events.*;

    public class ScreenStmEvt extends Event
    {
        public var clipId:int;
        public var clipStartTime:Number;
        public static const PLAY_START:String = "PLAY_START";
        public static const SEEK_PLAY_START:String = "SEEK_PLAY_START";
        public static const PAUSE:String = "PAUSE";
        public static const RESUME:String = "RESUME";
        public static const BUF_FULL:String = "BUF_FULL";
        public static const BUF_EMPTY:String = "BUF_EMPTY";
        public static const STM_NOT_FOUND:String = "STM_NOT_FOUND";
        public static const META_LOADED:String = "META_LOADED";
        public static const PLAY_OVER:String = "PLAY_OVER";
        public static const PLAY_OVER_CLIP:String = "PLAY_OVER_CLIP";
        public static const BEFORE_PLAY:String = "BEFORE_PLAY";
        public static const SEEK_IN_CLIP:String = "SEEK_IN_CLIP";
        public static const SEEK_BETWEEN_CLIP:String = "SEEK_BETWEEN_CLIP";
        public static const SEEK_NEED_RE_DISPATCHING:String = "SEEK_NEED_RE_DISPATCHING";
        public static const NEXT_CLIP_GET_READY:String = "NEXT_CLIP_GET_READY";

        public function ScreenStmEvt(param1:String, param2:Boolean = true, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new ScreenStmEvt(type, bubbles, cancelable);
            _loc_1.clipStartTime = this.clipStartTime;
            _loc_1.clipId = this.clipId;
            return _loc_1;
        }// end function

    }
}
