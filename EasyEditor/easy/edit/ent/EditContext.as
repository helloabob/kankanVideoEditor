package easy.edit.ent
{
    import easy.edit.pro.*;
    import easy.edit.sys.mdt.*;
    import easy.hub.evt.*;
    import flash.display.*;
    import flash.events.*;
    import vsin.dcw.support.*;

    public class EditContext extends Sprite
    {

        public function EditContext()
        {
            return;
        }// end function

        public function init(param1:Object, param2:Stage) : void
        {
            new EditBoot(param1, param2, this);
            var _loc_3:* = EditFactory.to.getCompIns(EditTeller);
            _loc_3.addEventListener(WorkEvt.SEEK, this.sendOut);
            _loc_3.addEventListener(WorkEvt.PAUSE, this.sendOut);
            _loc_3.addEventListener(WorkEvt.RESUME, this.sendOut);
            return;
        }// end function

        public function noti(event:Event) : void
        {
            EditDispatcher.to.dispatch(event);
            return;
        }// end function

        private function sendOut(event:Event) : void
        {
            Trace.log("send out", event.type);
            dispatchEvent(event);
            return;
        }// end function

    }
}
