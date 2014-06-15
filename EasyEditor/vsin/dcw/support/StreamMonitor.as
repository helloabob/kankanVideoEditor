package vsin.dcw.support
{
    import flash.net.*;
    import flash.utils.*;

    public class StreamMonitor extends Object
    {

        public function StreamMonitor()
        {
            return;
        }// end function

        public function output(param1:NetStream, param2:String, param3:Boolean, param4:Boolean) : void
        {
            var _loc_5:Function = null;
            var _loc_6:Function = null;
            var _loc_7:Function = null;
            var _loc_16:XML = null;
            var _loc_17:String = null;
            var _loc_18:String = null;
            if (param3)
            {
                _loc_5 = Trace.refreshEx;
                _loc_6 = Trace.cleanMonitorEx;
                _loc_7 = Trace.flushMonitorEx;
            }
            else
            {
                _loc_5 = Trace.refresh;
                _loc_6 = Trace.cleanMonitor;
                _loc_7 = Trace.flushMonitor;
            }
            var _loc_8:* = param1.info;
            var _loc_9:Object = {};
            if (param4)
            {
                _loc_9 = param1["videoStreamSettings"];
            }
            this._loc_6();
            this._loc_5(param2);
            var _loc_10:* = describeType(param1);
            var _loc_11:* = describeType(param1).accessor;
            var _loc_12:* = describeType(_loc_8);
            var _loc_13:* = describeType(_loc_8).accessor;
            var _loc_14:* = describeType(_loc_9);
            var _loc_15:* = describeType(_loc_9).accessor;
            for each (_loc_16 in _loc_11)
            {
                
                _loc_17 = _loc_16.@name;
                _loc_18 = _loc_16.@type;
                if (_loc_18 == "Number")
                {
                    this._loc_5(_loc_17, Math.ceil(param1[_loc_17]));
                    continue;
                }
                if (_loc_17 != "audioSampleAccess" && _loc_17 != "videoSampleAccess" && (_loc_18 == "String" || _loc_18 == "uint" || _loc_18 == "Boolean"))
                {
                    this._loc_5(_loc_17, param1[_loc_17]);
                }
            }
            for each (_loc_16 in _loc_15)
            {
                
                _loc_17 = _loc_16.@name;
                if (_loc_16.@type == "Number")
                {
                    this._loc_5(_loc_17, Math.ceil(_loc_9[_loc_17]));
                    continue;
                }
                this._loc_5(_loc_17, _loc_9[_loc_17]);
            }
            for each (_loc_16 in _loc_13)
            {
                
                _loc_17 = _loc_16.@name;
                if (_loc_16.@type == "Number")
                {
                    this._loc_5(_loc_17, Math.ceil(_loc_8[_loc_17]));
                    continue;
                }
                this._loc_5(_loc_17, _loc_8[_loc_17]);
            }
            if (param4)
            {
                this._loc_5("");
                this._loc_5("metaData:");
                for (_loc_17 in _loc_8["metaData"])
                {
                    
                    this._loc_5(_loc_17, _loc_8["metaData"][_loc_17]);
                }
                this._loc_5("");
                this._loc_5("xmpData:");
                for (_loc_17 in _loc_8["xmpData"])
                {
                    
                    this._loc_5(_loc_17, _loc_8["xmpData"][_loc_17]);
                }
            }
            this._loc_7();
            return;
        }// end function

        public function cleanOutput() : void
        {
            Trace.cleanMonitor();
            Trace.flushMonitor();
            return;
        }// end function

    }
}
