package easy.scr.sys.com.cmd.stmCmd
{
    import easy.hub.evt.*;
    import easy.scr.pro.*;
    import easy.scr.sys.com.cmd.*;

    public class PauseCmd extends Object
    {

        public function PauseCmd(param1:ScreenStmEvt)
        {
            var _loc_2:* = ScrFactory.to.getCompIns(ScrTeller);
            _loc_2.dispatchEvent(new StmStatEvt(StmStatEvt.PAUSE));
            return;
        }// end function

    }
}
