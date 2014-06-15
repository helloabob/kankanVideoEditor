package easy.scr.ent
{
    import easy.hub.evt.*;
    import easy.scr.pro.*;
    import easy.scr.sys.mdt.*;
    import flash.display.*;
    import flash.events.*;
    import vsin.dcw.support.*;

    public class ScrContext extends Sprite
    {
        private var teller:ScrTeller;

        public function ScrContext()
        {
            return;
        }// end function

        public function init(param1:Object, param2:Stage) : void
        {
            new ScrBoot(param1, stage, this);
            this.teller = ScrFactory.to.getCompIns(ScrTeller);
            this.teller.addEventListener(TimerEvt.TIME, this.sendOut);
            this.teller.addEventListener(KeyFrEvt.KEY_FRAME_LOADED, this.sendOut);
            this.teller.addEventListener(StmStatEvt.PAUSE, this.sendOut);
            this.teller.addEventListener(StmStatEvt.START, this.sendOut);
            this.teller.addEventListener(StmStatEvt.RESUME, this.sendOut);
            this.teller.addEventListener(StmStatEvt.META_LOADED, this.sendOut);
            return;
        }// end function

        private function sendOut(event:Event) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        public function noti(event:Event) : void
        {
            ScrDispatcher.to.dispatch(event);
            return;
        }// end function

    }
}
