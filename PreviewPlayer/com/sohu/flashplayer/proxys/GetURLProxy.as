package com.sohu.flashplayer.proxys
{
    import com.sohu.flashplayer.inter_pack.geturl.*;
    import com.sohu.fwork.*;
    import com.sohu.fwork.proxy.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
	import com.sohu.fwork.proxy.IProxy;
	import com.sohu.fwork.proxy.Proxy;

    public class GetURLProxy extends Proxy implements IProxy
    {
        private var queueCallBack:Dictionary;
        private var _seq:int = 0;
        public static const NAME:String = "GetURLProxy";

        public function GetURLProxy()
        {
            this.queueCallBack = new Dictionary(true);
            return;
        }// end function

        override public function getData(param1:ProxyReq, param2:Function) : void
        {
            var _loc_3:* = new URLRequest((param1 as GetURLReq).urlRequest.url);
            _loc_3.method = (param1 as GetURLReq).urlRequest.method;
            _loc_3.data = (param1 as GetURLReq).urlRequest.data;
            var _loc_4:* = new URLLoaderEx();
			_loc_4.dataFormat = URLLoaderDataFormat.TEXT;
            _loc_4.addEventListener(Event.COMPLETE, this.urlLoaderCompleteHandler);
            _loc_4.addEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
            _loc_4.seq = this.getSeq();
            if (param2 != null)
            {
                this.queueCallBack[_loc_4.seq] = param2;
            }
            _loc_4.load(_loc_3);
            JSUtil.log(_loc_3.url);
            return;
        }// end function

        private function ioErrorHandler(event:IOErrorEvent) : void
        {
            return;
        }// end function

        private function urlLoaderCompleteHandler(event:Event) : void
        {
			JSUtil.log("GetURLProxy_urlLoaderCompleteHandler");
            var _loc_2:* = event.currentTarget as URLLoaderEx;
            var _loc_3:* = this.queueCallBack[_loc_2.seq] as Function;
            if (_loc_3 != null)
            {
				JSUtil.log("GetURLProxy_urlLoaderCompleteHandler_not_null");
                _loc_3(_loc_2.data);
                _loc_3 = null;
                delete this.queueCallBack[_loc_2.seq];
            }
            _loc_2 = null;
            return;
        }// end function

        private function getSeq() : int
        {
			this._seq = this._seq + 1;
            return this._seq;
        }// end function

    }
}

import flash.net.URLLoader;

class URLLoaderEx extends URLLoader
{
    public var seq:int;

    function URLLoaderEx()
    {
        return;
    }// end function

}

