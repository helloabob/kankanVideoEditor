package com.sohu.fwork.proxy
{

    public interface IProxy extends INotify
    {

        public function IProxy();

        function getData(param1:ProxyReq, param2:Function) : void;

    }
}
