package easy.scr.sys.com.cmd.workcmd
{
    import easy.hub.evt.*;
    import easy.scr.pro.*;
    import easy.scr.sys.com.cpt.*;

    public class ToResumeCmd extends Object
    {

        public function ToResumeCmd(param1:WorkEvt)
        {
            var _loc_2:* = ScrFactory.to.getCompIns(NetStmMgr);
            _loc_2.resume();
            return;
        }// end function

    }
}
