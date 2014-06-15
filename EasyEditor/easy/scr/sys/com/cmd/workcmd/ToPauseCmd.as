package easy.scr.sys.com.cmd.workcmd
{
    import easy.hub.evt.*;
    import easy.scr.pro.*;
    import easy.scr.sys.com.cpt.*;

    public class ToPauseCmd extends Object
    {

        public function ToPauseCmd(param1:WorkEvt)
        {
            var _loc_2:* = ScrFactory.to.getCompIns(NetStmMgr);
            _loc_2.pause();
            return;
        }// end function

    }
}
