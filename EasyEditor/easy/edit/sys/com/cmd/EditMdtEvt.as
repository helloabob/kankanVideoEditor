package easy.edit.sys.com.cmd
{
    import flash.events.*;

    public class EditMdtEvt extends Event
    {
        public var editDat:Array;
        public static const UPDATE_EDIT_DAT:String = "UPDATE_EDIT_DAT";

        public function EditMdtEvt(param1:String, param2:Boolean = true, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new EditMdtEvt(type, bubbles, cancelable);
            _loc_1.editDat = this.editDat;
            return _loc_1;
        }// end function

    }
}
