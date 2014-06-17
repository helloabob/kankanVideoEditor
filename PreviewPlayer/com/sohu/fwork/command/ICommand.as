package com.sohu.fwork.command
{
    import com.sohu.fwork.baseagent.*;
	import com.sohu.fwork.notify.INotify;

    public interface ICommand extends INotify
    {

        public function ICommand();

        function trafficHandling(param1:NotifyData) : void;

    }
}
