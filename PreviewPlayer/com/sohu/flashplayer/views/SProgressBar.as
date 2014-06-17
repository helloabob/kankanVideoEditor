package com.sohu.flashplayer.views
{
    import com.sohu.flashplayer.inter_pack.*;
    import com.sohu.flashplayer.util.*;
    import com.sohu.fwork.baseagent.*;
    import com.sohu.fwork.view.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.globalization.*;
	import com.sohu.flashplayer.inter_pack.splayer.IProgress;

    public class SProgressBar extends View implements IView, IProgress
    {
        private var ctrlBgMC:MovieClip;
        private var startPlayBtn:MovieClip;
        private var playBtn:MovieClip;
        private var pauseBtn:MovieClip;
        private var fullScreenBtn:MovieClip;
        private var normalScreenBtn:MovieClip;
        private var proTopMc:MovieClip;
        private var proMiddleMc:MovieClip;
        private var proBottomMc:MovieClip;
        private var miniProTopMc:MovieClip;
        private var miniProMiddleMc:MovieClip;
        private var miniProBottomMc:MovieClip;
        private var proBtn:MovieClip;
        private var time:MovieClip;
        private var isSeek:Boolean = false;
        private var isInited:Boolean = false;
        private var isProBtnMouseOver:Boolean = false;
        public static const NAME:String = "SProgressBar";
        public static const SEEK_EVENT:String = "seek_event";
        public static const PLAY_CTRL_EVENT:String = "play_event";
        public static const SCREEN_CTRL_EVENT:String = "full_event";

        public function SProgressBar()
        {
            return;
        }// end function

        public function init() : void
        {
            this.ctrlBgMC = GlobelResUtil.getResByName(GlobelResUtil.CTRLBG_MC);
            this.startPlayBtn = GlobelResUtil.getResByName(GlobelResUtil.START_PLAY_BTN);
            this.playBtn = GlobelResUtil.getResByName(GlobelResUtil.PLAY_BTN);
            this.pauseBtn = GlobelResUtil.getResByName(GlobelResUtil.PAUSE_BTN);
            this.fullScreenBtn = GlobelResUtil.getResByName(GlobelResUtil.FULL_SCREEN_BTN);
            this.normalScreenBtn = GlobelResUtil.getResByName(GlobelResUtil.NORMAL_SCREEN_BTN);
            this.proTopMc = GlobelResUtil.getResByName(GlobelResUtil.PRO_TOP_MC);
            this.proBottomMc = GlobelResUtil.getResByName(GlobelResUtil.PRO_BOTTOM_MC);
            this.proMiddleMc = GlobelResUtil.getResByName(GlobelResUtil.PRO_MIDDLE_MC);
            this.miniProTopMc = GlobelResUtil.getResByName(GlobelResUtil.MINI_PRO_TOP_MC);
            this.miniProMiddleMc = GlobelResUtil.getResByName(GlobelResUtil.MINI_PRO_MIDDLE_MC);
            this.miniProBottomMc = GlobelResUtil.getResByName(GlobelResUtil.MINI_PRO_BOTTOM_MC);
            this.proBtn = GlobelResUtil.getResByName(GlobelResUtil.DRAG_BTN);
            this.time = GlobelResUtil.getResByName(GlobelResUtil.TIME_MC);
            this.graphicsView();
            this.isInited = true;
            this.resize(this.stage.stageWidth, stage.stageHeight);
            this.proBtn.y = this.miniProBottomMc.y - this.miniProBottomMc.height / 2 - this.proBtn.height / 2;
            this.stage.addEventListener(FullScreenEvent.FULL_SCREEN, this.fullScreenHandler);
            return;
        }// end function

        private function graphicsView() : void
        {
            this.addChild(this.ctrlBgMC);
            this.addChild(this.proBottomMc);
            this.addChild(this.proMiddleMc);
            this.addChild(this.proTopMc);
            this.addChild(this.miniProBottomMc);
            this.addChild(this.miniProMiddleMc);
            this.addChild(this.miniProTopMc);
            this.addChild(this.time);
            this.addChild(this.proBtn);
            this.addChild(this.startPlayBtn);
            this.addChild(this.playBtn);
            this.addChild(this.pauseBtn);
            ButtonUtil.regestButtonBaseHandler(this.startPlayBtn);
            ButtonUtil.regestButtonBaseHandler(this.playBtn);
            ButtonUtil.regestButtonBaseHandler(this.pauseBtn);
            ButtonUtil.regestButtonBaseHandler(this.fullScreenBtn);
            ButtonUtil.regestButtonBaseHandler(this.normalScreenBtn);
            ButtonUtil.regestButtonBaseHandler(this.proBtn);
            var _loc_1:Boolean = true;
            this.miniProBottomMc.buttonMode = true;
            this.proBottomMc.buttonMode = _loc_1;
            var _loc_1:Boolean = false;
            this.proTopMc.visible = false;
            var _loc_1:* = _loc_1;
            this.proMiddleMc.visible = _loc_1;
            this.proBottomMc.visible = _loc_1;
            stage.addEventListener(MouseEvent.MOUSE_OVER, this.miniProBottomMcMouseOverHandler);
            stage.addEventListener(MouseEvent.MOUSE_OUT, this.proBottomMcMouseOutHandler);
            this.proBtn.addEventListener(MouseEvent.MOUSE_DOWN, this.proBtnMouseDown);
            this.proBtn.addEventListener(MouseEvent.MOUSE_UP, this.stageMouseUpHandler);
            this.proBtn.x = 0;
            stage.addEventListener(MouseEvent.MOUSE_UP, this.stageMouseUpHandler);
            this.playBtn.addEventListener(MouseEvent.CLICK, this.playPauseHandler);
            this.pauseBtn.addEventListener(MouseEvent.CLICK, this.playPauseHandler);
            this.startPlayBtn.addEventListener(MouseEvent.CLICK, this.playPauseHandler);
            this.fullScreenBtn.addEventListener(MouseEvent.CLICK, this.fullNomalHandler);
            this.normalScreenBtn.addEventListener(MouseEvent.CLICK, this.fullNomalHandler);
            this.playBtn.visible = false;
            this.startPlayBtn.visible = false;
            this.normalScreenBtn.visible = false;
            this.visible = false;
            return;
        }// end function

        private function fullScreenHandler(event:FullScreenEvent) : void
        {
            if (event.fullScreen == false)
            {
                this.normalScreenBtn.visible = false;
                this.fullScreenBtn.visible = true;
            }
            return;
        }// end function

        private function fullNomalHandler(event:MouseEvent) : void
        {
            event.currentTarget.visible = false;
            var _loc_2:* = new NotifyData();
            switch(event.currentTarget)
            {
                case this.fullScreenBtn:
                {
                    this.normalScreenBtn.visible = true;
                    _loc_2.code = 1;
                    break;
                }
                case this.normalScreenBtn:
                {
                    this.fullScreenBtn.visible = true;
                    _loc_2.code = 0;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.dispatch(SCREEN_CTRL_EVENT, _loc_2);
            return;
        }// end function

        public function updatePlayBtnComplete() : void
        {
            this.pauseBtn.visible = false;
            this.playBtn.visible = true;
            return;
        }// end function

        public function updatePlayBtnStart() : void
        {
            this.pauseBtn.visible = true;
            this.playBtn.visible = false;
            return;
        }// end function

        private function playPauseHandler(event:MouseEvent) : void
        {
            event.currentTarget.visible = false;
            var _loc_2:* = new NotifyData();
            switch(event.currentTarget)
            {
                case this.playBtn:
                {
                    this.pauseBtn.visible = true;
                    _loc_2.code = 1;
                    this.startPlayBtn.visible = false;
                    break;
                }
                case this.pauseBtn:
                {
                    this.playBtn.visible = true;
                    this.startPlayBtn.visible = true;
                    _loc_2.code = 0;
                    break;
                }
                case this.startPlayBtn:
                {
                    this.pauseBtn.visible = true;
                    this.playBtn.visible = false;
                    _loc_2.code = 1;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.dispatch(PLAY_CTRL_EVENT, _loc_2);
            return;
        }// end function

        private function stageMouseClickHandler(event:MouseEvent) : void
        {
            event.stopImmediatePropagation();
            return;
        }// end function

        private function sendSeekNotify() : void
        {
            var _loc_1:* = mouseX;
            if (_loc_1 > stage.stageWidth - this.proBtn.width)
            {
                _loc_1 = stage.stageWidth - this.proBtn.width / 2;
            }
            else if (_loc_1 < this.proBtn.width)
            {
                _loc_1 = this.proBtn.width / 2;
            }
            this.proBtn.x = _loc_1 - this.proBtn.width / 2;
            if (this.proBtn.x < 0)
            {
                this.proBtn.x = 0;
            }
            var _loc_2:* = new NotifyData();
            _loc_2.data = new SeekData();
            (_loc_2.data as SeekData).value = this.proBtn.x / stage.stageWidth;
            this.dispatch(SEEK_EVENT, _loc_2);
            return;
        }// end function

        override public function enterFrame() : void
        {
            if (this.proTopMc && this.miniProTopMc && this.proBtn)
            {
                var _loc_1:int = 0;
                this.miniProTopMc.x = 0;
                this.proTopMc.x = _loc_1;
                this.proTopMc.width = this.proBtn.x + 2;
            }
            if (this.proBtn && this.proTopMc && this.miniProBottomMc)
            {
                if (this.isProBtnMouseOver)
                {
                    this.proBtn.y = this.proTopMc.y + this.proTopMc.height / 2 - this.proBtn.height / 2;
                    this.proBtn.alpha = 1;
                }
                else
                {
                    this.proBtn.y = this.miniProBottomMc.y + this.miniProBottomMc.height / 2 - this.proBtn.height / 2;
                    this.proBtn.alpha = 0;
                }
            }
            return;
        }// end function

        private function stageMouseUpHandler(event:MouseEvent) : void
        {
            if (mouseY > this.proBottomMc.y && mouseY < this.proBottomMc.y + this.proBottomMc.height * 2)
            {
                this.proBtn.stopDrag();
                this.sendSeekNotify();
            }
            return;
        }// end function

        private function proBtnMouseDown(event:MouseEvent) : void
        {
            if (mouseY > this.proBottomMc.y && mouseY < this.proBottomMc.y + this.proBottomMc.height * 2)
            {
                this.isSeek = true;
                this.proBtn.startDrag(false, new Rectangle(0, this.proBtn.y, stage.width - this.proBtn.width, 0));
            }
            return;
        }// end function

        private function miniProBottomMcMouseOverHandler(event:MouseEvent) : void
        {
            this.isProBtnMouseOver = true;
            var _loc_2:Boolean = true;
            this.proTopMc.visible = true;
            var _loc_2:* = _loc_2;
            this.proMiddleMc.visible = _loc_2;
            this.proBottomMc.visible = _loc_2;
            var _loc_2:Boolean = false;
            this.miniProTopMc.visible = false;
            var _loc_2:* = _loc_2;
            this.miniProMiddleMc.visible = _loc_2;
            this.miniProBottomMc.visible = _loc_2;
            return;
        }// end function

        private function proBottomMcMouseOutHandler(event:MouseEvent) : void
        {
            this.isProBtnMouseOver = false;
            var _loc_2:Boolean = false;
            this.proTopMc.visible = false;
            var _loc_2:* = _loc_2;
            this.proMiddleMc.visible = _loc_2;
            this.proBottomMc.visible = _loc_2;
            var _loc_2:Boolean = true;
            this.miniProTopMc.visible = true;
            var _loc_2:* = _loc_2;
            this.miniProMiddleMc.visible = _loc_2;
            this.miniProBottomMc.visible = _loc_2;
            return;
        }// end function

        public function resize_ex(param1:Number, param2:Number) : void
        {
            if (this.isInited == false)
            {
                return;
            }
            this.ctrlBgMC.width = param1;
            this.ctrlBgMC.x = 0;
            this.ctrlBgMC.y = param2 - this.ctrlBgMC.height;
            this.proBottomMc.width = param1;
            this.proBottomMc.x = 0;
            this.proBottomMc.y = this.ctrlBgMC.y - this.proBottomMc.height;
            this.proMiddleMc.x = 0;
            this.proMiddleMc.y = this.ctrlBgMC.y - this.proMiddleMc.height;
            this.proTopMc.x = 0;
            this.proTopMc.y = this.ctrlBgMC.y - this.proTopMc.height;
            this.miniProBottomMc.width = param1;
            this.miniProBottomMc.x = 0;
            this.miniProBottomMc.y = this.ctrlBgMC.y - this.miniProBottomMc.height;
            this.miniProMiddleMc.x = 0;
            this.miniProMiddleMc.y = this.ctrlBgMC.y - this.miniProMiddleMc.height;
            this.miniProTopMc.x = 0;
            this.miniProTopMc.y = this.ctrlBgMC.y - this.miniProTopMc.height;
            this.playBtn.x = 10;
            this.playBtn.y = param2 - this.playBtn.height;
            this.pauseBtn.x = this.playBtn.x;
            this.pauseBtn.y = this.playBtn.y;
            this.time.x = this.pauseBtn.x + this.pauseBtn.width + 10;
            this.time.y = this.pauseBtn.y;
            this.fullScreenBtn.x = param1 - this.fullScreenBtn.width - 10;
            this.fullScreenBtn.y = param2 - this.fullScreenBtn.height;
            this.normalScreenBtn.x = this.fullScreenBtn.x;
            this.normalScreenBtn.y = this.fullScreenBtn.y;
            this.startPlayBtn.x = 10;
            this.startPlayBtn.y = param2 - this.ctrlBgMC.height - this.startPlayBtn.height - 10;
            this.startPlayBtn.visible = false;
            if (this.visible == false)
            {
                this.visible = true;
            }
            return;
        }// end function

        public function updateDownLoadProgress(param1:Number) : void
        {
            if (this.isSeek == false && this.proMiddleMc)
            {
                this.proMiddleMc.width = stage.stageWidth * param1;
                this.miniProMiddleMc.width = stage.stageWidth * param1;
            }
            return;
        }// end function

        public function updatePlayProgress(param1:Number) : void
        {
            if (this.isSeek == false && this.proBtn)
            {
                this.proBtn.x = stage.stageWidth * param1;
                if (this.proBtn.x > stage.stageWidth - this.proBtn.width)
                {
                    this.proBtn.x = stage.stageWidth - this.proBtn.width;
                }
                this.miniProTopMc.width = stage.stageWidth * param1;
            }
            return;
        }// end function

        public function updatePlayBtnStatus() : void
        {
            this.pauseBtn.visible = true;
            this.startPlayBtn.visible = false;
            this.playBtn.visible = false;
            return;
        }// end function

        public function updateSeekStatus(param1:Boolean = false) : void
        {
            this.isSeek = param1;
            return;
        }// end function

        public function updateTime(param1:int, param2:int) : void
        {
            this.time.t1.text = this.formatTime(param1);
            this.time.t2.text = this.formatTime(param2);
            return;
        }// end function

        public function formatTime(param1:Number) : String
        {
            var _loc_2:* = new DateTimeFormatter("zh_CN");
            if (param1 > 3600)
            {
                param1 = param1 - 3600 * 8;
                _loc_2.setDateTimePattern("kk:mm:ss");
            }
            else
            {
                _loc_2.setDateTimePattern("mm:ss");
            }
            return _loc_2.format(new Date(param1 * 1000));
        }// end function

    }
}
