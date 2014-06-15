package easy.edit.sys.com.cmd
{
    import flash.events.*;

    public class EditNetEvt extends Event
    {
        public static const HOT_SPOT_LOADED:String = "HOT_SPOT_LOADED";

        public function EditNetEvt(param1:String, param2:Boolean = true, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new EditNetEvt(type, bubbles, cancelable);
            return _loc_1;
        }// end function

    }
}
