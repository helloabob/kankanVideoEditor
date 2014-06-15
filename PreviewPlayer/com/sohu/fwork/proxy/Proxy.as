package com.sohu.fwork.proxy
{
    import com.sohu.fwork.baseagent.*;
    import com.sohu.fwork.notify.*;

    public class Proxy extends Notify implements IProxy
    {
        protected var receive:Function;

        public function Proxy()
        {
            return;
        }// end function

        public function getData(param1:ProxyReq, param2:Function) : void
        {
            this.receive = param2;
            return;
        }// end function

        override public function sendNotify(param1:String, param2:NotifyData) : void
        {
            if (param2 is ProxyResp)
            {
                this.receive(param2);
            }
            return;
        }// end function

    }
}
