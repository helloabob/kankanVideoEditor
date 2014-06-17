package vsin.dcw.support
{
    import flash.display.*;
    import flash.events.*;
    import flash.external.*;
    import flash.system.*;
    import flash.ui.*;
    import flash.utils.*;

    public class Trace extends Object
    {
        private static var tracer:Object;
        private static var _tracer:Object;
        public static const SWF_NAME:String = "Trace.swf";
        public static const PRIM_TYPE_A:String = "intstringnumberbooleanuintundefined";
        public static const PRIM_TYPE_B:String = "intStringNumberBooleanuintundefined";
        public static var AVALIABLE:Boolean = false;
        public static var USE_CONSOLE:Boolean = false;
        public static var EX_ACTIVE:Boolean = true;
        public static var SOHU_TR:Object = null;
        private static var cascade:int = 0;
        private static var count:int = 0;
        private static var tab:Array = ["--", "----", "------"];

        public function Trace()
        {
            return;
        }// end function

        public static function log(param1:Object, param2:Object = "") : void
        {
			trace(param1+param2);
//            if (PRIM_TYPE_A.indexOf(typeof(param2)) === -1)
//            {
//                traceObject(param2);
//            }
//            else
//            {
//            }
            return;
        }// end function

        public static function err(param1:Object, param2:Object = "") : void
        {
            return;
        }// end function

        public static function getBinLog() : Array
        {
            if (tracer)
            {
                return tracer.getBinLog();
            }
            return [];
        }// end function

        public static function refresh(param1:Object, param2:Object = "") : void
        {
            return;
        }// end function

        public static function flushMonitor() : void
        {
            return;
        }// end function

        public static function cleanMonitor() : void
        {
            return;
        }// end function

        public static function refreshEx(param1:Object, param2:Object = "") : void
        {
            return;
        }// end function

        public static function flushMonitorEx() : void
        {
            return;
        }// end function

        public static function cleanMonitorEx() : void
        {
            return;
        }// end function

        public static function checkExActive() : void
        {
            try
            {
                ExternalInterface.call(null);
            }
            catch (e:SecurityError)
            {
                EX_ACTIVE = false;
            }
            if (EX_ACTIVE && USE_CONSOLE)
            {
                USE_CONSOLE = ExternalInterface.call("function(){return (console ? true : false);}");
                EX_ACTIVE = USE_CONSOLE;
            }
            return;
        }// end function

        public static function buildGetLogMenu(param1:Sprite) : void
        {
            var _loc_2:* = new ContextMenuItem("复制 log", true);
            _loc_2.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onLogSelect);
            var _loc_3:* = param1.contextMenu;
            _loc_3.hideBuiltInItems();
            _loc_3.customItems.push(_loc_2);
            param1.contextMenu = _loc_3;
            return;
        }// end function

        public static function setTracer(param1:Object) : void
        {
            param1 = param1 || (SOHU_TR ? (new TraceSohu(SOHU_TR)) : (new TraceBin()));
            var _loc_2:* = param1;
            tracer = param1;
            _tracer = _loc_2;
            return;
        }// end function

        public static function disabled(param1:Boolean) : void
        {
            if (param1)
            {
                err("TRACE DISABLED");
                tracer = null;
            }
            else
            {
                tracer = _tracer;
                err("TRACE ENABLED");
            }
            return;
        }// end function

        public static function getSearchParamVal(param1:String) : String
        {
            var _loc_3:Array = null;
            var _loc_4:int = 0;
            var _loc_5:Array = null;
            var _loc_2:* = ExternalInterface.call("eval", "window.location.search");
            if (_loc_2)
            {
                _loc_2 = _loc_2.slice(1);
                _loc_3 = _loc_2.split("&");
                _loc_4 = 0;
                while (_loc_4 < _loc_3.length)
                {
                    
                    _loc_5 = _loc_3[_loc_4].split("=");
                    if (_loc_5.length === 2 && _loc_5[0] === param1)
                    {
                        return _loc_5[1];
                    }
                    _loc_4++;
                }
            }
            return "";
        }// end function

        public static function getTraceUrl(param1:Stage) : String
        {
            var _loc_2:* = param1.loaderInfo.loaderURL;
            var _loc_3:* = _loc_2.split("/");
            _loc_3.pop();
            _loc_2 = _loc_3.join("/");
            return _loc_2 + "/" + Trace.SWF_NAME;
        }// end function

        private static function onLogSelect(event:ContextMenuEvent) : void
        {
            var _loc_2:* = getBinLog();
            System.setClipboard(_loc_2.join("\n"));
            return;
        }// end function

        private static function traceObject(param1:Object) : void
        {
            var _loc_2:Object = null;
            var _loc_3:String = null;
            var _loc_4:String = null;
            var _loc_5:XML = null;
            var _loc_6:String = null;
            var _loc_7:XML = null;
            var _loc_8:XMLList = null;
            if (typeof(param1) === "object")
            {
                for (_loc_6 in param1)
                {
                    
                    _loc_2 = param1[_loc_6];
                    _loc_3 = typeof(_loc_2);
                    if (_loc_3 === "object")
                    {
                        traceObject(_loc_2);
                        continue;
                    }
                }
            }
            else
            {
                _loc_7 = describeType(param1);
                _loc_8 = _loc_7.accessor;
                for each (_loc_5 in _loc_8)
                {
                    
                    _loc_4 = _loc_5.@name;
                    _loc_3 = _loc_5.@type;
                    _loc_2 = param1[_loc_4];
                    if (PRIM_TYPE_B.indexOf(_loc_3) === -1)
                    {
                        var _loc_12:* = count + 1;
                        count = _loc_12;
                        if (count > cascade)
                        {
                        }
                        else
                        {
                            traceObject(_loc_2);
                        }
                        var _loc_12:* = count - 1;
                        count = _loc_12;
                        continue;
                    }
                }
            }
            return;
        }// end function

        public static function initHelper(param1:Function, param2:Sprite, param3:String, param4:uint = 0, param5:Boolean = false, param6:Boolean = false, param7:Object = null) : void
        {
            AVALIABLE = param5;
            USE_CONSOLE = param6;
            SOHU_TR = param7;
//            TraceInitShell.exec(param1, param2, param3, param4);
//			trace(param1+param2+param3+param4);
			param1();
//			param1(param2,param3,param4);
            return;
        }// end function

    }
}

