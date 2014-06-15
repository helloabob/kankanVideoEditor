package easy.scr.sys.com.cmd.stmCmd
{
    import easy.scr.pro.*;
    import easy.scr.sys.com.cmd.*;
    import easy.scr.sys.com.cpt.*;

    public class PlayOverClipCmd extends Object
    {

        public function PlayOverClipCmd(param1:ScreenStmEvt)
        {
            var _loc_2:* = ScrFactory.to.getCompIns(NetStmMgr);
            _loc_2.play();
            return;
        }// end function

    }
}
