package vsin.dcw.support.net
{
    import __AS3__.vec.*;

    public class Promise extends Object
    {
        private var _succArr:Vector.<Function>;
        private var _failArr:Vector.<Function>;
        private var _resolved:Boolean = false;
        private var _rejected:Boolean = false;
        private var _resolvedData:Array;
        private var _rejectedData:Array;
        public static const PENDING:String = "PENDING";
        public static const RESOLVED:String = "RESOLVED";
        public static const REJECTED:String = "REJECTED";

        public function Promise()
        {
            this._succArr = new Vector.<Function>;
            this._failArr = new Vector.<Function>;
            return;
        }// end function

        public function then(param1:Function, param2:Function = null) : Promise
        {
            if (this._resolved)
            {
                param1.apply(null, this._resolvedData);
            }
            else
            {
                this._succArr.push(param1);
            }
            if (this._rejected)
            {
				param2.apply(null,this._rejectedData);
            }
            else
            {
				this._failArr.push(param2);
            }
            return this;
        }// end function

        public function state() : String
        {
            if (this._resolved)
            {
                return RESOLVED;
            }
            if (this._rejected)
            {
                return REJECTED;
            }
            return PENDING;
        }// end function

        public function resolve(... args) : void
        {
            this._resolved = true;
            this._rejected = false;
            this._resolvedData = args;
            for each (var func:* in this._succArr)
            {
				func.apply(null, args);
            }
            this._succArr.length = 0;
            return;
        }// end function

        public function reject(... args) : void
        {
            args = null;
            this._resolved = false;
            this._rejected = true;
            this._rejectedData = args;
            for each (args in this._failArr)
            {
                
                args.apply(null, args);
            }
            this._failArr.length = 0;
            return;
        }// end function

        public static function when(... args) : Promise
        {
//            args = new activation;
            var retPms:Promise;
            var tot:int;
            var count:int;
            var failNotified:Boolean;
            var pms:Promise;
            var succCount:Function;
            var fail:Function;
            var args:* = args;
            succCount = function (... args) : void
            {
                var _loc_3:* = count + 1;
                count = _loc_3;
                if (count === tot)
                {
                    retPms.resolve.apply(null, args);
                }
                return;
            }// end function
            ;
            fail = function (... args) : void
            {
                if (!failNotified)
                {
                    retPms.reject.apply(null, args);
                    failNotified = true;
                }
                return;
            }// end function
            ;
            retPms = new Promise;
            tot = length;
            count;
            failNotified;
            var _loc_3:int = 0;
//            var _loc_4:* = ;
			var _loc_4:*;
            while (_loc_4 in _loc_3)
            {
                
                pms = _loc_4[_loc_3];
//                then(, );
            }
            return retPms;
        }// end function

    }
}
