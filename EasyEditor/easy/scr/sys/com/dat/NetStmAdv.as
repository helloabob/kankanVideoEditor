﻿package easy.scr.sys.com.dat
{
    import easy.hub.evt.*;
    import easy.hub.spv.*;
    import easy.scr.pro.*;
    import easy.scr.sys.com.cmd.*;
    import easy.scr.sys.com.cpt.*;
    import easy.scr.sys.com.dat.def.*;
    
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    
    import vsin.dcw.support.*;

    public class NetStmAdv extends Object
    {
        public var stream:NetStream;
        protected var handlingClipId:int;
        protected var handlingPlayUrl:String;
        protected var name:String;
        protected var isActive:Boolean = false;
        protected var seekStart:Boolean = false;
        protected var inStream:Boolean = false;
        protected var mutedCoff:int = 1;
        protected var curVol:Number = 0;
        protected var seekPoints:Array;
        protected var dat:PlayDat;
        protected var seekMgr:SeekMgr;
        protected var lastSeekToClip:Number = 0;
        protected var autoSeekPoint:Number = -1;
        private static var lastSeekToClipBytes:Number = 0;

        public function NetStmAdv(param1:String)
        {
            this.name = param1;
            this.dat = ScrFactory.to.getCompIns(PlayDat);
            this.seekMgr = ScrFactory.to.getCompIns(SeekMgr);
            return;
        }// end function

        public function play(param1:String, param2:int) : void
        {
            this.handlingClipId = param2;
            this.handlingPlayUrl = param1;
            this.registStmEvt();
            this.stream.play(param1);
            this.inStream = true;
            if (param1.indexOf("start") === -1)
            {
                this.resetSeekParam();
                this.dat.clipSeekMark[this.handlingClipId] = 0;
            }
            return;
        }// end function

        public function initStream() : void
        {
            if (!this.stream)
            {
                this.seekMgr.init();
                this.stream = new NetStream(this.dat.curConn);
                this.stream.client = {onMetaData:this.onMetaData};
                Trace.log(this.name + " init volume", this.dat.defaultVolume);
                this.volTo(this.dat.defaultVolume);
            }
            return;
        }// end function

        public function resume() : void
        {
            this.stream.resume();
            return;
        }// end function

        public function pause() : void
        {
            this.stream.pause();
            return;
        }// end function

        public function muted(param1:Boolean) : void
        {
            if (param1)
            {
                this.mutedCoff = 0;
            }
            else
            {
                this.mutedCoff = 1;
            }
            this.volTo(this.curVol);
            return;
        }// end function

        public function volTo(param1:Number) : void
        {
            var _loc_2:* = this.stream.soundTransform;
            _loc_2.volume = this.mutedCoff * (param1 / 100);
            this.stream.soundTransform = _loc_2;
            Trace.log(this.name + " set play volume", param1 + " / " + _loc_2.volume);
            this.dat.curVolume = param1;
            this.curVol = param1;
            return;
        }// end function

        public function timeUpdate(param1:TimerEvt) : void
        {
            param1.flyTime = this.dat.calcEntireFlyTime();
            param1.datLoaded = this.dat.calcEntireBytesLoaded() + lastSeekToClipBytes;
//			trace("flyTime:"+param1.flyTime+"datLoaded:"+param1.datLoaded+"handlingClipId:"+this.handlingClipId);
            this.seekMgr.clipDownloadReport(this.handlingClipId, this.stream.bytesLoaded);
            return;
        }// end function

        public function getName() : String
        {
            return this.name;
        }// end function

        public function activate(param1:Boolean) : void
        {
            this.isActive = param1;
            return;
        }// end function

        protected function dispatchProxy(param1:ScreenStmEvt) : void
        {
			ScrDispatcher.to.dispatch(param1);
            return;
        }// end function

        protected function registStmEvt() : void
        {
            if (!this.stream.hasEventListener(NetStatusEvent.NET_STATUS))
            {
                this.stream.addEventListener(NetStatusEvent.NET_STATUS, this.netStatusHandler);
            }
            if (!this.stream.hasEventListener(AsyncErrorEvent.ASYNC_ERROR))
            {
				trace("NetStmAdv_registStmEvt_async_error");
                this.stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.asyncErrorHandler);
            }
            return;
        }// end function

        protected function netStatusHandler(event:NetStatusEvent) : void
        {
            var _loc_2:Boolean = false;
            Trace.err(this.name + " " + event.info.code);
            switch(event.info.code)
            {
                case NetStats.NetStream_Play_Start:
                {
                    if (this.seekStart)
                    {
                        if (this.autoSeekPoint > -1)
                        {
                            Trace.log("autoSeekPoint");
                            this.stream.seek(this.autoSeekPoint);
                            this.autoSeekPoint = -1;
                            this.handlingClipId = this.lastSeekToClip;
                        }
                        Trace.log(this.name + " seek, start avoid");
                        this.dispatchProxy(new ScreenStmEvt(ScreenStmEvt.SEEK_PLAY_START));
                    }
                    else
                    {
                        this.dispatchProxy(new ScreenStmEvt(ScreenStmEvt.PLAY_START));
                    }
                    break;
                }
                case NetStats.NetStream_Pause_Notify:
                {
                    this.dispatchProxy(new ScreenStmEvt(ScreenStmEvt.PAUSE));
                    break;
                }
                case NetStats.NetStream_Unpause_Notify:
                {
                    this.dispatchProxy(new ScreenStmEvt(ScreenStmEvt.RESUME));
                    break;
                }
                case NetStats.NetStream_Buffer_Full:
                {
                    this.seekStart = false;
                    this.dispatchProxy(new ScreenStmEvt(ScreenStmEvt.BUF_FULL));
                    this.stream.bufferTime = this.dat.defaultBufTime;
                    break;
                }
                case NetStats.NetStream_Buffer_Empty:
                {
                    this.dispatchProxy(new ScreenStmEvt(ScreenStmEvt.BUF_EMPTY));
                    break;
                }
                case NetStats.NetStream_Play_Stop:
                {
                    _loc_2 = this.dat.isDead();
                    this.resetSeekParam();
                    if (!this.inStream)
                    {
                        return;
                    }
                    this.inStream = false;
                    if (_loc_2)
                    {
                        this.dispatchProxy(new ScreenStmEvt(ScreenStmEvt.PLAY_OVER));
                    }
                    else
                    {
                        this.dispatchProxy(new ScreenStmEvt(ScreenStmEvt.PLAY_OVER_CLIP));
                    }
                    this.closeStream();
                    break;
                }
                case NetStats.NetStream_Play_StreamNotFound:
                {
                    this.dispatchProxy(new ScreenStmEvt(ScreenStmEvt.STM_NOT_FOUND));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function closeStream() : void
        {
            try
            {
                this.stream.removeEventListener(NetStatusEvent.NET_STATUS, this.netStatusHandler);
                this.stream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, this.asyncErrorHandler);
                this.stream.close();
            }
            catch (e:Error)
            {
                Trace.log(name, e.errorID + " :: " + e.message);
            }
            return;
        }// end function

        protected function asyncErrorHandler(event:AsyncErrorEvent) : void
        {
            Trace.log(this.name + " AsyncErrorEvent");
            return;
        }// end function

        protected function onMetaData(param1:Object) : void
        {
			trace("----------start----------");
			for(var key:* in param1){
				trace("key:"+key+"|value:"+param1[key]);
				if(key=="seekpoints"){
					for(var child:* in param1[key]){
						trace("spk:"+child+"|value:"+param1[key][child]);
					}
				}
			}
			var sps:*=param1.seekpoints;
			var kfs:Array=[];
			var _loc_9:Number=0;
			for (var i:int=0;i<sps.length;i++){
				_loc_9=Math.round(sps[i].time);
				kfs[i]=_loc_9;
			}
			trace("-----------end-----------");
			var kfe:KeyFrEvt = new KeyFrEvt(KeyFrEvt.KEY_FRAME_LOADED);
			kfe.totBytes=41000000;
			kfe.totTime = Number(param1.duration);
			kfe.clipDurArr=[Number(param1.duration)];
			kfe.keyFrDat=kfs;
			kfe.tvName="TEST";
			var st:ScrTeller=ScrFactory.to.getCompIns(ScrTeller);
			st.dispatchEvent(kfe);
            var _loc_2:int = 0;
            var _loc_3:* = param1.seekpoints;
            var _loc_4:* = _loc_3.length;
            var _loc_5:Number = 0;
            this.seekPoints = [];
            _loc_2 = 0;
            while (_loc_2 < _loc_4)
            {
                
                _loc_5 = Math.round(_loc_3[_loc_2].time * 10) / 10;
                this.seekPoints[_loc_2] = _loc_5;
                _loc_2++;
            }
            Trace.log("meta " + this.handlingClipId, this.seekPoints.toString());
            if (this.seekStart)
            {
                return;
            }
            this.dat.metaWidth = param1.width;
            this.dat.metaHeight = param1.height;
            this.dispatchProxy(new ScreenStmEvt(ScreenStmEvt.META_LOADED));
            return;
        }// end function

        public function seekTo(param1:Number, param2:Number, param3:Number, param4:Boolean = false) : void
        {
            this.resume();
            this.seekStart = true;
            if (!this.seekMgr.checkSeekPtDataExist(param1, param2, param3))
            {
                this.seekUrlPreparing(param1, param2, param3, param4);
            }
            else
            {
                this.dat.clipSeekMark[param1] = 0;
                if (param1 !== this.handlingClipId)
                {
                    if (param4)
                    {
                        LoadingMgr.getIns().show(LoadingMgr.SHORT_LOAD_SEEK);
                    }
                    else
                    {
                        LoadingMgr.getIns().show(LoadingMgr.FULL_LOAD_SEEK);
                    }
                    Trace.log("seek otherClipUrl", param2);
                    this.stream.play(this.dat.allPlayUrl[param1]);
                    this.autoSeekPoint = param2;
                    this.dispatchProxy(new ScreenStmEvt(ScreenStmEvt.SEEK_BETWEEN_CLIP));
                }
                else
                {
                    Trace.log("seek in curClip", param2);
                    this.stream.seek(param2);
                    this.dispatchProxy(new ScreenStmEvt(ScreenStmEvt.SEEK_IN_CLIP));
                }
                this.resetSeekParam();
            }
            this.lastSeekToClip = param1;
            return;
        }// end function

        public function seekToNoDat(param1:Number, param2:Number, param3:Number, param4:Boolean = false) : void
        {
            this.resume();
            this.seekStart = true;
            this.seekUrlPreparing(param1, param2, param3, param4);
            this.lastSeekToClip = param1;
            return;
        }// end function

        protected function seekUrlPreparing(param1:Number, param2:Number, param3:Number, param4:Boolean = false) : void
        {
            this.dat.clipSeekMark[param1] = 1;
            if (param4)
            {
                LoadingMgr.getIns().show(LoadingMgr.SHORT_LOAD_SEEK);
            }
            else
            {
                LoadingMgr.getIns().show(LoadingMgr.FULL_LOAD_SEEK);
            }
            this.dat.lastSeekToClipTime = param2;
            lastSeekToClipBytes = this.dat.clipByteArr[param1] * param2 / this.dat.clipDurArr[param1];
            var _loc_5:* = new ScreenStmEvt(ScreenStmEvt.SEEK_NEED_RE_DISPATCHING);
            new ScreenStmEvt(ScreenStmEvt.SEEK_NEED_RE_DISPATCHING).clipId = param1;
            _loc_5.clipStartTime = param2;
            this.dispatchProxy(_loc_5);
            return;
        }// end function

        protected function resetSeekParam() : void
        {
            this.dat.lastSeekToClipTime = 0;
            lastSeekToClipBytes = 0;
            return;
        }// end function

    }
}
