package com.sohu.fwork.notify
{
    import com.sohu.fwork.baseagent.*;

    public interface INotify
    {

        public function INotify();

        function sendNotify(param1:String, param2:NotifyData) : void;

    }
}
