package easy.edit.sys.stg.dat
{
    import flash.display.*;

    public class SetPtCmdItem extends Object
    {
        public var targ:Sprite;
        public var action:int;

        public function SetPtCmdItem(param1:Sprite, param2:int)
        {
            this.targ = param1;
            this.action = param2;
            return;
        }// end function

    }
}
