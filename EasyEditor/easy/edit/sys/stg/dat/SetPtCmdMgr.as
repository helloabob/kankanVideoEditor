package easy.edit.sys.stg.dat
{
    import __AS3__.vec.*;

    public class SetPtCmdMgr extends Object
    {
        private var allCmd:Vector.<SetPtCmdItem>;

        public function SetPtCmdMgr()
        {
            this.allCmd = new Vector.<SetPtCmdItem>;
            return;
        }// end function

        public function recordCmd(param1:SetPtCmdItem) : void
        {
            this.allCmd.push(param1);
            return;
        }// end function

        public function getLastCmd() : SetPtCmdItem
        {
            return this.allCmd.pop();
        }// end function

        public function clean() : void
        {
            this.allCmd.length = 0;
            return;
        }// end function

    }
}
