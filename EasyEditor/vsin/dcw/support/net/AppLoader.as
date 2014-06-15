package vsin.dcw.support.net
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;

    public class AppLoader extends Object
    {
        private var data:Object;
        private var appLoader:Loader;
        private var progCb:Function;
        private var timeout:int = 10000;
        private var lastCheckProgress:Number = 0;
        private var progress:Number;
        private var timerId:int;
        private var _loadSucc:Boolean;
        private var _promise:Promise;
        public static const IO_ERR:String = "IO_ERR";
        public static const SECUR_ERR:String = "SECUR_ERR";
        public static const TIME_OUT:String = "TIME_OUT";
        public static const SUCC:String = "SUCC";

        public function AppLoader()
        {
            return;
        }// end function

        public function load(param1:Object, param2:int = 10, param3:Object = null, param4:Function = null) : Promise
        {
            var _loc_5:URLRequest = null;
            this._promise = new Promise();
            this.timeout = param2 * 1000;
            this.data = param3;
            this.progCb = param4;
            this.appLoader = new Loader();
            this.appLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
            this.appLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onComplete);
            this.appLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSercurityErr);
            this.appLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onIoErr);
            this.startTimer();
            if (param1 is String)
            {
                _loc_5 = new URLRequest(param1 as String);
                this.appLoader.load(_loc_5);
            }
            else if (param1 is ByteArray)
            {
                this.appLoader.loadBytes(param1 as ByteArray, new LoaderContext(false, ApplicationDomain.currentDomain));
            }
            return this._promise;
        }// end function

        private function onComplete(event:Event) : void
        {
            this._loadSucc = true;
            this.callbackShell(SUCC, event);
            return;
        }// end function

        private function onSercurityErr(event:SecurityErrorEvent) : void
        {
            this._loadSucc = false;
            this.callbackShell(SECUR_ERR, event);
            return;
        }// end function

        private function onIoErr(event:IOErrorEvent) : void
        {
            this._loadSucc = false;
            this.callbackShell(IO_ERR, event);
            return;
        }// end function

        private function onTimeout() : void
        {
            this._loadSucc = false;
            this.callbackShell(TIME_OUT, null);
            return;
        }// end function

        private function onProgress(event:ProgressEvent) : void
        {
            this.progress = Math.floor(event.bytesLoaded / event.bytesTotal * 100);
            if (this.progCb is Function)
            {
                this.progCb(this.progress);
            }
            return;
        }// end function

        private function startTimer() : void
        {
            this.timerId = setTimeout(this.onTimeOver, this.timeout);
            return;
        }// end function

        private function onTimeOver() : void
        {
            this.onTimeout();
            return;
        }// end function

        private function callbackShell(param1:String, param2:Event) : void
        {
            clearTimeout(this.timerId);
            if (this._loadSucc)
            {
                this._promise.resolve(param1, param2, this.appLoader, this.data);
            }
            else
            {
                this._promise.reject(param1, param2, this.appLoader, this.data);
            }
            this.dispose();
            return;
        }// end function

        private function dispose() : void
        {
            if (this.appLoader)
            {
                this.appLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.onProgress);
                this.appLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onComplete);
                this.appLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSercurityErr);
                this.appLoader.removeEventListener(IOErrorEvent.IO_ERROR, this.onIoErr);
                try
                {
                    this.appLoader.close();
                }
                catch (e:Error)
                {
                }
                this.appLoader = null;
                this.progCb = null;
                this.data = null;
                this._promise = null;
            }
            return;
        }// end function

    }
}
