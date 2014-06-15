package easy.scr.sys.com.cmd.stmCmd
{
    import easy.scr.pro.*;
    import easy.scr.sys.com.cmd.*;
    import easy.scr.sys.com.cpt.*;

    public class SeekBetweenClipCmd extends Object
    {

        public function SeekBetweenClipCmd(param1:ScreenStmEvt)
        {
            var _loc_2:* = ScrFactory.to.getCompIns(TimeMgr);
            _loc_2.end();
            return;
        }// end function

    }
}
