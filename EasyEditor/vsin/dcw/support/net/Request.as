package vsin.dcw.support.net
{
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class Request extends Object
    {
        public var bindDat:Object;
        public var spendTime:Number = 0;
        private var _loaderUrl:URLLoader;
        private var _loadedSucc:Boolean = false;
        private var _setTimeoutId:Number = 0;
        private var _promise:Promise;
        public static const SECURITY_ERR:String = "SECURITY_ERR";
        public static const SUCCESS:String = "SUCCESS";
        public static const IO_ERR:String = "IO_ERR";
        public static const TIMEOUT:String = "TIMEOUT";

        public function Request()
        {
            return;
        }// end function

        public function load(param1:String, param2:Number, param3:Object = null, param4:URLVariables = null) : Promise
        {
            this.bindDat = param3;
            this._promise = new Promise();
            this._loaderUrl = this._loaderUrl || new URLLoader();
            this._loaderUrl.dataFormat = URLLoaderDataFormat.TEXT;
            this.addEvent();
            var _loc_5:* = new URLRequest(param1);
            if (param4 != null)
            {
                _loc_5.method = URLRequestMethod.POST;
                _loc_5.data = param4;
            }
            this.spendTime = getTimer();
            this._loaderUrl.load(_loc_5);
            this._setTimeoutId = setTimeout(this.timeoverHandler, param2 * 1000);
            return this._promise;
        }// end function

        public function close() : void
        {
            try
            {
                this._loaderUrl.close();
            }
            catch (evt:Error)
            {
            }
            this.removeEvent();
            this._promise = null;
            this._loaderUrl = null;
            this.bindDat = null;
            return;
        }// end function

        private function completeHandler(event:Event) : void
        {
            this._loadedSucc = true;
            this.callbackShell({type:SUCCESS, target:this, data:event.target.data});
            return;
        }// end function

        private function securityErrorHandler(event:SecurityErrorEvent) : void
        {
            this._loadedSucc = false;
            this.callbackShell({type:SECURITY_ERR, target:this});
            return;
        }// end function

        private function ioErrorHandler(event:IOErrorEvent) : void
        {
            this._loadedSucc = false;
            this.callbackShell({type:IO_ERR, target:this});
            return;
        }// end function

        private function timeoverHandler() : void
        {
            return;
        }// end function

        private function httpStatusHandler(event:HTTPStatusEvent) : void
        {
            return;
        }// end function

        private function callbackShell(param1:Object) : void
        {
            clearTimeout(this._setTimeoutId);
            this.spendTime = this.spendTime - getTimer();
            if (this._loadedSucc)
            {
                this._promise.resolve(param1.type, param1.data, param1.target);
            }
            else
            {
                this._promise.reject(param1.type, param1.data, param1.target);
            }
            this.close();
            return;
        }// end function

        private function removeEvent() : void
        {
            this._loaderUrl.removeEventListener(Event.COMPLETE, this.completeHandler);
            this._loaderUrl.removeEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
            this._loaderUrl.removeEventListener(HTTPStatusEvent.HTTP_STATUS, this.httpStatusHandler);
            this._loaderUrl.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
            return;
        }// end function

        private function addEvent() : void
        {
            this._loaderUrl.addEventListener(Event.COMPLETE, this.completeHandler);
            this._loaderUrl.addEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
            this._loaderUrl.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.httpStatusHandler);
            this._loaderUrl.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
            return;
        }// end function

    }
}
