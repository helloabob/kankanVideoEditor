package easy.hub.ent
{
    import easy.edit.ent.*;
    import easy.hub.evt.*;
    import easy.hub.pro.*;
    import easy.scr.ent.*;
    import flash.display.*;
    import flash.events.*;
    import vsin.dcw.support.proj.*;

    public class EasyBoot extends Object
    {
        private var stg:Stage;
        private var root:DisplayObject;
        private var editCtx:EditContext;
        private var scrCtx:ScrContext;

        public function EasyBoot(param1:Object, param2:Stage, param3:DisplayObject)
        {
            this.stg = param2;
            this.root = param3;
            EasyFactory.to.tracingCreating = true;
            EasyFactory.to.registComp(ScrContext);
            EasyFactory.to.registComp(EditContext);
            this.scrCtx = EasyFactory.to.getCompIns(ScrContext);
            this.editCtx = EasyFactory.to.getCompIns(EditContext);
            this.editCtx.addEventListener(WorkEvt.SEEK, this.notiToScr);
            this.editCtx.addEventListener(WorkEvt.RESUME, this.notiToScr);
            this.editCtx.addEventListener(WorkEvt.PAUSE, this.notiToScr);
            this.scrCtx.addEventListener(TimerEvt.TIME, this.notiToEdit);
            this.scrCtx.addEventListener(KeyFrEvt.KEY_FRAME_LOADED, this.notiToEdit);
            this.scrCtx.addEventListener(StmStatEvt.PAUSE, this.notiToEdit);
            this.scrCtx.addEventListener(StmStatEvt.RESUME, this.notiToEdit);
            this.scrCtx.addEventListener(StmStatEvt.START, this.notiToEdit);
            this.scrCtx.addEventListener(StmStatEvt.META_LOADED, this.onMeta);
            LayerMgr.buildLayer(param3);
            LayerMgr.botLayer.addChild(this.scrCtx);
            LayerMgr.midLayer.addChild(this.editCtx);
            this.editCtx.init(param1, param2);
            this.scrCtx.init(param1, param2);
            this.editCtx.visible = false;
            new KeyPressMgr(param2);
            return;
        }// end function

        private function notiToScr(event:Event) : void
        {
            this.scrCtx.noti(event);
            return;
        }// end function

        private function notiToEdit(event:Event) : void
        {
            this.editCtx.noti(event);
            return;
        }// end function

        private function onMeta(param1:StmStatEvt) : void
        {
            this.editCtx.y = param1.height + 20;
            this.editCtx.visible = true;
            return;
        }// end function

    }
}
