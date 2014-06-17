package vsin.dcw.support
{
    import flash.utils.*;

    public class RetryValidator extends Object
    {
        private var retryTimes:int;
        private var RETRY_MAX:int;
        private var delayTime:Number;

        public function RetryValidator(param1:int = 2, param2:Number = 0)
        {
            this.retryTimes = 0;
            this.delayTime = param2;
            this.RETRY_MAX = param1;
            return;
        }// end function

        public function canRetry(param1:Function, param2:Function, ... args) : void
        {
            if (this.retryTimes < this.RETRY_MAX)
            {
                args = this;
                var _loc_5:* = args.retryTimes + 1;
                args.retryTimes = _loc_5;
                if (param1 is Function)
                {
                    setTimeout(this.okWithParams, this.delayTime * 1000, param1, args);
                }
            }
            else
            {
                this.retryTimes = 0;
                if (param2 is Function)
                {
                    param2.apply(this, args);
                }
            }
            return;
        }// end function

        public function reset() : void
        {
            this.retryTimes = 0;
            return;
        }// end function

        private function okWithParams(param1:Function, param2:Array) : void
        {
			trace("okWithParams"+param1+"aaaa"+param2);
            param1.apply(this, param2);
            return;
        }// end function

    }
}
