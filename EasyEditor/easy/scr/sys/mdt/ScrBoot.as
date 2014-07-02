package easy.scr.sys.mdt
{
    import easy.hub.evt.*;
    import easy.hub.spv.*;
    import easy.scr.pro.*;
    import easy.scr.sys.com.cmd.*;
    import easy.scr.sys.com.cmd.netcmd.*;
    import easy.scr.sys.com.cmd.stmCmd.*;
    import easy.scr.sys.com.cmd.workcmd.*;
    import easy.scr.sys.com.cpt.*;
    import easy.scr.sys.com.dat.*;
    import easy.scr.sys.com.net.*;
    import easy.scr.sys.stg.viw.*;
    
    import flash.display.*;

    public class ScrBoot extends Object
    {

        public function ScrBoot(param1:Object, param2:Stage, param3:DisplayObject)
        {
            ScrFactory.to.tracingCreating = true;
            ScrDispatcher.to.tracingEvt = true;
            ScrFactory.to.registComp(ScrTeller);
            ScrFactory.to.registComp(PlayDat);
            ScrFactory.to.registComp(ConnectStm);
            ScrFactory.to.registComp(NetStmMgr);
            ScrFactory.to.registComp(TimeMgr);
            ScrFactory.to.registComp(SeekMgr);
            ScrDispatcher.to.addCmd(ScreenNetEvt, ScreenNetEvt.CLIP_INFO_LOADED, ClipInfoLoadedCmd);
            ScrDispatcher.to.addCmd(ScreenNetEvt, ScreenNetEvt.CLIP_ALL_URLS_LOADED, ClipAllUrlsLoadedCmd);
            ScrDispatcher.to.addCmd(ScreenNetEvt, ScreenNetEvt.CONNECTED, ConnectedCmd);
            ScrDispatcher.to.addCmd(ScreenStmEvt, ScreenStmEvt.PLAY_START, PlayStartCmd);
            ScrDispatcher.to.addCmd(ScreenStmEvt, ScreenStmEvt.PAUSE, PauseCmd);
            ScrDispatcher.to.addCmd(ScreenStmEvt, ScreenStmEvt.RESUME, ResumeCmd);
            ScrDispatcher.to.addCmd(ScreenStmEvt, ScreenStmEvt.META_LOADED, MetaLoadedCmd);
            ScrDispatcher.to.addCmd(ScreenStmEvt, ScreenStmEvt.BUF_FULL, BufferFullCmd);
            ScrDispatcher.to.addCmd(ScreenStmEvt, ScreenStmEvt.BUF_EMPTY, BufferEmptyCmd);
            ScrDispatcher.to.addCmd(ScreenStmEvt, ScreenStmEvt.STM_NOT_FOUND, StmNotFoundCmd);
            ScrDispatcher.to.addCmd(ScreenStmEvt, ScreenStmEvt.PLAY_OVER, PlayOverCmd);
            ScrDispatcher.to.addCmd(ScreenStmEvt, ScreenStmEvt.PLAY_OVER_CLIP, PlayOverClipCmd);
            ScrDispatcher.to.addCmd(ScreenStmEvt, ScreenStmEvt.BEFORE_PLAY, BeforePlayCmd);
            ScrDispatcher.to.addCmd(ScreenStmEvt, ScreenStmEvt.SEEK_NEED_RE_DISPATCHING, ReDispatchingCmd);
            ScrDispatcher.to.addCmd(ScreenStmEvt, ScreenStmEvt.SEEK_IN_CLIP, SeekInClipCmd);
            ScrDispatcher.to.addCmd(ScreenStmEvt, ScreenStmEvt.SEEK_BETWEEN_CLIP, SeekBetweenClipCmd);
            ScrDispatcher.to.addCmd(ScreenStmEvt, ScreenStmEvt.SEEK_PLAY_START, SeekPlayStartCmd);
            ScrDispatcher.to.addCmd(WorkEvt, WorkEvt.SEEK, ToSeekCmd);
            ScrDispatcher.to.addCmd(WorkEvt, WorkEvt.RESUME, ToResumeCmd);
            ScrDispatcher.to.addCmd(WorkEvt, WorkEvt.PAUSE, ToPauseCmd);
            var _loc_4:* = ScrFactory.to.getCompIns(PlayDat);
            ScrFactory.to.getCompIns(PlayDat).vid = param1.vid;
            var _loc_5:* = ScrFactory.to.getCompIns(NetStmMgr);
            var _loc_6:* = new NetStmAdv("[StreamA]");
            var _loc_7:* = new NetStmAdv("[StreamB]");
            _loc_5.init(_loc_6, _loc_7);
            var _loc_8:Screen = new Screen();
            var _loc_9:* = new Screen();
            var _loc_10:* = param3 as Sprite;
            (param3 as Sprite).addChild(_loc_8);
            _loc_10.addChild(_loc_9);
            var _loc_11:* = new ScreenMediator(param3 as Sprite, _loc_8, _loc_9);
            _loc_8.init("[VideoA]");
            _loc_9.init("[VideoB]");
            var _loc_12:* = LoadingMgr.getIns();
            LoadingMgr.getIns().resize(param2.stageWidth, param2.stageHeight);
            _loc_12.show(LoadingMgr.OPEN);
            new GetPlayInfo();
			
//			var pd:PlayDat = ScrFactory.to.getCompIns(PlayDat);
//			pd.clipUrls[0]="http://domhttp.kksmg.com/2012/09/15/h264_450k_mp4_0717609ae3a6426eb1012167def9131e_2158948.mp4";
//			pd.allPlayUrl[0]="http://domhttp.kksmg.com/2012/09/15/h264_450k_mp4_0717609ae3a6426eb1012167def9131e_2158948.mp4";
//			pd.curPlayUrl="http://domhttp.kksmg.com/2012/09/15/h264_450k_mp4_0717609ae3a6426eb1012167def9131e_2158948.mp4";
//			new ClipAllUrlsLoadedCmd(new ScreenNetEvt(ScreenNetEvt.CLIP_ALL_URLS_LOADED));
            
			return;
        }// end function

    }
}
