package easy.edit.sys.com.net
{
    import easy.edit.pro.*;
    import easy.edit.sys.com.cmd.*;
    import easy.edit.sys.com.dat.*;
    import easy.hub.spv.*;
    import vsin.dcw.support.*;
    import vsin.dcw.support.net.*;

    public class GetHotSpot extends Object
    {
        protected const TIMEOUT:int = 10;
        protected var req:Request;
        protected var reqUrl:String;
        protected var retry:RetryValidator;

        public function GetHotSpot()
        {
            this.retry = new RetryValidator(2, 1);
            this.req = new Request();
            this.buildReqUrl();
            this.retryFunc();
            return;
        }// end function

        protected function buildReqUrl() : void
        {
            var _loc_1:* = EditFactory.to.getCompIns(EditDat);
            this.reqUrl = "http://my.tv.sohu.com/user/a/wvideo/cloudEditor/vrshot.do" + "?vid=" + _loc_1.vid + "&t=" + new Date().time;
            return;
        }// end function

        protected function retryFunc() : void
        {
            this.req.load(this.reqUrl, this.TIMEOUT).then(this.httpCallback, this.httpFailback);
            return;
        }// end function

        protected function retryOverCb() : void
        {
            Trace.err("hotspot totally failed");
            var _loc_1:* = new InfoTipsMgr();
            _loc_1.show("热点接口失败");
            return;
        }// end function

        protected function httpCallback(param1:String, param2:Object, param3:Request) : void
        {
            var tip:InfoTipsMgr;
            var rootDat:Object;
            var eDat:EditDat;
            var type:* = param1;
            var dat:* = param2;
            var target:* = param3;
            tip = new InfoTipsMgr();
            var str:* = dat as String;
            try
            {
                rootDat = JSON.parse(str);
            }
            catch (e:Error)
            {
                tip.show("热点接口出错");
                return;
            }
            Trace.log("hotspot ok");
            if (rootDat && rootDat.status == 200)
            {
                if (Tools.objLen(rootDat.attachment))
                {
                    eDat = EditFactory.to.getCompIns(EditDat);
                    eDat.hotspot = rootDat.attachment;
                    EditDispatcher.to.dispatch(new EditNetEvt(EditNetEvt.HOT_SPOT_LOADED));
                }
                else
                {
                    tip.show("热点数据缺失");
                }
            }
            else
            {
                this.retry.canRetry(this.retryFunc, this.retryOverCb);
            }
            return;
        }// end function

        protected function httpFailback(param1:String, param2:Object, param3:Request) : void
        {
            Trace.err("reload hotspot failed");
            this.retry.canRetry(this.retryFunc, this.retryOverCb);
            return;
        }// end function

    }
}
