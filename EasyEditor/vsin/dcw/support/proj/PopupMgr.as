package vsin.dcw.support.proj
{
    import __AS3__.vec.*;

    public class PopupMgr extends Object
    {
        private static var popFuncArr:Vector.<Function> = new Vector.<Function>;
        private static var popParamsArr:Vector.<Array> = new Vector.<Array>;
        private static var inChainReaction:Boolean = false;

        public function PopupMgr()
        {
            return;
        }// end function

        public static function addToShow(param1:Function, param2:Array = null) : void
        {
            popFuncArr.push(param1);
            popParamsArr.push(param2);
            if (!inChainReaction)
            {
                popup();
            }
            return;
        }// end function

        public static function popup() : void
        {
            if (popFuncArr.length > 0)
            {
                inChainReaction = true;
                popFuncArr[0].apply(null, popParamsArr[0]);
                popFuncArr.shift();
                popParamsArr.shift();
            }
            else
            {
                inChainReaction = false;
            }
            return;
        }// end function

        public static function clean(param1:Function = null) : void
        {
            var _loc_2:int = 0;
            if (param1 is Function)
            {
                _loc_2 = popFuncArr.indexOf(param1);
                if (_loc_2 >= 0)
                {
                    popFuncArr.splice(_loc_2, 1);
                    popParamsArr.splice(_loc_2, 1);
                }
            }
            else
            {
                var _loc_3:int = 0;
                popParamsArr.length = 0;
                popFuncArr.length = _loc_3;
            }
            return;
        }// end function

    }
}
