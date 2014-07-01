package easy.scr.sys.com.net.parser
{
    import easy.hub.spv.*;
    import easy.scr.pro.*;
    import easy.scr.sys.com.cmd.*;
    import easy.scr.sys.com.dat.*;
    import vsin.dcw.support.*;

    public class PlayInfoParser extends Object
    {
        private var pDat:PlayDat;

        public function PlayInfoParser()
        {
            this.pDat = ScrFactory.to.getCompIns(PlayDat);
            return;
        }// end function

        public function parse(param1:Object) : void
        {
			var _loc_1:* = null;
            var _loc_3:Array = null;
            var _loc_4:Boolean = false;
            var _loc_5:String = null;
            var _loc_2:* = new InfoTipsMgr();
			if(!param1.kft||!param1.videoURL||!param1.duration||!param1.totalBytes){
				_loc_2.show("接口错误(#1)");
				return;
			}else{
				Trace.log("play_info_did_loaded");
//				this.pDat.redirectIp = param1.allot;
//				this.pDat.playInfo = param1;
//				this.pDat.keys = param1.data.ck;
//				this.pDat.hashIds = param1.data.hc;
//				this.pDat.syncUrls = param1.data.su || [];
				if(param1.epg&&param1.epg.length>0)_loc_1=JSON.stringify(param1.epg);
				this.pDat.clipUrls = [param1.videoURL];
				this.pDat.totBytes = param1.totalBytes;
				this.pDat.clipByteArr = [param1.totalBytes];
				this.pDat.totDuration = param1.duration;
				this.pDat.clipDurArr = [param1.duration];
				this.pDat.keyFrameInfo = [param1.kft];
				this.pDat.tvName = param1.videoName;
				this.pDat.epg = _loc_1;
				this.pDat.clipSeekMark = [];
				if(String(param1.videoURL).indexOf(".m3u8")>0)this.pDat.ishls=true;
				ScrDispatcher.to.dispatch(new ScreenNetEvt(ScreenNetEvt.CLIP_INFO_LOADED));
				return;
			}
            if (param1.data)
            {
                _loc_3 = param1.data.kft;
                if (!_loc_3)
                {
                    _loc_2.show("关键帧信息错误(#1)");
                    return;
                }
                if (!_loc_3.length)
                {
                    _loc_2.show("关键帧信息错误(#3)");
                    return;
                }
                _loc_4 = true;
                for each (_loc_5 in _loc_3)
                {
                    
                    if (!_loc_5)
                    {
                        _loc_4 = false;
                        break;
                    }
                }
                if (!_loc_4)
                {
                    _loc_2.show("关键帧信息错误(#2)");
                    return;
                }
                if (!param1.prot || param1.prot == 2)
                {
                    this.pDat.redirectIp = param1.allot;
                    this.pDat.playInfo = param1.data;
                    this.pDat.keys = param1.data.ck;
                    this.pDat.hashIds = param1.data.hc;
                    this.pDat.syncUrls = param1.data.su || [];
                    this.pDat.clipUrls = param1.data.clipsURL;
                    this.pDat.totBytes = param1.data.totalBytes;
                    this.pDat.clipByteArr = param1.data.clipsBytes;
                    this.pDat.totDuration = param1.data.totalDuration;
                    this.pDat.clipDurArr = param1.data.clipsDuration;
                    this.pDat.keyFrameInfo = _loc_3;
                    this.pDat.tvName = param1.data.tvName;
                    this.pDat.clipSeekMark = [];
                    ScrDispatcher.to.dispatch(new ScreenNetEvt(ScreenNetEvt.CLIP_INFO_LOADED));
                }
                else
                {
                    _loc_2.show("播放信息错误(#2)");
                }
            }
            else
            {
                Trace.err("incorrect prot value");
                _loc_2.show("播放信息错误(#1)");
            }
            return;
        }// end function

    }
}
