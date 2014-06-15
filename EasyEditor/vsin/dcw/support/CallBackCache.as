package vsin.dcw.support
{
    import __AS3__.vec.*;

    public class CallBackCache extends Object
    {
        private var funcArr:Vector.<Function>;
        private var paramsArr:Vector.<Array>;

        public function CallBackCache()
        {
            this.funcArr = new Vector.<Function>;
            this.paramsArr = new Vector.<Array>;
            return;
        }// end function

        public function addCallback(param1:Function, param2:Array = null) : void
        {
            this.funcArr.push(param1);
            this.paramsArr.push(param2);
            return;
        }// end function

        public function run() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.funcArr.length)
            {
                
                this.funcArr[_loc_1].apply(null, this.paramsArr[_loc_1]);
                _loc_1++;
            }
            var _loc_2:int = 0;
            this.paramsArr.length = 0;
            this.funcArr.length = _loc_2;
            return;
        }// end function

    }
}
