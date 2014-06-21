package easy.scr.sys.com.cmd.stmCmd
{
    import easy.scr.pro.*;
    import easy.scr.sys.com.cmd.*;
    import easy.scr.sys.com.cpt.*;

    public class MetaLoadedCmd extends Object
    {

        public function MetaLoadedCmd(param1:ScreenStmEvt)
        {
            var _loc_2:TimeMgr = ScrFactory.to.getCompIns(TimeMgr);
            _loc_2.start();
            return;
        }// end function

    }
}
