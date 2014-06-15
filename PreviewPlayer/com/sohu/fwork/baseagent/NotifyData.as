﻿package com.sohu.fwork.baseagent
{
    import avmplus.*;
    import com.sohu.fwork.view.*;
    import flash.net.*;
    import flash.utils.*;

    public class NotifyData extends Object
    {
        public var code:int = -1;
        public var view:View;
        public var data:Object;

        public function NotifyData()
        {
            return;
        }// end function

        public function clone() : NotifyData
        {
            var _loc_1:* = getQualifiedClassName(this);
            var _loc_2:* = _loc_1.split("::")[0];
            var _loc_3:* = getDefinitionByName(_loc_1) as Class;
            registerClassAlias(_loc_2, _loc_3);
            if (this.view)
            {
                _loc_1 = getQualifiedClassName(this.view);
                _loc_2 = _loc_1.split("::")[0];
                _loc_3 = getDefinitionByName(_loc_1) as Class;
                registerClassAlias(_loc_2, _loc_3);
            }
            if (this.data)
            {
                _loc_1 = getQualifiedClassName(this.data);
                _loc_2 = _loc_1.split("::")[0];
                _loc_3 = getDefinitionByName(_loc_1) as Class;
                registerClassAlias(_loc_2, _loc_3);
            }
            var _loc_4:* = new ByteArray();
            new ByteArray().writeObject(this);
            _loc_4.position = 0;
            return _loc_4.readObject();
        }// end function

        public function toString() : String
        {
            var _loc_2:String = null;
            var _loc_1:String = "";
            for (_loc_2 in this.data)
            {
                
                _loc_1 = _loc_2 + ":" + String(this.data[_loc_2]);
            }
            return _loc_1;
        }// end function

    }
}
