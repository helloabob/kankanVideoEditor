package com.sohu.flashplayer.commands
{
    import com.sohu.flashplayer.*;
    import com.sohu.flashplayer.inter_pack.entry.*;
    import com.sohu.flashplayer.inter_pack.hotvrs.*;
    import com.sohu.flashplayer.inter_pack.loading.*;
    import com.sohu.flashplayer.inter_pack.splayer.*;
    import com.sohu.flashplayer.proxys.*;
    import com.sohu.flashplayer.util.*;
    import com.sohu.flashplayer.views.*;
    import com.sohu.fwork.*;
    import com.sohu.fwork.baseagent.*;
    import com.sohu.fwork.notify.*;
    import com.sohu.fwork.view.*;
    import flash.net.*;

    public class SeekCommand extends Notify implements ICommand
    {
        private var iProView:IView;
        private var iPlayView:ISPlayer;
        private var hotVrsResp:HotVrsResp;
        private var nc:NetConnection;
        private var index:int = 0;
        private var seekTime:Number;
        public static const SEEK_COMMAND:String = "SEEK_COMMAND";

        public function SeekCommand()
        {
            this.iProView = FWork.controller.getView(SProgressBar.NAME) as IView;
            this.iProView.addListener(SProgressBar.SEEK_EVENT, this.seekHandler);
            this.iPlayView = FWork.controller.getView(SPlayer.NAME) as ISPlayer;
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
            this.index = this.getPlayIndext(this.seekTime);
            if (this.isGetEntry(this.index, this.seekTime))
            {
                _loc_3 = new GetEntryReq();
                _loc_3.ip = this.hotVrsResp.ip;
                _loc_3._new = this.hotVrsResp.news[this.index];
                _loc_3.file = this.hotVrsResp.files[this.index];
                _loc_3.key = this.hotVrsResp.keys[this.index];
                _loc_3.prot = this.hotVrsResp.prot;
                (FWork.controller.getProxy(GetEntryProxy.NAME) as GetEntryProxy).getData(_loc_3, this.getEntryProxy);
            }
            else
            {
                _loc_4 = this.getPlayStartTime(this.index, this.seekTime);
                this.iPlayView.seek(Memory.streams[this.index], Configer.AUTO_SEEK ? (_loc_4 - this.hotVrsResp.starts[this.index]) : (_loc_4), this.index, this.index >= (this.hotVrsResp.files.length - 1));
            }
            return;
        }// end function

        private function isGetEntry(param1:int, param2:Number) : Boolean
        {
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
            var _loc_2:* = param1 as GetEntryResp;
            var _loc_3:* = this.getPlayStartTime(this.index, this.seekTime);
            var _loc_4:* = _loc_2.urlValues[0] + this.hotVrsResp.news[this.index] + "?key=" + _loc_2.urlValues[3] + "&start=" + _loc_3;
            var _loc_5:* = new NetStream(this.nc);
            new NetStream(this.nc).play(_loc_4);
            _loc_5.pause();
            this.iPlayView.seek(_loc_5, Configer.AUTO_SEEK ? (_loc_3 - this.hotVrsResp.starts[this.index]) : (_loc_3), this.index, this.index >= (this.hotVrsResp.files.length - 1));
            return;
        }// end function

    }
}
