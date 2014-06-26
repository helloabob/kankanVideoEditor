package com.sohu.flashplayer.proxys
{
    import com.sohu.flashplayer.inter_pack.getres.*;
    import com.sohu.fwork.proxy.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;

    public class GetResProxy extends Proxy implements IProxy
    {
        public static const NAME:String = "GET_RES_PROXY";

        public function GetResProxy()
        {
            return;
        }// end function

        override public function getData(param1:ProxyReq, param2:Function) : void
        {
            super.receive = param2;
            var _loc_3:* = param1["url"];
            var _loc_4:* = new Loader();
			_loc_4.contentLoaderInfo.addEventListener(Event.COMPLETE, this.loadCompleteHandler);
            _loc_4.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.ioErorHandler);
            _loc_4.load(new URLRequest(_loc_3));
            return;
        }// end function

        private function loadCompleteHandler(event:Event) : void
        {
            var _loc_2:* = event.currentTarget.content;
            var _loc_3:* = new GetResResp();
            _loc_3.data = _loc_2;
            super.receive(_loc_3);
            return;
        }// end function

        private function ioErorHandler(event:IOErrorEvent) : void
        {
            return;
        }// end function

    }
}
