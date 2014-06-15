package easy.hub.evt
{
    import flash.events.*;

    public class KeyPressedEvt extends Event
    {
        private static const PREFIX:String = "KeyPressedEvt_";
        public static const UNDO:String = PREFIX + "UNDO";
        public static const TO_LEFT:String = PREFIX + "TO_LEFT";
        public static const TO_RIGHT:String = PREFIX + "TO_RIGHT";
        public static const SET_START_PT:String = PREFIX + "SET_START_PT";
        public static const SET_END_PT:String = PREFIX + "SET_END_PT";
        public static const TOGGLE_PLAY:String = PREFIX + "TOGGLE_PLAY";

        public function KeyPressedEvt(param1:String, param2:Boolean = true, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new KeyPressedEvt(type, bubbles, cancelable);
            return _loc_1;
        }// end function

    }
}
