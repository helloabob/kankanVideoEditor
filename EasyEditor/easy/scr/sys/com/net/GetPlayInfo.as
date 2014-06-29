package easy.scr.sys.com.net
{
    import easy.hub.spv.*;
    import easy.scr.pro.*;
    import easy.scr.sys.com.dat.*;
    import easy.scr.sys.com.net.parser.*;
    import vsin.dcw.support.*;
    import vsin.dcw.support.net.*;

    public class GetPlayInfo extends Object
    {
        protected const TIMEOUT:int = 10;
        protected var req:Request;
        protected var reqUrl:String;
        protected var retry:RetryValidator;

        public function GetPlayInfo()
        {
            this.retry = new RetryValidator(2, 1);
            this.req = new Request();
            this.buildReqUrl();
            this.retryFunc();
            return;
        }// end function

        protected function buildReqUrl() : void
        {
            var _loc_1:* = ScrFactory.to.getCompIns(PlayDat);
			if(_loc_1.vid==null)_loc_1.vid="http://127.0.0.1/video.php";
			this.reqUrl = _loc_1.vid;
//            this.reqUrl = "http://hot.vrs.sohu.com/vrs_flash.action" + "?vid=" + _loc_1.vid + "&kft=1" + "&t=" + new Date().time;
            return;
        }// end function

        protected function retryFunc() : void
        {
            this.req.load(this.reqUrl, this.TIMEOUT).then(this.httpCallback, this.httpFailback);
            return;
        }// end function

        protected function retryOverCb() : void
        {
            Trace.err("playinfo totally failed");
            return;
        }// end function

		/*p1:type p2:data p3:target*/
        protected function httpCallback(param1:String, param2:Object, param3:Request) : void
        {
            var rootDat:Object;
            var tip:InfoTipsMgr;
            var stat:* = param1;
            var dat:* = param2;
            var target:* = param3;
            var str:* = dat as String;
            try
            {
                rootDat = JSON.parse(str);
				if (Tools.objLen(rootDat))
                {
                    new PlayInfoParser().parse(rootDat);
                }
                else
                {
                    this.retry.canRetry(this.retryFunc, this.retryOverCb);
                }
                Trace.log("playinfo ok");
            }
            catch (e:Error)
            {
                tip = new InfoTipsMgr();
                tip.show("视频信息错误"+e.message);
            }
            return;
        }// end function

        protected function httpFailback(param1:String, param2:Object, param3:Request) : void
        {
            Trace.err("reload playinfo failed");
            this.retry.canRetry(this.retryFunc, this.retryOverCb);
            return;
        }// end function

    }
}
