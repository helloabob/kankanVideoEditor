package easy.scr.sys.com.net.parser
{
    import easy.scr.pro.*;
    import easy.scr.sys.com.cmd.*;
    import easy.scr.sys.com.dat.*;
    import vsin.dcw.support.*;

    public class PlayUrlParser extends Object
    {
        private var dat:PlayDat;
        private static var count:int = 0;

        public function PlayUrlParser()
        {
            this.dat = ScrFactory.to.getCompIns(PlayDat);
            return;
        }// end function

        public function parse(param1:String, param2:int) : void
        {
			
			/*test*/
			this.dat.allPlayUrl[param2] = "http://101.227.173.13/sohu/s26h23eab6/3/38/189/Q8ZuPZRDDEqWYUerBXrOK1.mp4?key=fJVj4a6mKTCbWB4OGKLsDQIJ1ulOKn57YR8ASw..";
			var _loc_14:* = count + 1;
			count = _loc_14;
			if (count >= this.dat.clipUrls.length)
			{
				count = 0;
				ScrDispatcher.to.dispatch(new ScreenNetEvt(ScreenNetEvt.CLIP_ALL_URLS_LOADED));
			}
			return;
			/**/
			
            var _loc_12:Array = null;
            var _loc_3:* = /\?start=""\?start=/;
            var _loc_4:* = /http\:\/\/(.+?)\/\|([0-9]{1,4})\|(.+?)\|([^|]*)\|?([01]?)\|?([01]?)""http\:\/\/(.+?)\/\|([0-9]{1,4})\|(.+?)\|([^|]*)\|?([01]?)\|?([01]?)/;
            var _loc_5:* = _loc_3.test(this.dat.clipUrls[param2]);
            var _loc_6:* = this.dat.clipUrls[param2];
            var _loc_7:* = this.dat.syncUrls;
            var _loc_8:Boolean = false;
            var _loc_9:Boolean = false;
            var _loc_10:Boolean = false;
            var _loc_11:* = _loc_4.exec(param1);
            if (_loc_4.exec(param1) != null)
            {
                param1 = _loc_11[1];
            }
            if (_loc_11[5] && _loc_11[5] == "1" && _loc_7 != null && _loc_7.length > param2)
            {
                if (_loc_5)
                {
                    param1 = "http://" + param1 + _loc_7[param2] + "?" + _loc_6.split("?")[1];
                }
                else
                {
                    param1 = "http://" + param1 + _loc_7[param2];
                }
            }
            else if (_loc_11[5] && _loc_11[5] != "1" && _loc_10)
            {
                param1 = "http://" + _loc_6;
            }
            else if (_loc_11[5] && _loc_11[5] != "1" && _loc_8 && !_loc_9)
            {
                param1 = "http://" + param1;
            }
            else
            {
                _loc_12 = _loc_6.split("data.vod.itc.cn");
                if (_loc_12.length > 1 && param1 != "")
                {
                    param1 = _loc_6.replace("data.vod.itc.cn", param1);
                }
                else
                {
                    param1 = "http://" + param1 + _loc_6;
                }
            }
            if (_loc_11[4] && _loc_11[4] != "" && _loc_11[4] != "0")
            {
                if (_loc_5)
                {
                    param1 = param1 + ("&key=" + _loc_11[4]);
                }
                else
                {
                    param1 = param1 + ("?key=" + _loc_11[4]);
                }
            }
			trace("url:"+param1);
            Trace.log(param2, param1);
            this.dat.allPlayUrl[param2] = param1;
            var _loc_14:* = count + 1;
            count = _loc_14;
            if (count >= this.dat.clipUrls.length)
            {
                count = 0;
                ScrDispatcher.to.dispatch(new ScreenNetEvt(ScreenNetEvt.CLIP_ALL_URLS_LOADED));
            }
            return;
        }// end function

    }
}
