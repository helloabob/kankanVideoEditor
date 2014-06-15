package com.sohu.fwork.command
{
    import com.sohu.fwork.baseagent.*;

    public interface ICommand extends INotify
    {

        public function ICommand();

        function trafficHandling(param1:NotifyData) : void;

    }
}
