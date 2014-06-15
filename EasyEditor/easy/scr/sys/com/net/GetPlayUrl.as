package easy.scr.sys.com.net
{
    import easy.scr.pro.*;
    import easy.scr.sys.com.dat.*;
    import easy.scr.sys.com.net.parser.*;
    import flash.net.*;
    import vsin.dcw.support.*;
    import vsin.dcw.support.net.*;

    public class GetPlayUrl extends Object
    {
        protected const TIMEOUT:int = 10;
        private var vars:URLVariables;
        protected var req:Request;
        protected var reqUrl:String;
        protected var retry:RetryValidator;
        private var dat:PlayDat;
        private var clipId:int;

        public function GetPlayUrl(param1:int)
        {
            this.dat = ScrFactory.to.getCompIns(PlayDat);
            this.req = new Request();
            this.getUrl(param1);
            return;
        }// end function

        protected function getUrl(param1:int) : void
        {
            this.clipId = param1;
            this.retry = new RetryValidator(2, 1);
            this.buildReqUrl();
            this.retryFunc();
            return;
        }// end function

        protected function buildReqUrl() : void
        {
            this.reqUrl = "http://" + this.dat.redirectIp + "/" + "?prot=2" + "&file=" + this.getUrlPath(this.dat.clipUrls[this.clipId]) + "&new=" + this.dat.syncUrls[this.clipId] || "" + "&key=" + this.dat.keys[this.clipId] + "&t=" + new Date().time;
            Trace.log(this.clipId, this.reqUrl);
            return;
        }// end function

        protected function retryFunc() : void
        {
            this.req.load(this.reqUrl, this.TIMEOUT).then(this.httpCallback, this.httpFailback);
            return;
        }// end function

        protected function retryOverCb() : void
        {
            Trace.err("playurl totally failed");
            return;
        }// end function

        protected function httpCallback(param1:String, param2:Object, param3:Request) : void
        {
            var _loc_4:* = param2 as String;
            if (param2 as String)
            {
                if (_loc_4 === "quick")
                {
                    Trace.err("QUICK mode");
                    this.retry.canRetry(this.retryFunc, this.retryOverCb);
                }
                else
                {
                    new PlayUrlParser().parse(_loc_4, this.clipId);
                }
            }
            else
            {
                Trace.err("bad direct url");
                this.retry.canRetry(this.retryFunc, this.retryOverCb);
            }
            return;
        }// end function

        protected function httpFailback(param1:String, param2:Object, param3:Request) : void
        {
            Trace.err("reload playurl failed");
            this.retry.canRetry(this.retryFunc, this.retryOverCb);
            return;
        }// end function

        protected function getUrlPath(param1:String) : String
        {
            if (!param1 || param1 == null || param1 == "")
            {
                return "";
            }
            param1 = param1.replace("http://data.vod.itc.cn", "");
            return param1.split("?")[0];
        }// end function

    }
}
