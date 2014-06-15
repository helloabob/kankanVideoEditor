package easy.scr.sys.com.cmd.stmCmd
{
    import easy.hub.spv.*;
    import easy.scr.pro.*;
    import easy.scr.sys.com.cmd.*;
    import easy.scr.sys.com.dat.*;

    public class StmNotFoundCmd extends Object
    {

        public function StmNotFoundCmd(param1:ScreenStmEvt)
        {
            var _loc_2:* = ScrFactory.to.getCompIns(PlayDat);
            var _loc_3:* = new InfoTipsMgr();
            _loc_3.show("当段视频播放失败 : " + _loc_2.curClipIdx);
            return;
        }// end function

    }
}
