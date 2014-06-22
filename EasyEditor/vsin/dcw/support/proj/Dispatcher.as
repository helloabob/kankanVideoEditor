package vsin.dcw.support.proj
{
    import flash.events.*;
    import flash.utils.*;
    import vsin.dcw.support.*;

    public class Dispatcher extends Object
    {
        public var tracingEvt:Boolean = false;
        public const AVOID:String = "AVOID_TRACING";
        private var _allDp:Dictionary;
        private var _allCmd:Dictionary;
        private var _channel:String;

        public function Dispatcher(param1:String)
        {
            this._allDp = new Dictionary();
            this._allCmd = new Dictionary();
            this._channel = param1;
            return;
        }// end function

        public function addEvent(param1:Class, param2:String, param3:Function) : void
        {
            var _loc_6:* = this._allDp[param1] || new Dictionary();
            this._allDp[param1] = this._allDp[param1] || _loc_6;
//            var _loc_4:* = _loc_6;
//            var _loc_6:* = _loc_6[param2] || new EventDispatcher();
            _loc_6[param2] = _loc_6[param2] || new EventDispatcher();
//            var _loc_5:* = _loc_6;
            _loc_6[param2].addEventListener(param2, param3);
            return;
        }// end function

		/*param1:EventClass param2:EventString param3:CmdClass*/
        public function addCmd(param1:Class, param2:String, param3:Class) : void
        {
//			trace(param1+":"+param2+":"+param3);
            var _loc_7:* = this._allDp[param1] || new Dictionary();
//			trace(param1+":"+param2+":"+param3);
			this._allDp[param1]=_loc_7;
//            this._allDp[param1] = this._allDp[param1] || new Dictionary();
//			trace(param1+":"+param2+":"+param3);
//            var _loc_4:* = _loc_7;
			_loc_7[param2]=_loc_7[param2]||new EventDispatcher();
//			trace(param1+":"+param2+":"+param3);
//            var _loc_7:* = _loc_4[param2] || new EventDispatcher();
//			trace(param1+":"+param2+":"+param3);
//            _loc_7[param2] = _loc_4[param2] || new EventDispatcher();
//			trace(param1+":"+param2+":"+param3);
//            var _loc_5:* = _loc_7;
//			trace(param1+":"+param2+":"+param3);
            _loc_7[param2].addEventListener(param2, this.cmdDispatcher);
            var _loc_8:* = this._allCmd[param1] || new Dictionary();
            this._allCmd[param1] = _loc_8;
//            var _loc_6:* = _loc_7;
            _loc_8[param2] = param3;
			
            return;
        }// end function

        public function delEvent(param1:Class, param2:String, param3:Function) : void
        {
            var _loc_5:EventDispatcher = null;
            var _loc_4:* = this._allDp[param1];
            if (this._allDp[param1])
            {
                _loc_5 = _loc_4[param2];
            }
            return;
        }// end function

        public function delCmd(param1:Class, param2:String, param3:Class) : void
        {
            var _loc_5:EventDispatcher = null;
            var _loc_4:* = this._allDp[param1];
            if (this._allDp[param1])
            {
                _loc_5 = _loc_4[param2];
            }
            var _loc_6:* = this._allCmd[param1];
            this._allCmd[param1][param2] = null;
            delete _loc_6[param2];
            return;
        }// end function

        public function dispatch(event:Event) : void
        {
            var _loc_5:EventDispatcher = null;
            var _loc_2:* = getQualifiedClassName(event);
            var _loc_3:* = getDefinitionByName(_loc_2) as Class;
            var _loc_4:* = this._allDp[_loc_3];
            if (_loc_4)
            {
                _loc_5 = _loc_4[event.type];
            }
			_loc_5.dispatchEvent(event);
            return;
        }// end function

        private function cmdDispatcher(event:Event) : void
        {
            var _loc_5:Class = null;
            var _loc_2:* = getQualifiedClassName(event);
            var _loc_3:* = getDefinitionByName(_loc_2) as Class;
            var _loc_4:* = this._allCmd[_loc_3];
            if (this._allCmd[_loc_3])
            {
                _loc_5 = _loc_4[event.type];
				if (_loc_5)
                {
//                    var _loc_6:* = _loc_5;
                    new _loc_5(event);
                }
            }
            return;
        }// end function

        public function dispose() : void
        {
            this._allCmd = null;
            this._allDp = null;
            return;
        }// end function

    }
}
