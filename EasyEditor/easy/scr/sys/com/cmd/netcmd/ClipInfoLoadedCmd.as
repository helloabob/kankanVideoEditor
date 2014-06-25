package easy.scr.sys.com.cmd.netcmd
{
    import easy.hub.evt.*;
    import easy.scr.pro.*;
    import easy.scr.sys.com.cmd.*;
    import easy.scr.sys.com.dat.*;
    import easy.scr.sys.com.net.*;
    
    import flash.utils.setTimeout;

    public class ClipInfoLoadedCmd extends Object
    {

        public function ClipInfoLoadedCmd(param1:ScreenNetEvt)
        {
			trace("ClipInfoLoadedCmd");
            var _loc_2:PlayDat = ScrFactory.to.getCompIns(PlayDat);
//            var _loc_3:* = _loc_2.clipUrls.length;
//            _loc_2.allPlayUrl = [];
//            var _loc_4:int = 0;
//            while (_loc_4 < _loc_3)
//            {
//                
//                new GetPlayUrl(_loc_4);
//                _loc_4++;
//            }
            var _loc_5:KeyFrEvt = new KeyFrEvt(KeyFrEvt.KEY_FRAME_LOADED);
            _loc_5.totTime = _loc_2.totDuration;
            _loc_5.totBytes = _loc_2.totBytes;
            _loc_5.keyFrDat = _loc_2.keyFrameInfo;
            _loc_5.tvName = _loc_2.tvName;
            _loc_5.clipDurArr = _loc_2.clipDurArr;
            ScrFactory.to.getCompIns(ScrTeller).dispatchEvent(_loc_5);
			
			setTimeout(dispatchLoaded,500);
            return;
        }
		
		private function dispatchLoaded():void{
			var pd:PlayDat = ScrFactory.to.getCompIns(PlayDat);
			pd.allPlayUrl=pd.clipUrls;
			ScrDispatcher.to.dispatch(new ScreenNetEvt(ScreenNetEvt.CLIP_ALL_URLS_LOADED));
		}
    }
}
