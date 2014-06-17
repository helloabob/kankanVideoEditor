package com.sohu.fwork
{
    import flash.external.*;
    import flash.net.*;

    public class JSUtil extends Object
    {
        private static var _isAvailable:Boolean;
        private static var _isChecked:Boolean = false;

        public function JSUtil()
        {
            return;
        }// end function

        public static function getJSParamForPage(param1:String, ... args) : Object
        {
//            args = new activation;
            var param:* = param1;
            var args:* = args;
            try
            {
                if (ExternalInterface.available)
                {
                    return ExternalInterface.call("function(){return " + args + ";}", null);
                }
            }
            catch (err:Error)
            {
                return null;
            }
            return null;
        }// end function

        public static function get available() : Boolean
        {
            if (!_isChecked)
            {
                _isChecked = true;
                try
                {
                    _isAvailable = ExternalInterface.call("eval", "document.URL") == null ? (false) : (true);
                }
                catch (evt:SecurityError)
                {
                    _isAvailable = false;
                }
            }
            return _isAvailable;
        }// end function

        public static function openWindow(param1:String, param2:String = "_blank", param3:String = "") : Boolean
        {
            var url:* = param1;
            var window:* = param2;
            var features:* = param3;
            var req:* = new URLRequest(url);
            window = window;
            var boo:Boolean;
            if (!JSUtil.available)
            {
                if (ExternalInterface.available)
                {
                    try
                    {
                        navigateToURL(req, window);
                        boo;
                    }
                    catch (evt:Error)
                    {
                        boo;
                    }
                }
                else
                {
                    boo;
                }
            }
            else
            {
                try
                {
                    ExternalInterface.call("function(){window.open(\'" + url + "\',\'" + window + "\');}");
                    boo;
                }
                catch (e:Error)
                {
                    boo;
                }
            }
            return boo;
        }// end function

        public static function trace(param1:String, ... args) : void
        {
            var tmp:String = "";
            var _loc_4:int = 0;
            while (_loc_4 < args.length)
            {
				tmp = tmp + String(args[_loc_4]);
                _loc_4++;
            }
			tmp = param1 + tmp;
            ExternalInterface.call("console.log", tmp);
            return;
        }// end function

        public static function alert(param1:String) : void
        {
            if (JSUtil.available)
            {
                ExternalInterface.call("alert", param1);
            }
            return;
        }// end function

        public static function getBrowserCookie(param1:String) : String
        {
            var _loc_3:String = null;
            var _loc_4:Array = null;
            var _loc_5:uint = 0;
            var _loc_6:Array = null;
            var _loc_2:String = "";
            if (JSUtil.available)
            {
                _loc_3 = ExternalInterface.call("function(){return document.cookie;}");
                if (_loc_3 != null && _loc_3 != "undefined" && _loc_3 != "")
                {
                    _loc_4 = _loc_3.split(";");
                    _loc_5 = 0;
                    while (_loc_5 < _loc_4.length)
                    {
                        
                        _loc_6 = _loc_4[_loc_5].split("=");
                        if (_loc_6.length > 0)
                        {
                            if (trim(_loc_6[0]) == param1)
                            {
                                _loc_2 = _loc_6[1];
                            }
                        }
                        _loc_5 = _loc_5 + 1;
                    }
                }
            }
            return _loc_2;
        }// end function

        public static function trim(param1:String) : String
        {
            return param1.replace(/(^\s*)|(\s*$)""(^\s*)|(\s*$)/g, "");
        }// end function

    }
}