final class TraceBin extends Object
{
    private var cacheTxt:Array;

    function TraceBin()
    {
        this.cacheTxt = [];
        return;
    }// end function

    public function log(param1:Object, param2:Object = "") : void
    {
        this.cacheTxt[this.cacheTxt.length] = getTimer() + " :: " + param1 + " :: " + param2;
        return;
    }// end function

    public function err(param1:Object, param2:Object = "") : void
    {
        this.log(param1, param2);
        return;
    }// end function

    public function getBinLog() : Array
    {
        return this.cacheTxt;
    }// end function

    public function refresh(param1:Object, param2:Object = "") : void
    {
        return;
    }// end function

    public function flushMonitor() : void
    {
        return;
    }// end function

    public function cleanMonitor() : void
    {
        return;
    }// end function

    public function refreshEx(param1:Object, param2:Object = "") : void
    {
        return;
    }// end function

    public function flushMonitorEx() : void
    {
        return;
    }// end function

    public function cleanMonitorEx() : void
    {
        return;
    }// end function

}


final class TraceSohu extends Object
{
    private var tracer:Object;

    function TraceSohu(param1:Object)
    {
        this.tracer = param1;
        return;
    }// end function

    public function log(param1:Object, param2:Object = null) : void
    {
        this.tracer.msg(param1 + (param2 ? (" :: " + param2) : ("")));
        return;
    }// end function

    public function err(param1:Object, param2:Object = null) : void
    {
        this.log(param1, param2);
        return;
    }// end function

    public function getBinLog() : Array
    {
        return [];
    }// end function

    public function refresh(param1:Object, param2:Object = "") : void
    {
        return;
    }// end function

    public function flushMonitor() : void
    {
        return;
    }// end function

    public function cleanMonitor() : void
    {
        return;
    }// end function

    public function refreshEx(param1:Object, param2:Object = "") : void
    {
        return;
    }// end function

    public function flushMonitorEx() : void
    {
        return;
    }// end function

    public function cleanMonitorEx() : void
    {
        return;
    }// end function

}

