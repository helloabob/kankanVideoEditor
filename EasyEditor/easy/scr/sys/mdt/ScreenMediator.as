package easy.scr.sys.mdt
{
    import easy.hub.evt.*;
    import easy.hub.spv.*;
    import easy.scr.pro.*;
    import easy.scr.sys.com.cmd.*;
    import easy.scr.sys.com.dat.*;
    import easy.scr.sys.stg.dat.*;
    import easy.scr.sys.stg.viw.*;
    import flash.display.*;
    import vsin.dcw.support.*;

    public class ScreenMediator extends Object
    {
        private var curScr:Screen;
        private var backScr:Screen;
        private var scrMgr:ScreenMgr;
        private var dat:PlayDat;
        private var name:String = "[ScreenMediator]";

        public function ScreenMediator(param1:Sprite, param2:Screen, param3:Screen)
        {
            this.dat = ScrFactory.to.getCompIns(PlayDat);
            ScreenDat.stgWidth = param1.stage.stageWidth;
            ScreenDat.stgHeight = 395;
            this.scrMgr = new ScreenMgr(param1, param2, param3);
            ScrDispatcher.to.addEvent(ScreenStmEvt, ScreenStmEvt.BEFORE_PLAY, this.onBeforePlay);
            ScrDispatcher.to.addEvent(ScreenStmEvt, ScreenStmEvt.META_LOADED, this.onMetaLoaded);
            ScrDispatcher.to.addEvent(WorkEvt, WorkEvt.SEEK, this.onSeek);
            return;
        }// end function

        private function onBeforePlay(param1:ScreenStmEvt) : void
        {
            Trace.log(this.name, "onBeforePlay");
            this.backScr = this.scrMgr.getBackScr();
            this.backScr.attachStm(this.dat.curStm);
            this.curScr = this.scrMgr.getCurScr();
            this.curScr.detachStm();
            this.scrMgr.swap();
            return;
        }// end function

        private function onMetaLoaded(param1:ScreenStmEvt) : void
        {
            Trace.log(this.name, "onMetaLoaded");
            this.backScr = this.scrMgr.getBackScr();
            this.curScr = this.scrMgr.getCurScr();
            var _loc_2:* = ScreenDat.stgWidth;
            var _loc_3:* = ScreenDat.stgHeight;
            var _loc_4:* = this.dat.metaWidth;
            var _loc_5:* = this.dat.metaHeight;
            Trace.log("resize WH", _loc_2 + " / " + _loc_3);
            Trace.log("video WH", _loc_4 + " / " + _loc_5);
            var _loc_6:* = Math.min(_loc_2 / _loc_4, _loc_3 / _loc_5);
            Trace.log("scaling", _loc_6);
            _loc_4 = _loc_4 * _loc_6;
            _loc_5 = _loc_5 * _loc_6;
            this.curScr.resize(_loc_4, _loc_5);
            this.backScr.resize(_loc_4, _loc_5);
            var _loc_10:* = (_loc_2 - _loc_4) / 2;
            this.curScr.x = (_loc_2 - _loc_4) / 2;
            this.backScr.x = _loc_10;
            var _loc_7:* = ScrFactory.to.getCompIns(ScrTeller);
            var _loc_8:* = new StmStatEvt(StmStatEvt.META_LOADED);
            new StmStatEvt(StmStatEvt.META_LOADED).height = _loc_5;
            _loc_7.dispatchEvent(_loc_8);
            var _loc_9:* = LoadingMgr.getIns();
            LoadingMgr.getIns().hide(LoadingMgr.OPEN);
            _loc_9.x = (_loc_2 - _loc_4) / 2;
            _loc_9.resize(_loc_4, _loc_5);
            return;
        }// end function

        private function onSeek(param1:WorkEvt) : void
        {
            return;
        }// end function

    }
}
