package com.sohu.flashplayer.proxys
{
    import com.sohu.flashplayer.inter_pack.entry.*;
    import com.sohu.flashplayer.inter_pack.geturl.*;
    import com.sohu.fwork.*;
    import com.sohu.fwork.proxy.*;
    import flash.net.*;

    public class GetEntryProxy extends Proxy implements IProxy
    {
        public static const NAME:String = "GetEntryProxy";

        public function GetEntryProxy()
        {
            return;
        }// end function

        override public function getData(param1:ProxyReq, param2:Function) : void
        {
            super.receive = param2;
            var _loc_3:* = param1 as GetEntryReq;
            var _loc_4:* = "http://" + _loc_3.ip + "/?" + "prot=" + _loc_3.prot + "&file=" + _loc_3.file + "&new=" + _loc_3._new + "&key=" + _loc_3.key;
            var _loc_5:* = new GetURLReq();
            new GetURLReq().urlRequest = new URLRequest(_loc_4);
            (FWork.controller.getProxy(GetURLProxy.NAME) as GetURLProxy).getData(_loc_5 as ProxyReq, this.completeCallBack);
            return;
        }// end function

        private function completeCallBack(param1:String) : void
        {
            var _loc_2:* = new GetEntryResp();
            _loc_2.urlValues = param1.split("|");
            this.receive(_loc_2);
            return;
        }// end function

    }
}
