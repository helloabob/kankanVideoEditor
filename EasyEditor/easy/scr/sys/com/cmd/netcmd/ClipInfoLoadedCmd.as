package easy.scr.sys.com.cmd.netcmd
{
    import flash.utils.setTimeout;
    
    import easy.edit.sys.stg.EditViewFactory;
    import easy.edit.sys.stg.viw.layer.EditLayer;
    import easy.hub.evt.KeyFrEvt;
    import easy.scr.pro.ScrDispatcher;
    import easy.scr.pro.ScrFactory;
    import easy.scr.pro.ScrTeller;
    import easy.scr.sys.com.cmd.ScreenNetEvt;
    import easy.scr.sys.com.dat.PlayDat;
    
    import vsin.dcw.support.Trace;

    public class ClipInfoLoadedCmd extends Object
    {

        public function ClipInfoLoadedCmd(param1:ScreenNetEvt)
        {
			Trace.log("ClipInfoLoadedCmd");
//            var _loc_2:PlayDat = ScrFactory.to.getCompIns(PlayDat);
//            var _loc_3:* = _loc_2.clipUrls.length;
//            _loc_2.allPlayUrl = [];
//            var _loc_4:int = 0;
//            while (_loc_4 < _loc_3)
//            {
//                
//                new GetPlayUrl(_loc_4);
//                _loc_4++;
//            }
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
