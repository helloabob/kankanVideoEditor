package easy.scr.sys.com.cmd.stmCmd
{
    import easy.scr.pro.*;
    import easy.scr.sys.com.cmd.*;
    import easy.scr.sys.com.cpt.*;
    import easy.scr.sys.com.dat.*;

    public class ReDispatchingCmd extends Object
    {

        public function ReDispatchingCmd(param1:ScreenStmEvt)
        {
            var _loc_2:* = ScrFactory.to.getCompIns(TimeMgr);
            _loc_2.end();
            var _loc_3:* = ScrFactory.to.getCompIns(PlayDat);
            _loc_3.buildSeekUrl(param1.clipId, param1.clipStartTime);
            _loc_3.updateInfo(param1.clipId);
            var _loc_4:* = ScrFactory.to.getCompIns(NetStmMgr);
            ScrFactory.to.getCompIns(NetStmMgr).seekByUrl();
            return;
        }// end function

    }
}
