package easy.hub.evt
{
    import flash.events.Event;

    public class KeyFrEvt extends Event
    {
        public var totTime:Number;
        public var totBytes:Number;
        public var tvName:String;
        public var keyFrDat:Array;
        public var clipDurArr:Array;
		public var epg:String;
		public var threshold:int;
        private static const PREFIX:String = "KeyFrEvt_";
        public static const KEY_FRAME_LOADED:String = PREFIX + "KEY_FRAME_LOADED";

        public function KeyFrEvt(param1:String, param2:Boolean = true, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new KeyFrEvt(type, bubbles, cancelable);
            _loc_1.totTime = this.totTime;
            _loc_1.totBytes = this.totBytes;
            _loc_1.tvName = this.tvName;
            _loc_1.keyFrDat = this.keyFrDat;
            _loc_1.clipDurArr = this.clipDurArr;
			_loc_1.epg = this.epg;
			_loc_1.threshold = this.threshold;
            return _loc_1;
        }// end function

    }
}
