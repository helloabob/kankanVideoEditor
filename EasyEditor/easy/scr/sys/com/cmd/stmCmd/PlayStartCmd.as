package easy.scr.sys.com.cmd.stmCmd
{
    import easy.hub.evt.*;
    import easy.scr.pro.*;
    import easy.scr.sys.com.cmd.*;

    public class PlayStartCmd extends Object
    {

        public function PlayStartCmd(param1:ScreenStmEvt)
        {
            var _loc_2:* = ScrFactory.to.getCompIns(ScrTeller);
            _loc_2.dispatchEvent(new StmStatEvt(StmStatEvt.START));
            return;
        }// end function

    }
}
