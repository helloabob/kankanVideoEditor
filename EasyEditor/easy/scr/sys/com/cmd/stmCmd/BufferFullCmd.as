package easy.scr.sys.com.cmd.stmCmd
{
    import easy.hub.spv.*;
    import easy.scr.pro.*;
    import easy.scr.sys.com.cmd.*;
    import easy.scr.sys.com.cpt.*;
	import vsin.dcw.support.Trace;

    public class BufferFullCmd extends Object
    {

        public function BufferFullCmd(param1:ScreenStmEvt)
        {
			Trace.log("BufferFullCmd");
            LoadingMgr.getIns().hide(LoadingMgr.BUF);
            LoadingMgr.getIns().hide(LoadingMgr.FULL_LOAD_SEEK);
            var _loc_2:* = ScrFactory.to.getCompIns(TimeMgr);
            _loc_2.start();
            return;
        }// end function

    }
}
