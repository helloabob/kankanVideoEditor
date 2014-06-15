﻿package com.sohu.flashplayer.views
{
    import __AS3__.vec.*;
    import com.sohu.flashplayer.*;
    import com.sohu.flashplayer.commands.*;
    import com.sohu.flashplayer.inter_pack.hotvrs.*;
    import com.sohu.flashplayer.inter_pack.splayer.*;
    import com.sohu.flashplayer.util.*;
    import com.sohu.fwork.*;
    import com.sohu.fwork.baseagent.*;
    import com.sohu.fwork.view.*;
    import flash.events.*;
    import flash.external.*;
    import flash.media.*;
    import flash.net.*;

    public class SPlayer extends View implements IView, ISPlayer
    {
        private var videos:Vector.<VideoEx>;
        private var playVideoID:int = -1;
        private var hotVrsResp:HotVrsResp;
        private var seekTime:Number = 0;
        private var isSeek:Boolean = false;
        private var downLoadIndex:int = 1000000;
        private var medataWidth:int;
        private var medataHeight:int;
        private var replay:int = 0;
        public static const NAME:String = "SPlayer";
        public static const PLAY_SOON_EVENT:String = "PLAY_SOON_EVENT";
        public static const PLAY_TIME_EVENT:String = "PLAY_TIME_EVENT";
        public static const BYTES_LOADED_EVENT:String = "BYTESLOADED_EVENT";
        public static const PLAY_SWITCH_EVENT:String = "PLAY_SWITCH_EVENT";

        public function SPlayer()
        {
            this.videos = new Vector.<VideoEx>;
            return;
        }// end function

        public function init() : void
        {
            var _loc_1:VideoEx = null;
            var _loc_2:String = null;
            var _loc_3:Video = null;
            var _loc_4:NetStream = null;
            this.playVideoID = -1;
            for each (_loc_1 in this.videos)
            {
                
                this.removeChild(_loc_1);
                _loc_1.attachNetStream(null);
                if (_loc_1.netStream)
                {
                    this.netStreamRemoveEvent(_loc_1.netStream);
                    _loc_1.netStream.pause();
                }
                _loc_1.netStream = null;
                _loc_1 = null;
            }
            for (_loc_2 in Memory.streams)
            {
                
                _loc_4 = Memory.streams[_loc_2];
                if (_loc_4)
                {
                    _loc_4.close();
                }
                _loc_4 = null;
                delete Memory.streams[_loc_2];
            }
            this.videos.length = 0;
            this.videos.push(new VideoEx());
            this.videos.push(new VideoEx());
            for each (_loc_3 in this.videos)
            {
                
                this.addChild(_loc_3);
                _loc_3.visible = false;
                _loc_3.smoothing = true;
            }
            return;
        }// end function

        private function setVideoInit() : void
        {
            var _loc_1:VideoEx = null;
            for each (_loc_1 in this.videos)
            {
                
                _loc_1.visible = false;
                if (_loc_1.netStream)
                {
                    _loc_1.netStream.pause();
                }
                _loc_1.attachNetStream(null);
                _loc_1.isNotify = false;
                _loc_1.visible = false;
                _loc_1.isComplete = false;
                _loc_1.endl = false;
                this.netStreamRemoveEvent(_loc_1.netStream);
            }
            return;
        }// end function

        public function pause() : void
        {
            var _loc_1:* = this.getPlayVideo();
            if (_loc_1 && _loc_1.netStream)
            {
                _loc_1.netStream.pause();
            }
            return;
        }// end function

        public function resume() : void
        {
            var _loc_1:* = this.getPlayVideo();
            if (_loc_1 && _loc_1.netStream)
            {
                _loc_1.netStream.resume();
            }
            return;
        }// end function

        override public function get commands() : Array
        {
            return [GetHotVrsCommand.GET_VRS_RESULT];
        }// end function

        override public function update(param1:NotifyData) : void
        {
            this.hotVrsResp = param1.data as HotVrsResp;
            return;
        }// end function

        public function seek(param1:NetStream, param2:Number, param3:int, param4:Boolean = false) : void
        {
            this.isSeek = true;
            var _loc_5:* = this.getPlayVideo();
            if (this.getPlayVideo().netStream != param1)
            {
                this.setVideoInit();
                this.downLoadIndex = param3;
                this.playVideoID = 0;
                this.videos[0].attachNetStream(param1);
                this.videos[0].endl = param4;
                this.videos[0].netStream = param1;
                this.videos[0].seekTime = param2;
                this.videos[0].index = param3;
                param1.client = this;
                this.videos[0].visible = true;
                this.videos[0].netStream.resume();
                _loc_5 = this.getPlayVideo();
                this.netStreamAddEvent(this.videos[0].netStream);
                if (Memory.streams[param3])
                {
                    _loc_5.netStream.seek(param2);
                }
            }
            else if (_loc_5 != null)
            {
                _loc_5.isNotify = false;
                _loc_5.isComplete = false;
                _loc_5.seekTime = param2;
                _loc_5.index = param3;
                _loc_5.endl = param4;
                _loc_5.netStream.seek(param2);
            }
            this.seekTime = param2;
            var _loc_6:* = new NotifyData();
            new NotifyData().data = {index:_loc_5.index, seek:param2};
            this.dispatch(PLAY_SWITCH_EVENT, _loc_6);
            this.isSeek = false;
            return;
        }// end function

        public function play(param1:NetStream, param2:Number, param3:int, param4:Boolean = false) : void
        {
            var _loc_5:NotifyData = null;
            this.downLoadIndex = param3;
            this.seekTime = 0;
            if (this.playVideoID != 0)
            {
                this.videos[0].attachNetStream(param1);
                this.videos[0].endl = param4;
                this.videos[0].netStream = param1;
                this.videos[0].seekTime = param2;
                this.videos[0].index = param3;
                this.videos[0].isComplete = false;
                this.videos[0].isNotify = false;
            }
            else if (this.playVideoID == 0)
            {
                this.videos[1].attachNetStream(param1);
                this.videos[1].endl = param4;
                this.videos[1].netStream = param1;
                this.videos[1].seekTime = param2;
                this.videos[1].index = param3;
                this.videos[1].isComplete = false;
                this.videos[1].isNotify = false;
            }
            param1.client = this;
            this.netStreamAddEvent(param1);
            if (this.playVideoID == -1)
            {
                this.videos[0].netStream.resume();
                this.playVideoID = 0;
                this.videos[0].visible = true;
                _loc_5 = new NotifyData();
                _loc_5.data = {index:this.videos[0].index, seek:0};
                this.dispatch(PLAY_SWITCH_EVENT, _loc_5);
            }
            return;
        }// end function

        private function netStreamAddEvent(param1:NetStream) : void
        {
            if (!param1)
            {
                return;
            }
            if (param1.hasEventListener(NetStatusEvent.NET_STATUS) == false)
            {
                param1.addEventListener(NetStatusEvent.NET_STATUS, this.netStatusHandler, false, 0, true);
            }
            if (param1.hasEventListener(AsyncErrorEvent.ASYNC_ERROR) == false)
            {
                param1.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.asyncErrorHandler);
            }
            return;
        }// end function

        private function netStreamRemoveEvent(param1:NetStream) : void
        {
            if (!param1)
            {
                return;
            }
            if (param1.hasEventListener(NetStatusEvent.NET_STATUS))
            {
                param1.removeEventListener(NetStatusEvent.NET_STATUS, this.netStatusHandler, true);
            }
            if (param1.hasEventListener(AsyncErrorEvent.ASYNC_ERROR))
            {
                param1.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, this.asyncErrorHandler, true);
            }
            return;
        }// end function

        private function asyncErrorHandler(event:AsyncErrorEvent) : void
        {
            return;
        }// end function

        private function netStatusHandler(event:NetStatusEvent) : void
        {
            this.onPlayStatusHandler(event.info);
            return;
        }// end function

        private function getPlayVideo() : VideoEx
        {
            if (this.playVideoID < 0)
            {
                return null;
            }
            return this.videos[this.playVideoID];
        }// end function

        public function getPlayIndex() : int
        {
            var _loc_1:VideoEx = null;
            for each (_loc_1 in this.videos)
            {
                
                if (_loc_1.visible == true)
                {
                    return _loc_1.index;
                }
            }
            return 0;
        }// end function

        private function getDownLoadVideo() : VideoEx
        {
            var _loc_1:VideoEx = null;
            for each (_loc_1 in this.videos)
            {
                
                if (_loc_1.index == this.downLoadIndex)
                {
                    return _loc_1;
                }
            }
            return null;
        }// end function

        override public function enterFrame() : void
        {
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_5:NotifyData = null;
            var _loc_1:* = this.getDownLoadVideo();
            if (_loc_1 && _loc_1.seekTime == 0)
            {
                if (_loc_1.netStream.bytesLoaded == _loc_1.netStream.bytesTotal && !Memory.streams[_loc_1.index])
                {
                    Memory.streams[_loc_1.index] = _loc_1.netStream;
                }
            }
            var _loc_2:* = this.getPlayVideo();
            if (_loc_2)
            {
                _loc_3 = _loc_2.netStream.time;
                _loc_4 = this.hotVrsResp.times[_loc_2.index] - _loc_2.seekTime;
                if (Configer.AUTO_SEEK && _loc_2.isComplete == false)
                {
                    if (_loc_3 >= _loc_4)
                    {
                        this.onPlayStatusHandler({code:"NetStream.Play.Complete"});
                    }
                }
                if (_loc_4 - _loc_3 < 30 && _loc_2.isNotify == false)
                {
                    _loc_5 = new NotifyData();
                    _loc_2.isNotify = true;
                    this.dispatch(PLAY_SOON_EVENT, _loc_5);
                }
                if (this.isSeek)
                {
                    return;
                }
                _loc_5 = new NotifyData();
                _loc_5.data = new Object();
                _loc_5.data.playTime = _loc_2.netStream.time;
                _loc_5.data.index = _loc_2.index;
                this.dispatch(PLAY_TIME_EVENT, _loc_5);
                _loc_2 = this.getDownLoadVideo();
                if (_loc_2 == null)
                {
                    return;
                }
                _loc_5 = new NotifyData();
                _loc_5.data = new Object();
                _loc_5.data.bytesLoaded = _loc_2.netStream.bytesLoaded;
                _loc_5.data.totalBytes = _loc_2.netStream.bytesTotal;
                _loc_5.data.index = _loc_2.index;
                this.dispatch(BYTES_LOADED_EVENT, _loc_5);
            }
            return;
        }// end function

        public function onMetaData(param1:Object) : void
        {
            var _loc_4:VideoEx = null;
            var _loc_2:* = param1.seekpoints;
            this.medataWidth = param1.width;
            this.medataHeight = param1.height;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_3++;
            }
            for each (_loc_4 in this.videos)
            {
                
                _loc_4.width = this.medataWidth;
                _loc_4.height = this.medataHeight;
            }
            this.resize(this.stage.stageWidth, stage.stageHeight);
            return;
        }// end function

        public function onPlayStatusHandler(param1:Object) : void
        {
            var _loc_2:VideoEx = null;
            var _loc_3:NotifyData = null;
            var _loc_4:NotifyData = null;
            switch(param1.code)
            {
                case "NetStream.Play.Complete":
                {
                    _loc_2 = this.getPlayVideo();
                    if (_loc_2.isComplete)
                    {
                        return;
                    }
                    _loc_2.netStream.pause();
                    _loc_2.attachNetStream(null);
                    _loc_2.visible = false;
                    _loc_2.isComplete = true;
                    if (_loc_2.endl == true)
                    {
                        _loc_2.netStream.pause();
                        _loc_2.attachNetStream(null);
                        this.dispatch("VIDEO_PLAY_COMPLETE", null);
                        return;
                    }
                    if (this.playVideoID == 0)
                    {
                        this.playVideoID = 1;
                        _loc_2 = this.videos[this.playVideoID];
                        _loc_2.attachNetStream(_loc_2.netStream);
                        _loc_2.netStream.resume();
                        _loc_2.visible = true;
                    }
                    else
                    {
                        this.playVideoID = 0;
                        _loc_2 = this.videos[this.playVideoID];
                        _loc_2.attachNetStream(_loc_2.netStream);
                        _loc_2.netStream.resume();
                        _loc_2.visible = true;
                    }
                    _loc_3 = new NotifyData();
                    _loc_3.data = {index:_loc_2.index, seek:0};
                    this.dispatch(PLAY_SWITCH_EVENT, _loc_3);
                    break;
                }
                case "NetStream.Play.StreamNotFound":
                {
                    var _loc_5:String = this;
                    var _loc_6:* = this.replay + 1;
                    _loc_5.replay = _loc_6;
                    if (this.replay > 3)
                    {
                        _loc_4 = new NotifyData();
                        _loc_4.data = "当前段播放失败";
                        FWork.notify.sendNotify(ErrorPanelCommand.TOTIP, _loc_4);
                        return;
                    }
                    this.getPlayVideo().netStream.play(this.getPlayVideo().netStream.info.resourceName);
                    break;
                }
                case "NetStream.Play.Start":
                {
                    this.dispatch("NetStream.Play.Start", null);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function resize(param1:int, param2:int) : void
        {
            var _loc_3:VideoEx = null;
            var _loc_4:IProgress = null;
            for each (_loc_3 in this.videos)
            {
                
                if (this.medataWidth / this.medataHeight >= param1 / param2)
                {
                    _loc_3.width = param1;
                    _loc_3.height = this.medataHeight * param1 / this.medataWidth;
                }
                else
                {
                    _loc_3.height = param2;
                    _loc_3.width = this.medataWidth * param2 / this.medataHeight;
                }
                _loc_3.x = param1 / 2 - _loc_3.width / 2;
                _loc_3.y = 0;
            }
            this.graphics.clear();
            this.graphics.beginFill(0, 1);
            this.graphics.drawRect(0, 0, param1, _loc_3.height);
            this.graphics.endFill();
            _loc_4 = FWork.controller.getView(SProgressBar.NAME) as IProgress;
            if (_loc_3)
            {
                _loc_4.resize_ex(param1, _loc_3.height + 38);
            }
            if (JSUtil.available)
            {
                ExternalInterface.call("window.flashPreviewer.resize", _loc_3.width, int(395 + 38));
            }
            return;
        }// end function

    }
}

class VideoEx extends Video
{
    public var netStream:NetStream;
    public var isNotify:Boolean = false;
    public var isComplete:Boolean = false;
    public var endl:Boolean;
    public var seekTime:Number = 0;
    public var index:int = -1;

    function VideoEx()
    {
        return;
    }// end function

    override public function set visible(param1:Boolean) : void
    {
        super.visible = param1;
        return;
    }// end function

}

