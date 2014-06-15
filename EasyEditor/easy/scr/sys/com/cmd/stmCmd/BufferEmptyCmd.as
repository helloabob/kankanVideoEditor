package easy.scr.sys.com.cmd.stmCmd
{
    import easy.hub.spv.*;
    import easy.scr.sys.com.cmd.*;

    public class BufferEmptyCmd extends Object
    {

        public function BufferEmptyCmd(param1:ScreenStmEvt)
        {
            LoadingMgr.getIns().show(LoadingMgr.BUF);
            return;
        }// end function

    }
}
