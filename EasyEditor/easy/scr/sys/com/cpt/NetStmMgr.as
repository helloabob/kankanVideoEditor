package easy.scr.sys.com.cpt
{
    import easy.hub.evt.*;
    import easy.scr.pro.*;
    import easy.scr.sys.com.cmd.*;
    import easy.scr.sys.com.dat.*;
    import vsin.dcw.support.*;

    public class NetStmMgr extends Object
    {
        private var stmA:NetStmAdv;
        private var stmB:NetStmAdv;
        private var curStm:NetStmAdv;
        private var nexStm:NetStmAdv;
        private var dat:PlayDat;

        public function NetStmMgr()
        {
            return;
        }// end function

        public function init(param1:NetStmAdv, param2:NetStmAdv) : void
        {
            this.dat = ScrFactory.to.getCompIns(PlayDat);
            this.dat.curClipIdx = -1;
            this.stmA = param1;
            this.stmB = param2;
            return;
        }// end function

        private function shift() : void
        {
            if (this.curStm != this.stmA)
            {
                this.curStm = this.stmA;
                this.nexStm = this.stmB;
            }
            else
            {
                this.curStm = this.stmB;
                this.nexStm = this.stmA;
            }
            Trace.err("now cur stream is", this.curStm.getName());
            return;
        }// end function

        public function play() : void
        {
			trace("play_url:"+this.dat.curPlayUrl);
            this.dat.updateInfo((this.dat.curClipIdx + 1));
            this.shift();
            this.curStm.initStream();
            this.dat.curStm = this.curStm.stream;
            ScrDispatcher.to.dispatch(new ScreenStmEvt(ScreenStmEvt.BEFORE_PLAY));
            this.curStm.activate(true);
            this.nexStm.activate(false);
            this.curStm.play(this.dat.curPlayUrl, this.dat.curClipIdx);
            if (this.dat.nexPlayUrl)
            {
                this.nexStm.initStream();
                this.nexStm.play(this.dat.nexPlayUrl, (this.dat.curClipIdx + 1));
                this.nexStm.pause();
            }
            return;
        }// end function

        public function seekByUrl() : void
        {
            this.curStm.play(this.dat.curSeekUrl, this.dat.curClipIdx);
            return;
        }// end function

        public function seek(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
        {
            var _loc_4:* = this.dat.transProgToClipIdAndFlyTime(param1);
            Trace.log("NetStmMgr", _loc_4.toString());
            var _loc_5:* = _loc_4[0];
            var _loc_6:* = _loc_4[1];
            var _loc_7:* = _loc_4[2];
            if (this.dat.isEndOfClip(_loc_5, _loc_6))
            {
                this.whenSeekAtClipEnd(_loc_4, param2, param3);
            }
            else
            {
                this.whenSeekNotAtClipEnd(_loc_4, param2);
            }
            return;
        }// end function

        private function whenSeekAtClipEnd(param1:Array, param2:Boolean, param3:Boolean) : void
        {
            var _loc_4:* = param1[0];
            var _loc_5:* = param1[1];
            var _loc_6:* = param1[2];
            Trace.log("NetStmMgr", "seek At the edge");
            if (param3 === true)
            {
                if (_loc_4 != (this.dat.clipUrls.length - 1))
                {
                    this.dat.updateInfo((this.dat.curClipIdx + 1));
                }
                else
                {
                    return;
                }
            }
            this.curStm.play(this.dat.curPlayUrl, this.dat.curClipIdx);
            if (param2)
            {
                Trace.log("NetStmMgr TUNING, seek pause");
                this.pause();
            }
            return;
        }// end function

        private function whenSeekNotAtClipEnd(param1:Array, param2:Boolean) : void
        {
            var _loc_3:* = param1[0];
            var _loc_4:* = param1[1];
            var _loc_5:* = param1[2];
            this.dat.updateInfo(_loc_3);
            if (param2)
            {
                Trace.log("NetStmMgr", "seekToNoDat");
                this.curStm.seekToNoDat(_loc_3, _loc_4, _loc_5, param2);
                Trace.log("NetStmMgr TUNING, seek pause");
                this.pause();
            }
            else
            {
                Trace.log("NetStmMgr", "seekTo");
                this.curStm.seekTo(_loc_3, _loc_4, _loc_5, param2);
            }
            return;
        }// end function

        public function pause() : void
        {
            this.curStm.pause();
            return;
        }// end function

        public function resume() : void
        {
            this.curStm.resume();
            return;
        }// end function

        public function timeUpdate(param1:TimerEvt) : void
        {
            this.curStm.timeUpdate(param1);
            return;
        }// end function

    }
}
