package easy.scr.sys.com.cpt
{
    import easy.hub.evt.*;
    import easy.scr.pro.*;
    import easy.scr.sys.com.dat.*;
    import flash.events.*;
    import flash.utils.*;
    import vsin.dcw.support.*;

    public class TimeMgr extends Object
    {
        protected var timer:Timer;
        protected var teller:ScrTeller;
        protected var dat:PlayDat;
        protected var stmMgr:NetStmMgr;
        protected var stmMonitor:StreamMonitor;
        protected const TIME:int = 500;

        public function TimeMgr()
        {
            this.dat = ScrFactory.to.getCompIns(PlayDat);
            this.stmMonitor = new StreamMonitor();
            this.stmMgr = ScrFactory.to.getCompIns(NetStmMgr);
            this.teller = ScrFactory.to.getCompIns(ScrTeller);
            this.timer = new Timer(this.TIME);
            this.timer.addEventListener(TimerEvent.TIMER, this.onTimer);
            return;
        }// end function

        public function start() : void
        {
			if(this.timer.running)return;
			this.timer.start();
            Trace.log("TimeMgr START");
            return;
        }// end function

        public function end() : void
        {
            Trace.log("TimeMgr END");
            this.timer.stop();
            return;
        }// end function

        private function onTimer(event:TimerEvent) : void
        {
            var _loc_2:* = new TimerEvt(TimerEvt.TIME);
            this.stmMgr.timeUpdate(_loc_2);
            this.teller.dispatchEvent(_loc_2);
            return;
        }// end function

    }
}
