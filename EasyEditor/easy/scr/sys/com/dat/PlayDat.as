package easy.scr.sys.com.dat
{
    import flash.net.*;
    
    import vsin.dcw.support.*;

    public class PlayDat extends Object
    {
        public var vid:String;
        public var tvName:String;
        public var totDuration:Number;
        public var totBytes:Number;
        public var clipDurArr:Array;
        public var clipByteArr:Array=new Array();
        public var curClipIdx:int = 0;
        public var curPlayUrl:String;
        public var curSeekUrl:String;
        public var nexPlayUrl:String;
        public var allPlayUrl:Array=new Array();
        public var curConn:NetConnection;
        public var curStm:NetStream;
        public var defaultVolume:Number = 80;
        public var defaultBufTime:Number = 4;
        public var curVolume:Number;
        public var redirectIp:String;
        public var playInfo:Object;
        public var hashIds:Array;
        public var keys:Array;
        public var syncUrls:Array;
        public var clipUrls:Array=new Array();
        public var metaWidth:Number;
        public var metaHeight:Number;
        public var keyFrameInfo:Array=new Array();
        public var clipSeekMark:Array=new Array();
        public var lastSeekToClipTime:Number = 0;

        public function PlayDat()
        {
            return;
        }// end function

        public function updateInfo(param1:int) : void
        {
            this.curClipIdx = param1;
            this.curPlayUrl = this.allPlayUrl[this.curClipIdx];
            this.nexPlayUrl = this.allPlayUrl[(this.curClipIdx + 1)];
            Trace.log("update cur url :: " + this.curPlayUrl);
            return;
        }// end function

        public function calcEntireFlyTime() : Number
        {
            var _loc_1:Number = 0;
            var _loc_2:int = 0;
            while (_loc_2 < this.curClipIdx)
            {
                
                _loc_1 = _loc_1 + this.clipDurArr[_loc_2];
                _loc_2++;
            }
			trace("PlayDat_calc_loc_1:"+_loc_1+"time:"+this.curStm.time);
            _loc_1 = _loc_1 + (this.curStm.time + this.lastSeekToClipTime);
            return _loc_1;
        }// end function

        public function calcEntireBytesLoaded() : Number
        {
            var _loc_1:Number = 0;
            var _loc_2:int = 0;
            while (_loc_2 < this.curClipIdx)
            {
                
                _loc_1 = _loc_1 + this.clipByteArr[_loc_2];
                _loc_2++;
            }
            _loc_1 = _loc_1 + this.curStm.bytesLoaded;
			return _loc_1;
        }// end function

        public function isDead() : Boolean
        {
            Trace.log("isDead", this.totDuration + " / " + this.calcEntireFlyTime() + " / " + this.totDuration * 0.01 + " / " + this.lastSeekToClipTime);
            return Math.abs(this.totDuration - this.calcEntireFlyTime()) < this.totDuration * 0.01;
        }// end function

        public function transClipProgToFlyTime(param1:int, param2:Number) : Number
        {
            var _loc_3:* = this.clipDurArr[param1] * param2;
            var _loc_4:Number = 0;
            var _loc_5:int = 0;
            while (_loc_5 <= (param1 - 1))
            {
                
                _loc_4 = _loc_4 + this.clipDurArr[_loc_5];
                _loc_5++;
            }
            return _loc_4 + _loc_3;
        }// end function

        public function transProgToClipIdAndFlyTime(param1:Number) : Array
        {
            var _loc_2:* = param1 * this.totDuration;
            var _loc_3:Number = 0;
            var _loc_4:int = 0;
            var _loc_5:Number = 0;
            var _loc_6:int = 0;
            while (_loc_6 < this.clipDurArr.length)
            {
                
                if (_loc_3 < _loc_2)
                {
                    _loc_4 = _loc_6;
                    _loc_5 = _loc_2 - _loc_3;
                }
                else
                {
                    break;
                }
                _loc_3 = _loc_3 + this.clipDurArr[_loc_6];
                _loc_6++;
            }
            return [_loc_4, _loc_5, _loc_2];
        }// end function

        public function isEndOfClip(param1:int, param2:Number) : Boolean
        {
            return Math.abs(param2 - this.clipDurArr[param1]) < 2;
        }// end function

        public function buildSeekUrl(param1:int, param2:Number) : void
        {
            var _loc_3:* = "http://" + this.redirectIp + "/" + "?prot=1" + "&file=" + this.getUrlPath(this.clipUrls[param1]) + "&new=" + (this.syncUrls[param1] || "") + "&start=" + param2;
            Trace.log("seekurl " + param1, _loc_3);
            this.curSeekUrl = _loc_3;
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
