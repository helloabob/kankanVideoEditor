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

    public class SeekCommand extends Notify implements ICommand
    {
        private var iProView:IView;
        private var iPlayView:ISPlayer;
        private var hotVrsResp:HotVrsResp;
        private var nc:NetConnection;
        private var index:int = 0;
        private var seekTime:Number;
		private var factory:MediaFactory;
        public static const SEEK_COMMAND:String = "SEEK_COMMAND";

        public function SeekCommand()
        {
            this.iProView = FWork.controller.getView(SProgressBar.NAME) as IView;
            this.iProView.addListener(SProgressBar.SEEK_EVENT, this.seekHandler);
            this.iPlayView = FWork.controller.getView(SPlayer.NAME) as ISPlayer;
			factory=new MediaFactory();
			factory.loadPlugin(new PluginInfoResource(new HLSPluginInfo()));
            return;
        }// end function

        public function trafficHandling(param1:NotifyData) : void
        {
            this.nc = new NetConnection();
            this.nc.connect(null);
            this.hotVrsResp = param1.data as HotVrsResp;
            return;
        }// end function

        private function seekHandler(param1:NotifyData) : void
        {
            var _loc_3:GetEntryReq = null;
            var _loc_4:Number = NaN;
            (FWork.controller.getView(LoadingView.NAME) as ILoading).show();
            var _loc_2:* = param1.data.value;
            if (this.hotVrsResp == null)
            {
                return;
            }
            (FWork.controller.getView(SProgressBar.NAME) as IProgress).updatePlayBtnStatus();
            this.seekTime = _loc_2 * this.hotVrsResp.totalDuration;
			/*support seek on hls reserved*/
			if(Configer.ishls){
				this.seekTime=Number(this.seekTime.toFixed(2));
				this.index=this.getPlayIndext(this.seekTime);
				var _loc_10:*=this.getPlayStartTime(this.index,this.seekTime);
				_loc_10=Number(_loc_10.toFixed(2));
				JSUtil.log("start find key for small:"+this.seekTime+"  original:"+_loc_10);
				var _loc_8:*=this.hotVrsResp.keyframes;
				var _loc_7:*=_loc_8.length-1;
				while(_loc_7>0){
					if(_loc_8[_loc_7]<_loc_10){
						break;
					}
					_loc_7=_loc_7-1;
				}
				JSUtil.log("find out last previous key:"+_loc_8[_loc_7]);
				var _loc_9:*=_loc_8[_loc_7];
				_loc_8=this.hotVrsResp.times;
				var _loc_11:*=this.hotVrsResp.starts;
				_loc_7=0;
				_loc_10=_loc_11.length-1;
				while(_loc_10>=0){
					if(_loc_11[_loc_10]<_loc_9)break;
					_loc_10=_loc_10-1;
				}
				var _loc_12:*=0;
				for(;_loc_7<_loc_10;_loc_7++){
					_loc_12=_loc_12+_loc_8[_loc_7];
				}
				this.seekTime=_loc_9-_loc_11[_loc_10]+_loc_12;
			}
			if(this.seekTime<0)this.seekTime=0;
			this.seekTime=Number(this.seekTime.toFixed(2));
            this.index = this.getPlayIndext(this.seekTime);
			JSUtil.log("start to seek:"+seekTime+"index:"+index);
            if (this.isGetEntry(this.index, this.seekTime))
            {
				JSUtil.log("true");
                _loc_3 = new GetEntryReq();
//                _loc_3.ip = this.hotVrsResp.ip;
//                _loc_3._new = this.hotVrsResp.news[this.index];
                _loc_3.file = this.hotVrsResp.files[this.index];
//                _loc_3.key = this.hotVrsResp.keys[this.index];
//                _loc_3.prot = this.hotVrsResp.prot;
				var nd:NotifyData = new NotifyData();
				nd.data = _loc_3.file;
				this.getEntryProxy(nd);
//                (FWork.controller.getProxy(GetEntryProxy.NAME) as GetEntryProxy).getData(_loc_3, this.getEntryProxy);
            }
            else
            {
				JSUtil.log("false");
                _loc_4 = this.getPlayStartTime(this.index, this.seekTime);
				JSUtil.log("getPlayStartTime_result:"+_loc_4);
                this.iPlayView.seek(Memory.streams[this.index], Configer.AUTO_SEEK ? (_loc_4 - this.hotVrsResp.starts[this.index]) : (_loc_4), this.index, this.index >= (this.hotVrsResp.files.length - 1));
            }
            return;
        }// end function

        private function isGetEntry(param1:int, param2:Number) : Boolean
        {
			return true;
            var _loc_3:* = Memory.streams[param1];
            if (_loc_3 == null)
            {
                return true;
            }
            if (_loc_3.bytesLoaded < _loc_3.bytesTotal)
            {
                return true;
            }
            return false;
        }// end function

        private function getPlayIndext(param1:Number) : int
        {
            var _loc_2:Number = 0;
            var _loc_3:int = 0;
            while (_loc_3 < this.hotVrsResp.times.length)
            {
                
                _loc_2 = _loc_2 + this.hotVrsResp.times[_loc_3];
                if (_loc_2 > param1)
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            return 0;
        }// end function

		/**
		 * @param param1 index
		 * @param param2 offset begins with new file
		 * @return offset begins with big file
		 */
        private function getPlayStartTime(param1:int, param2:Number) : Number
        {
            var _loc_3:Number = 0;
            var _loc_4:int = 0;
            while (_loc_4 < param1)
            {
                
                _loc_3 = _loc_3 + this.hotVrsResp.times[_loc_4];
                _loc_4++;
            }
            var _loc_5:Number = 0;
            if (Configer.AUTO_SEEK)
            {
                _loc_5 = param2 - _loc_3 + this.hotVrsResp.starts[param1];
            }
            else
            {
                _loc_5 = param2 - _loc_3;
            }
            return _loc_5;
        }// end function

        private function getEntryProxy(param1:NotifyData) : void
        {
//            var _loc_2:* = param1 as GetEntryResp;
//            var _loc_3:* = this.getPlayStartTime(this.index, this.seekTime);
//            var _loc_4:* = _loc_2.urlValues[0] + this.hotVrsResp.news[this.index] + "?key=" + _loc_2.urlValues[3] + "&start=" + _loc_3;
//            var _loc_4:* = param1.data+"?start="+_loc_3;
			var _loc_3:* = this.getPlayStartTime(this.index, this.seekTime);
			if(Configer.ishls){
				var _loc_1:* = _loc_3;
//				var _loc_1:*=this.hotVrsResp.starts[this.index];
				var _loc_2:* = param1.data+"?start="+_loc_1;
				JSUtil.log("seek_command_url:"+_loc_2+"index:"+this.index);
				var mediaPlayer:MediaPlayer=new MediaPlayer();
				mediaPlayer.media=factory.createMediaElement(new URLResource(_loc_2));
				mediaPlayer.pause();
				this.iPlayView.seek(mediaPlayer, _loc_1-this.hotVrsResp.starts[this.index], this.index, this.index >= (this.hotVrsResp.files.length - 1));
			}else{
				var _loc_4:* = param1.data+"?start="+_loc_3;
				JSUtil.log("seek_command_url:"+_loc_4+"index:"+this.index);
				var _loc_5:* = new NetStream(this.nc);
				_loc_5.play(_loc_4);
				_loc_5.pause();
				this.iPlayView.seek(_loc_5, Configer.AUTO_SEEK ? (_loc_3 - this.hotVrsResp.starts[this.index]) : (_loc_3), this.index, this.index >= (this.hotVrsResp.files.length - 1));
			}
            return;
        }// end function

    }
}
