package com.sohu.fwork.view
{
    import com.sohu.fwork.baseagent.*;
	import com.sohu.fwork.clistener.IClistener;

    public interface IView extends IClistener
    {

        public function IView();

        function get commands() : Array;

        function update(param1:NotifyData) : void;

        function enterFrame() : void;

        function resize(param1:int, param2:int) : void;

    }
}
