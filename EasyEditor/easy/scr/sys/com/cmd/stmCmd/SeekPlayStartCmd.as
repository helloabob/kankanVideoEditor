﻿package easy.scr.sys.com.cmd.stmCmd
{
    import easy.hub.spv.*;
    import easy.scr.pro.*;
    import easy.scr.sys.com.cmd.*;
    import easy.scr.sys.com.cpt.*;

    public class SeekPlayStartCmd extends Object
    {

        public function SeekPlayStartCmd(param1:ScreenStmEvt)
        {
            LoadingMgr.getIns().hide(LoadingMgr.SHORT_LOAD_SEEK);
            var _loc_2:* = ScrFactory.to.getCompIns(TimeMgr);
            _loc_2.start();
            return;
        }// end function

    }
}
