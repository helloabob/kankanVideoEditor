package easy.edit.sys.stg.viw
{
    import easy.edit.sys.stg.*;
    import easy.edit.sys.stg.dat.*;
    import easy.edit.sys.stg.dat.def.*;
    import easy.edit.sys.stg.evt.*;
    import easy.edit.sys.stg.viw.layer.*;
    import easy.hub.spv.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import vsin.dcw.support.*;
    import vsin.dcw.support.comp.btn.*;

    public class EditField extends Sprite
    {
        private var skin:EditFieldSkin;
        private var layerContainer:Sprite;
        private var caution:Sprite;
        private var info:EditInfoSkin;
        private var line:Sprite;
        private var udat:EditUIData;
        private var editLayer:EditLayer;
        private var specLayer:SpecFieldLayer;
        private var ptLayer:PointerLayer;
        private var gradLayer:GradationLayer;
        private var title:TextField;
        private var playBtn:CheckBoxShell;
        private var inited:Boolean = false;
        private var undoMgr:SetPtCmdMgr;
        private var initedCallback:CallBackCache;
        private var editTimeField:TextField;
        private var flyTimeField:TextField;
        private var durationField:TextField;
        private const FIX_SEEK_WHEN_IN_CLIP_EDGE:int = 0;

        public function EditField()
        {
            return;
        }// end function

        public function init() : void
        {
            this.skin = new EditFieldSkin();
            this.undoMgr = EditViewFactory.to.getCompIns(SetPtCmdMgr);
            this.udat = EditViewFactory.to.getCompIns(EditUIData);
            this.initedCallback = new CallBackCache();
            this.info = this.skin.info;
            this.caution = this.skin.caution;
            this.editLayer = new EditLayer();
            this.specLayer = new SpecFieldLayer();
            this.ptLayer = new PointerLayer();
            this.gradLayer = new GradationLayer();
            this.layerContainer = this.skin.editContainer;
            this.layerContainer.addChild(this.editLayer);
            this.layerContainer.addChild(this.specLayer);
            this.layerContainer.addChild(this.ptLayer);
            this.layerContainer.addChild(this.gradLayer);
            this.ptLayer.y = this.layerContainer.height - this.ptLayer.height;
            this.specLayer.y = this.ptLayer.y - this.specLayer.height;
            this.editLayer.y = this.ptLayer.y;
            this.line = this.skin.line;
            this.title = this.skin.videoName;
            this.editTimeField = this.info.totalEditTime;
            this.flyTimeField = this.info.flyTime;
            this.durationField = this.info.totalTime;
            this.playBtn = new CheckBoxShell(this.skin.playBtn);
            this.addEvent();
            addChild(this.skin);
            return;
        }// end function

        private function addEvent() : void
        {
            this.playBtn.addEventListener(MouseEvent.MOUSE_UP, this.onPlayCtrl);
            this.ptLayer.addEventListener(WorkFieldUIEvt.SET_START_PT, this.onSetStart);
            this.ptLayer.addEventListener(WorkFieldUIEvt.SET_END_PT, this.onSetEnd);
            this.editLayer.addEventListener(WorkFieldUIEvt.SELECTION_CHANGE, this.onSelectionChange);
            return;
        }// end function

        private function onPlayCtrl(event:MouseEvent) : void
        {
            if (this.playBtn.isChecked())
            {
                dispatchEvent(new WorkFieldUIEvt(WorkFieldUIEvt.RESUME));
            }
            else
            {
                dispatchEvent(new WorkFieldUIEvt(WorkFieldUIEvt.PAUSE));
            }
            return;
        }// end function

        private function onSetStart(param1:WorkFieldUIEvt) : void
        {
            var _loc_9:InfoTipsMgr = null;
            var _loc_2:* = this.udat.getTotProgByViewProg(param1.viewProgress);
            Trace.log("onSetStart", _loc_2);
            if (this.editLayer.isInSelected(_loc_2))
            {
                _loc_9 = new InfoTipsMgr();
                _loc_9.show("请在空白处设置起点");
                this.ptLayerStartMode();
                return;
            }
            var _loc_3:* = this.udat.transTotProgToClipIdAndClipFlyTime(_loc_2);
            var _loc_4:* = _loc_3[0];
            var _loc_5:* = _loc_3[1];
            var _loc_6:* = this.udat.findClosestSp(_loc_3[0], _loc_3[1]);
            var _loc_7:* = this.udat.getTotProgByClipTime(_loc_3[0], _loc_6);
            var _loc_8:* = this.editLayer.renderStart(_loc_7);
            if (this.editLayer.renderStart(_loc_7))
            {
                this.ptLayerEndMode();
            }
            else
            {
                this.ptLayerStartMode();
            }
            return;
        }// end function

        private function onSetEnd(param1:WorkFieldUIEvt) : void
        {
            var _loc_2:* = this.udat.getTotProgByViewProg(param1.viewProgress);
            Trace.log("onSetEnd", _loc_2);
            var _loc_3:* = new InfoTipsMgr();
            if (this.editLayer.isInSelected(_loc_2))
            {
                _loc_3.show("请在空白处设置终点");
                this.ptLayerEndMode();
                return;
            }
            if (this.editLayer.isBeforeStart(_loc_2))
            {
                _loc_3.show("请在起点后设置终点");
                this.ptLayerEndMode();
                return;
            }
            if (this.editLayer.isContainSelected(_loc_2))
            {
                _loc_3.show("包含了之前的选择区域");
                this.ptLayerEndMode();
                return;
            }
            var _loc_4:* = this.udat.transTotProgToClipIdAndClipFlyTime(_loc_2);
            var _loc_5:* = this.udat.transTotProgToClipIdAndClipFlyTime(_loc_2)[0];
            var _loc_6:* = _loc_4[1];
            var _loc_7:* = this.udat.findClosestSp(_loc_4[0], _loc_4[1]);
            var _loc_8:* = this.udat.getTotProgByClipTime(_loc_4[0], _loc_7);
            var _loc_9:* = this.editLayer.renderEnd(_loc_8);
            if (this.editLayer.renderEnd(_loc_8))
            {
                this.ptLayerStartMode();
            }
            else
            {
                this.ptLayerEndMode();
            }
            return;
        }// end function

        private function ptLayerEndMode() : void
        {
            this.ptLayer.enableSetStart(false);
            this.ptLayer.enableSetEnd(true);
            return;
        }// end function

        private function ptLayerStartMode() : void
        {
            this.ptLayer.enableSetStart(true);
            this.ptLayer.enableSetEnd(false);
            return;
        }// end function

        private function onSelectionChange(param1:WorkFieldUIEvt) : void
        {
            this.editTimeField.text = Tools.formatTime(param1.totSelectionDuration);
            return;
        }// end function

        public function undo() : void
        {
            var _loc_2:InfoTipsMgr = null;
            if (!this.inited)
            {
                return;
            }
            var _loc_1:* = this.undoMgr.getLastCmd();
            if (_loc_1)
            {
                this.editLayer.undo(_loc_1);
                if (_loc_1.action === SetPtCmdType.SET_START)
                {
                    this.ptLayerStartMode();
                }
                else
                {
                    this.ptLayerEndMode();
                }
            }
            else
            {
                _loc_2 = new InfoTipsMgr();
                _loc_2.show("无操作记录");
            }
            return;
        }// end function

        public function moveToLeftKeyFr() : void
        {
            if (!this.inited)
            {
                return;
            }
            var _loc_1:* = this.udat.transTotProgToClipIdAndClipFlyTime(this.ptLayer.getTotPercent());
            Trace.log("moveToLeftKeyFr", _loc_1.toString());
            var _loc_2:* = this.udat.findPrevSp(_loc_1[0], _loc_1[1]);
            Trace.err("cur and toSeek", _loc_1[1] + " / " + _loc_2);
            var _loc_3:* = _loc_2 - _loc_1[1] - this.FIX_SEEK_WHEN_IN_CLIP_EDGE;
            this.ptLayer.seekOffset(this.udat.transSecToViewProg(_loc_3));
            return;
        }// end function

        public function moveToRightKeyFr() : void
        {
            if (!this.inited)
            {
                return;
            }
            var _loc_1:* = this.udat.transTotProgToClipIdAndClipFlyTime(this.ptLayer.getTotPercent());
            Trace.log("moveToRightKeyFr", _loc_1.toString());
            var _loc_2:* = this.udat.findNextSp(_loc_1[0], _loc_1[1]);
            Trace.err("cur and toSeek", _loc_1[1] + " / " + _loc_2);
            var _loc_3:* = _loc_2 - _loc_1[1] + this.FIX_SEEK_WHEN_IN_CLIP_EDGE;
            this.ptLayer.seekOffset(this.udat.transSecToViewProg(_loc_3));
            return;
        }// end function

        public function setStartPoint() : void
        {
            var _loc_1:WorkFieldUIEvt = null;
            if (!this.inited)
            {
                return;
            }
            if (this.ptLayer.isSetStartEnabled())
            {
                _loc_1 = new WorkFieldUIEvt(WorkFieldUIEvt.SET_START_PT);
                _loc_1.viewProgress = this.ptLayer.getViewPercent();
                this.onSetStart(_loc_1);
            }
            return;
        }// end function

        public function setEndPoint() : void
        {
            var _loc_1:WorkFieldUIEvt = null;
            if (!this.inited)
            {
                return;
            }
            if (this.ptLayer.isSetEndEnabled())
            {
                _loc_1 = new WorkFieldUIEvt(WorkFieldUIEvt.SET_END_PT);
                _loc_1.viewProgress = this.ptLayer.getViewPercent();
                this.onSetEnd(_loc_1);
            }
            return;
        }// end function

        public function togglePlay() : void
        {
            if (!this.inited)
            {
                return;
            }
            this.playBtn.fireEvent(new MouseEvent(MouseEvent.MOUSE_UP));
            this.playBtn.fireEvent(new MouseEvent(MouseEvent.ROLL_OUT));
            return;
        }// end function

        public function setEditDat(param1:String) : void
        {
            var block:Object;
            var i:int;
            var obj:Object;
            var dat:* = param1;
            if (!this.inited)
            {
                Trace.err("haven\'t inited, setEditDat delay");
                this.initedCallback.addCallback(this.setEditDat, [dat]);
                return;
            }
            Trace.log("dcw1123", dat);
            if (!dat)
            {
                Trace.err("setEditDat dat invalid.");
                return;
            }
            try
            {
                obj = JSON.parse(dat);
            }
            catch (e:Error)
            {
                Trace.err("setEditDat parse err");
                return;
            }
            var arr:Array;
            var _loc_3:int = 0;
            var _loc_4:* = obj;
            while (_loc_4 in _loc_3)
            {
                
                block = _loc_4[_loc_3];
                arr.push(block);
            }
            arr.sort(function (param1:Object, param2:Object) : int
            {
                return param1.start - param2.start;
            }// end function
            );
            i;
            while (i < arr.length)
            {
                
                block = arr[i];
                if (this.editLayer.renderStart(this.udat.transSecToViewProg(block.start)))
                {
                    this.ptLayerEndMode();
                }
                else
                {
                    this.ptLayerStartMode();
                }
                if (this.editLayer.renderEnd(this.udat.transSecToViewProg(block.end)))
                {
                    this.ptLayerStartMode();
                }
                else
                {
                    this.ptLayerEndMode();
                }
                i = (i + 1);
            }
            return;
        }// end function

        public function setDat(param1:Number, param2:String="Test") : void
        {
			trace("duration:"+param1);
            this.title.text = param2;
            this.playBtn.x = this.title.textWidth + 15;
            this.durationField.text = Tools.formatTime(param1);
            Trace.log("editfield.width", width);
            this.gradLayer.init(this.udat.stgWidth, param1);
            this.ptLayer.init(this.udat.stgWidth, param1);
            this.specLayer.init(this.udat.stgWidth, param1);
            this.editLayer.init(this.udat.stgWidth, param1);
            this.udat.updateView(param1, param1, this.udat.stgWidth, 0);
            this.gradLayer.render();
            this.caution.x = this.udat.stgWidth - this.caution.width;
            this.info.x = this.udat.stgWidth - this.info.width;
            this.line.width = width;
            this.inited = true;
            this.initedCallback.run();
            return;
        }// end function

        public function updatePlayBtn(param1:Boolean) : void
        {
            this.playBtn.checked(param1);
            return;
        }// end function

        public function updateHotField(param1:Object) : void
        {
            this.specLayer.render(param1);
            return;
        }// end function

        public function updateKeyFrSpot(param1:Object) : void
        {
            return;
        }// end function

        public function updateFlyTime(param1:Number) : void
        {
            this.flyTimeField.text = Tools.formatTime(param1);
            this.ptLayer.timeUpdate(param1);
            return;
        }// end function

    }
}
