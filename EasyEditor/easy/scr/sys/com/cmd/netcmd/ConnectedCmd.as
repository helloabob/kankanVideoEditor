package easy.scr.sys.com.cmd.netcmd
{
    import easy.scr.pro.*;
    import easy.scr.sys.com.cmd.*;
    import easy.scr.sys.com.cpt.*;
    import vsin.dcw.support.*;

    public class ConnectedCmd extends Object
    {

        public function ConnectedCmd(param1:ScreenNetEvt)
        {
            var _loc_2:* = ScrFactory.to.getCompIns(NetStmMgr);
            _loc_2.play();
            Trace.log("First Play Pause");
            _loc_2.pause();
            return;
        }// end function

    }
}
