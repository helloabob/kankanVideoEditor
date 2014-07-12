package com.sohu.flashplayer.commands
{
    import com.sohu.flashplayer.Configer;
    import com.sohu.flashplayer.inter_pack.entry.GetEntryReq;
    import com.sohu.flashplayer.inter_pack.hotvrs.HotVrsResp;
    import com.sohu.flashplayer.inter_pack.loading.ILoading;
    import com.sohu.flashplayer.inter_pack.splayer.IProgress;
    import com.sohu.flashplayer.inter_pack.splayer.ISPlayer;
    import com.sohu.flashplayer.util.Memory;
    import com.sohu.flashplayer.views.LoadingView;
    import com.sohu.flashplayer.views.SPlayer;
    import com.sohu.flashplayer.views.SProgressBar;
    import com.sohu.fwork.FWork;
    import com.sohu.fwork.JSUtil;
    import com.sohu.fwork.baseagent.NotifyData;
    import com.sohu.fwork.command.ICommand;
    import com.sohu.fwork.notify.Notify;
    import com.sohu.fwork.view.IView;
    
    import flash.net.NetConnection;
    import flash.net.NetStream;
    
    import org.osmf.media.MediaFactory;
    import org.osmf.media.MediaPlayer;
    import org.osmf.media.PluginInfoResource;
    import org.osmf.media.URLResource;
    import org.osmf.net.httpstreaming.hls.HLSPluginInfo;

    public class VideoCommand extends Notify implements ICommand
    {
        private var iPlayer:ISPlayer;
        private var iView:IView;
        private var iProgress:IView;
        private var index:int = 0;
        private var playIndex:int;
        private var nc:NetConnection;
        private var isComplete:Boolean = false;
        private var seek:Number = 0;
        private var hotVrsResp:HotVrsResp;
		private var factory:MediaFactory;
        public static const NAME:String = "VideoCommand";

        public function VideoCommand()
        {
            this.iPlayer = FWork.controller.getView(SPlayer.NAME) as ISPlayer;
            this.iView = FWork.controller.getView(SPlayer.NAME) as IView;
            this.iProgress = FWork.controller.getView(SProgressBar.NAME) as IView;
            this.iView.addListener(SPlayer.PLAY_SOON_EVENT, this.playSoonEvent);
            this.iView.addListener(SPlayer.BYTES_LOADED_EVENT, this.loadedHandler);
            this.iView.addListener(SPlayer.PLAY_TIME_EVENT, this.playedTimeHandler);
            this.iView.addListener(SPlayer.PLAY_SWITCH_EVENT, this.playSwitchHandler);
            this.iProgress.addListener(SProgressBar.PLAY_CTRL_EVENT, this.playHandler);
            this.iView.addListener("VIDEO_PLAY_COMPLETE", this.playComplete);
            this.iView.addListener("NetStream.Play.Start", this.playerHandler);
			factory=new MediaFactory();
			factory.loadPlugin(new PluginInfoResource(new HLSPluginInfo()));
            return;
        }// end function

        private function playerHandler(param1:NotifyData) : void
        {
            (FWork.controller.getView(SProgressBar.NAME) as IProgress).updatePlayBtnStart();
            return;
        }// end function

        private function playComplete(param1:NotifyData) : void
        {
            this.isComplete = true;
            (FWork.controller.getView(SProgressBar.NAME) as IProgress).updatePlayBtnComplete();
            return;
        }// end function

        private function playHandler(param1:NotifyData) : void
        {
            if (this.isComplete)
            {
                this.isComplete = false;
                this.index = 0;
                this.playIndex = 0;
                this.iPlayer.init();
                this.getEntry();
                return;
            }
			JSUtil.log("playHandler:"+param1.code);
            switch(param1.code)
            {
                case 1:
                {
                    this.iPlayer.resume();
                    break;
                }
                case 0:
                {
                    this.iPlayer.pause();
                    break;
                }
                default:
                {
                    break;
                }
            }
            JSUtil.log("played  "+param1.code);
            return;
        }// end function

        private function playedTimeHandler(param1:NotifyData) : void
        {
            if (param1.data.index != this.playIndex)
            {
                return;
            }
            var _loc_2:* = FWork.controller.getView(SProgressBar.NAME) as IProgress;
            var _loc_3:* = this.oldPlayedProgressTime();
            var _loc_4:* = param1.data.playTime;
            _loc_2.updatePlayProgress((_loc_4 + _loc_3) / this.hotVrsResp.totalDuration);
            _loc_2.updateTime(_loc_4 + _loc_3, this.hotVrsResp.totalDuration);
            return;
        }// end function

        private function loadedHandler(param1:NotifyData) : void
        {
            if (param1.data.index != this.index)
            {
                return;
            }
            var _loc_2:* = FWork.controller.getView(SProgressBar.NAME) as IProgress;
            var _loc_3:* = this.oldLoadedProgressBytes();
            var _loc_4:* = param1.data.bytesLoaded;
            _loc_2.updateDownLoadProgress((_loc_4 + _loc_3) / this.hotVrsResp.totalBytes);
            return;
        }// end function

        private function playSwitchHandler(param1:NotifyData) : void
        {
            this.playIndex = param1.data.index;
            this.index = param1.data.index;
            var _loc_2:* = Memory.streams;
            if (_loc_2[this.index])
            {
                this.seek = 0;
            }
            else
            {
                this.seek = param1.data.seek;
            }
            var _loc_3:* = FWork.controller.getView(SProgressBar.NAME) as IProgress;
            _loc_3.updateSeekStatus(false);
            (FWork.controller.getView(LoadingView.NAME) as ILoading).high();
            return;
        }// end function

        public function oldPlayedProgressTime() : Number
        {
            var _loc_1:Number = 0;
            var _loc_2:int = 0;
            while (_loc_2 < this.playIndex)
            {
                
                _loc_1 = _loc_1 + this.hotVrsResp.times[_loc_2];
                _loc_2++;
            }
            return _loc_1 + this.seek;
        }// end function

        private function oldLoadedProgressBytes() : int
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            while (_loc_2 < this.index)
            {
                
                _loc_1 = _loc_1 + this.hotVrsResp.byteLens[_loc_2];
                _loc_2++;
            }
            return _loc_1 + this.seek / this.hotVrsResp.times[this.index] * this.hotVrsResp.byteLens[this.index];
        }// end function

        public function trafficHandling(param1:NotifyData) : void
        {
            this.index = 0;
            this.nc = new NetConnection();
            this.nc.connect(null);
            this.hotVrsResp = param1.data as HotVrsResp;
            this.iPlayer.init();
            this.getEntry();
            return;
        }// end function

        private function getEntry() : void
        {
            var _loc_1:* = new GetEntryReq();
//            _loc_1.ip = this.hotVrsResp.ip;
//            _loc_1._new = this.hotVrsResp.news[this.index];
            _loc_1.file = this.hotVrsResp.files[this.index];
//            _loc_1.key = this.hotVrsResp.keys[this.index];
//            _loc_1.prot = this.hotVrsResp.prot;
//            (FWork.controller.getProxy(GetEntryProxy.NAME) as GetEntryProxy).getData(_loc_1, this.getEntryProxy);
			var nd:NotifyData = new NotifyData();
			nd.data = _loc_1.file;
			this.getEntryProxy(nd);
            return;
        }// end function

        private function getEntryProxy(param1:NotifyData) : void
        {
			JSUtil.log("VideoCommand_getEntryProxy_url:"+param1.data);
//            var _loc_2:* = param1 as GetEntryResp;
//            var _loc_3:* = _loc_2.urlValues[0] + this.hotVrsResp.news[this.index] + "?key=" + _loc_2.urlValues[3];
            var _loc_3:* = param1.data;
			if (Configer.AUTO_SEEK)
            {
                _loc_3 = _loc_3 + ("?start=" + this.hotVrsResp.starts[this.index]);
            }
			JSUtil.log("video_command_url:"+_loc_3);
			if(Configer.ishls){
				var mediaPlayer:MediaPlayer=new MediaPlayer();
				mediaPlayer.media=factory.createMediaElement(new URLResource(_loc_3));
				mediaPlayer.pause();
				if (this.index >= (this.hotVrsResp.files.length - 1))
				{
					this.iPlayer.play(mediaPlayer, 0, this.index, true);
				}
				else
				{
					this.iPlayer.play(mediaPlayer, 0, this.index);
				}
			}else{
				var _loc_4:* = new NetStream(this.nc);
				_loc_4.play(_loc_3);
				_loc_4.pause();
				if (this.index >= (this.hotVrsResp.files.length - 1))
				{
					this.iPlayer.play(_loc_4, 0, this.index, true);
				}
				else
				{
					this.iPlayer.play(_loc_4, 0, this.index);
				}
			}
            
            return;
        }// end function

        private function playSoonEvent(param1:NotifyData) : void
        {
            this.index = this.index + 1;
            this.getEntry();
            return;
        }// end function

    }
}
