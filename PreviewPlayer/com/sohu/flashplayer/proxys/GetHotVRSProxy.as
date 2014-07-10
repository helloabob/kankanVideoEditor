package com.sohu.flashplayer.proxys
{
    import com.sohu.flashplayer.*;
    import com.sohu.flashplayer.inter_pack.geturl.*;
    import com.sohu.flashplayer.inter_pack.hotvrs.*;
    import com.sohu.flashplayer.util.*;
    import com.sohu.fwork.*;
    import com.sohu.fwork.proxy.*;
    import flash.net.*;

    public class GetHotVRSProxy extends Proxy implements IProxy
    {
        public static const NAME:String = "GetHotVRSProxy";

        public function GetHotVRSProxy()
        {
            return;
        }// end function

        override public function getData(param1:ProxyReq, param2:Function) : void
        {
            super.receive = param2;
			var _loc_3:* = Configer.vid;
//            var _loc_3:* = Configer.HOST_PATH + (param1 as HotVrsReq).vid;
            var _loc_4:* = new GetURLReq();
            _loc_4.urlRequest = new URLRequest(_loc_3);
            (FWork.controller.getProxy(GetURLProxy.NAME) as GetURLProxy).getData(_loc_4 as ProxyReq, this.completeCallBack);
            return;
        }// end function

        private function completeCallBack(param1:String) : void
        {
            var _loc_4:String = null;
            var _loc_5:String = null;
            var _loc_6:String = null;
            var _loc_7:Number = NaN;
            var _loc_8:int = 0;
            var _loc_9:String = null;
            var _loc_10:String = null;
            var _loc_2:* = JSON.parse(param1);
            var _loc_3:* = new HotVrsResp();
			if(String(_loc_2.videoURL).indexOf(".m3u8")>=0)Configer.ishls=true;
//            _loc_3.prot = _loc_2.prot;
//            _loc_3.ip = _loc_2.allot;
//            if (!_loc_2.data)
//            {
//                return;
//            }
            _loc_3.files = [_loc_2.videoURL];
//            for each (_loc_4 in _loc_2.data.clipsURL)
//            {
//                
//                _loc_9 = "data.vod.itc.cn";
//                _loc_10 = _loc_4.substring(_loc_4.indexOf(_loc_9) + _loc_9.length);
//                _loc_3.files.push(_loc_10);
//            }
//            _loc_3.keys = [];
//            for each (_loc_5 in _loc_2.data.ck)
//            {
//                
//                _loc_3.keys.push(_loc_5);
//            }
//            _loc_3.news = [];
//            for each (_loc_6 in _loc_2.data.su)
//            {
//                
//                _loc_3.news.push(_loc_6);
//            }
            _loc_3.times = [_loc_2.duration];
//            for each (_loc_7 in _loc_2.data.clipsDuration)
//            {
//                
//                _loc_3.times.push(_loc_7);
//            }
            _loc_3.byteLens = [_loc_2.totalBytes];
			_loc_3.totalBytes = _loc_2.totalBytes;
			_loc_3.totalDuration = _loc_2.duration;
//            for each (_loc_8 in _loc_2.data.clipsBytes)
//            {
//                
//                _loc_3.byteLens.push(_loc_8);
//            }
//            _loc_3.totalBytes = _loc_2.data.totalBytes;
//            _loc_3.totalDuration = _loc_2.data.totalDuration;
            if (Configer.AUTO_SEEK)
            {
                _loc_3 = this.updateAutoSeekData(_loc_3);
            }
            this.receive(_loc_3);
            return;
        }// end function

        private function updateAutoSeekData(param1:HotVrsResp) : HotVrsResp
        {
            var _loc_4:int = 0;
            var _loc_6:Object = null;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_11:int = 0;
            var _loc_2:* = Memory.autoSeek;
            var _loc_3:* = new HotVrsResp();
            _loc_3.prot = param1.prot;
            _loc_3.ip = param1.ip;
            _loc_3.files = [];
            _loc_3.keys = [];
            _loc_3.news = [];
            _loc_3.times = [];
            _loc_3.byteLens = [];
            _loc_3.starts = [];
            _loc_3.totalDuration = 0;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_2.length)
            {
                
                _loc_6 = _loc_2[_loc_5];
                _loc_7 = _loc_6.start;
                _loc_8 = _loc_6.total;
                _loc_9 = this.getVideoIndex(_loc_7, param1.times);
                _loc_10 = this.getVideoIndex(_loc_7 + _loc_8, param1.times);
                if (_loc_9 != _loc_10)
                {
                    _loc_3.starts.push(this.getPlayStartTime(_loc_9, _loc_7, param1.times));
                    _loc_3.files.push(param1.files[_loc_9]);
                    _loc_3.keys.push(param1.keys[_loc_9]);
                    _loc_3.news.push(param1.news[_loc_9]);
                    _loc_3.times.push(this.getHeaderVideoLength(_loc_9, _loc_7, param1.times));
                    _loc_3.byteLens.push(this.getVideoMakingBytes(_loc_9, _loc_3.times[(_loc_3.times.length - 1)], param1.byteLens, param1.times));
                    _loc_4 = _loc_4 + _loc_3.byteLens[(_loc_3.byteLens.length - 1)];
                    _loc_11 = _loc_9 + 1;
                    while (_loc_11 < _loc_10)
                    {
                        
                        _loc_3.starts.push(0);
                        _loc_3.files.push(param1.files[_loc_11]);
                        _loc_3.keys.push(param1.keys[_loc_11]);
                        _loc_3.news.push(param1.news[_loc_11]);
                        _loc_3.times.push(param1.times[_loc_11]);
                        _loc_3.byteLens.push(param1.byteLens[_loc_11]);
                        _loc_4 = _loc_4 + _loc_3.byteLens[(_loc_3.byteLens.length - 1)];
                        _loc_11++;
                    }
                    _loc_3.starts.push(0);
                    _loc_3.files.push(param1.files[_loc_10]);
                    _loc_3.keys.push(param1.keys[_loc_10]);
                    _loc_3.news.push(param1.news[_loc_10]);
                    _loc_3.times.push(this.getBottomVideoLength(_loc_10, _loc_7, _loc_8, param1.times));
                    _loc_3.byteLens.push(this.getVideoMakingBytes(_loc_10, _loc_3.times[(_loc_3.times.length - 1)], param1.byteLens, param1.times));
                    _loc_4 = _loc_4 + _loc_3.byteLens[(_loc_3.byteLens.length - 1)];
                }
                else
                {
                    _loc_3.starts.push(this.getPlayStartTime(_loc_9, _loc_7, param1.times));
                    _loc_3.files.push(param1.files[_loc_9]);
//                    _loc_3.keys.push(param1.keys[_loc_9]);
//                    _loc_3.news.push(param1.news[_loc_9]);
                    _loc_3.times.push(_loc_8);
					//_loc_9=0  _loc_8=total
                    _loc_3.byteLens.push(this.getVideoMakingBytes(_loc_9, _loc_8, param1.byteLens, param1.times));
                    _loc_4 = _loc_4 + _loc_3.byteLens[(_loc_3.byteLens.length - 1)];
                }
                _loc_3.totalDuration = _loc_3.totalDuration + _loc_8;
                _loc_3.totalBytes = _loc_4;
                _loc_5++;
            }
            return _loc_3;
        }// end function

        private function getVideoMakingBytes(param1:int, param2:int, param3:Array, param4:Array) : int
        {
            var _loc_5:* = param3[param1];
            var _loc_6:* = param3[param1] / param4[param1];
            var _loc_7:* = param3[param1] / param4[param1] * param2;
            return param3[param1] / param4[param1] * param2;
        }// end function

        private function getHeaderVideoLength(param1:int, param2:Number, param3:Array) : Number
        {
            var _loc_4:Number = 0;
            var _loc_5:int = 0;
            while (_loc_5 <= param1)
            {
                
                _loc_4 = _loc_4 + param3[_loc_5];
                _loc_5++;
            }
            return _loc_4 - param2;
        }// end function

        private function getBottomVideoLength(param1:int, param2:Number, param3:Number, param4:Array) : Number
        {
            var _loc_5:* = param2 + param3;
            var _loc_6:Number = 0;
            var _loc_7:int = 0;
            while (_loc_7 < param1)
            {
                
                _loc_6 = _loc_6 + param4[_loc_7];
                _loc_7++;
            }
            return _loc_5 - _loc_6;
        }// end function

        private function getPlayStartTime(param1:int, param2:Number, param3:Array) : Number
        {
            var _loc_4:Number = 0;
            var _loc_5:int = 0;
            while (_loc_5 < param1)
            {
                
                _loc_4 = _loc_4 + param3[_loc_5];
                _loc_5++;
            }
            return param2 - _loc_4;
        }// end function

        private function getVideoIndex(param1:Number, param2:Array) : int
        {
            var _loc_3:Number = 0;
            var _loc_4:int = 0;
            while (_loc_4 < param2.length)
            {
                
                _loc_3 = _loc_3 + param2[_loc_4];
                if (_loc_3 >= param1)
                {
                    return _loc_4;
                }
                _loc_4++;
            }
            return 0;
        }// end function

    }
}
