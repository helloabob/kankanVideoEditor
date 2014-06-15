package easy.scr.sys.com.cmd.workcmd
{
    import easy.hub.evt.*;
    import easy.scr.pro.*;
    import easy.scr.sys.com.cpt.*;

    public class ToSeekCmd extends Object
    {

        public function ToSeekCmd(param1:WorkEvt)
        {
            var _loc_2:* = ScrFactory.to.getCompIns(NetStmMgr);
            _loc_2.seek(param1.progress, param1.pause, param1.isNext);
            return;
        }// end function

    }
}
