package com.sohu.fwork.clistener
{
    import com.sohu.fwork.baseagent.*;

    public interface IClistener
    {

        public function IClistener();

        function addListener(param1:String, param2:Function) : void;

        function removeListener(param1:String, param2:Function) : void;

        function hasListener(param1:String) : Boolean;

        function dispatch(param1:String, param2:NotifyData, param3:Boolean = false) : void;

    }
}
