package easy.edit.sys.stg.evt
{
    import flash.events.*;

    public class WorkFieldUIEvt extends Event
    {
        public var progress:Number;
        public var pause:Boolean;
        public var isNext:Object;
        public var editDat:Array;
        public var viewProgress:Number;
        public var totSelectionDuration:Number;
        public static const SEEK:String = "SEEK";
        public static const RESUME:String = "RESUME";
        public static const PAUSE:String = "PAUSE";
        public static const UPDATE_EDIT_DAT:String = "UPDATE_EDIT_DAT";
        public static const SET_START_PT:String = "SET_START_PT";
        public static const SET_END_PT:String = "SET_END_PT";
        public static const SELECTION_CHANGE:String = "SELECTION_CHANGE";

        public function WorkFieldUIEvt(param1:String, param2:Boolean = true, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new WorkFieldUIEvt(type, bubbles, cancelable);
            _loc_1.progress = this.progress;
            _loc_1.editDat = this.editDat;
            _loc_1.viewProgress = this.viewProgress;
            _loc_1.totSelectionDuration = this.totSelectionDuration;
            _loc_1.pause = this.pause;
            _loc_1.isNext = this.isNext;
            return _loc_1;
        }// end function

    }
}
