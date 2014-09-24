package easy.edit.sys.stg.viw
{
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.external.ExternalInterface;
    import flash.text.TextField;
    
    import easy.edit.ent.EditContext;
    import easy.edit.pro.EditDispatcher;
    import easy.edit.sys.mdt.EditBoot;
    import easy.edit.sys.stg.EditViewFactory;
    import easy.edit.sys.stg.dat.EditUIData;
    import easy.edit.sys.stg.dat.SetPtCmdMgr;
    import easy.edit.sys.stg.dat.def.SetPtCmdType;
    import easy.edit.sys.stg.evt.WorkFieldUIEvt;
    import easy.edit.sys.stg.viw.layer.EditLayer;
    import easy.edit.sys.stg.viw.layer.GradationLayer;
    import easy.edit.sys.stg.viw.layer.PointerLayer;
    import easy.edit.sys.stg.viw.layer.SpecFieldLayer;
    import easy.hub.evt.WorkEvt;
    import easy.hub.spv.InfoTipsMgr;
    import easy.scr.pro.ScrFactory;
    
    import vsin.dcw.support.CallBackCache;
    import vsin.dcw.support.Tools;
    import vsin.dcw.support.Trace;
    import vsin.dcw.support.comp.btn.CheckBoxShell;
    import vsin.dcw.support.comp.evt.ProgressEvent;

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
		private var moveTimeField:TextField;
        private const FIX_SEEK_WHEN_IN_CLIP_EDGE:int = 0;
		
		private var epgInfo:Array;

        public function EditField()
        {
            return;
        }// end function

        public function init() : void
        {
            this.skin = new EditFieldSkin();
            this.undoMgr = EditViewFactory.to.getCompIns(SetPtCmdMgr);
            this.udat = EditViewFactory.to.getCompIns(EditUIData);
			EditViewFactory.to.registComp(EditLayer);
            this.initedCallback = new CallBackCache();
            this.info = this.skin.info;
            this.caution = this.skin.caution;
            this.editLayer = EditViewFactory.to.getCompIns(EditLayer);
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
			this.moveTimeField = this.info.moveTime;
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
			this.ptLayer.addEventListener(ProgressEvent.MOUSE_MOVE,this.onSetMoveTime);
            this.editLayer.addEventListener(WorkFieldUIEvt.SELECTION_CHANGE, this.onSelectionChange);
			this.editLayer.addEventListener(WorkFieldUIEvt.SELECTION_CLICK, this.onSelectionClick);
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
			if(this.editLayer.isSerialMode){
				var _loc_2:* = this.udat.getTotProgByViewProg(param1.viewProgress);
				var _loc_3:* = this.udat.transTotProgToClipIdAndClipFlyTime(_loc_2);
				var _loc_4:* = _loc_3[0];
				var _loc_5:* = _loc_3[1];
				var _loc_6:* = this.udat.findClosestSp(_loc_3[0], _loc_3[1]);
				var _loc_7:* = this.udat.getTotProgByClipTime(_loc_3[0], _loc_6);
				this.editLayer.renderStart(_loc_7);
			}else{
				var _loc_9:InfoTipsMgr = null;
				var _loc_2:* = this.udat.getTotProgByViewProg(param1.viewProgress);
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
				trace("onSetStart1:"+_loc_7);
//				add param of user start point portion
//				this.editLayer.renderStart(_loc_7,_loc_2);
				if (this.editLayer.renderStart(_loc_7))
				{
					trace("onSetStart2");
					this.ptLayerEndMode();
				}
				else
				{
					trace("onSetStart3");
					this.ptLayerStartMode();
				}
			}
            return;
        }// end function

        private function onSetEnd(param1:WorkFieldUIEvt) : void
        {
			if(this.editLayer.isSerialMode){
				var _loc_2:* = this.udat.getTotProgByViewProg(param1.viewProgress);
				var _loc_4:* = this.udat.transTotProgToClipIdAndClipFlyTime(_loc_2);
				var _loc_5:* = this.udat.transTotProgToClipIdAndClipFlyTime(_loc_2)[0];
				var _loc_6:* = _loc_4[1];
				var _loc_7:* = this.udat.findClosestSp(_loc_4[0], _loc_4[1]);
				var _loc_8:* = this.udat.getTotProgByClipTime(_loc_4[0], _loc_7);
				var _loc_9:* = editLayer.renderEnd(_loc_8);
				if(_loc_9==true){
					callJSFunction("onUpdateItem");
					this.editLayer.selectNextSelection();
				}
			}else{
				var _loc_2:* = this.udat.getTotProgByViewProg(param1.viewProgress);
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
				//            var _loc_9:* = this.editLayer.renderEnd(_loc_8);
				if (this.editLayer.renderEnd(_loc_8))
				{
					this.ptLayerStartMode();
				}
				else
				{
					this.ptLayerEndMode();
				}
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
			Trace.log("onSelectionChange:"+param1.totSelectionDuration);
            this.editTimeField.text = Tools.formatTime(param1.totSelectionDuration);
            return;
        }// end function
		
		private function onSelectionClick(param1:WorkFieldUIEvt):void{
			callJSFunction("onSelectItem");
			this.ptLayer.seekManuallyByTime(param1.progress);
		}// end function

		private function callJSFunction(funcName:String):void{
			try{
				epgInfo[editLayer.sectionIndex].start = editLayer.selectedDat[editLayer.sectionIndex].start;
				epgInfo[editLayer.sectionIndex].end = editLayer.selectedDat[editLayer.sectionIndex].end;
				flash.external.ExternalInterface.call(funcName,escape(JSON.stringify(epgInfo[editLayer.sectionIndex])));
			}catch(e:Error){
				flash.external.ExternalInterface.call(funcName,e.message);
			}
		}
		
        public function undo() : void
        {
			if(this.editLayer.isSerialMode==true){
				if(this.editLayer.sectionIndex==-1)return;
				else {
					var _loc_3:* = editLayer.sectionIndex;
					epgInfo.splice(_loc_3,1);
					undoMgr.allCmd.splice(_loc_3*2,2);
					editLayer.removeSelection();
					return;
				}
			}
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
            var _loc_2:* = this.udat.findPrevSp(_loc_1[0], _loc_1[1]);
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
            var _loc_2:* = this.udat.findNextSp(_loc_1[0], _loc_1[1]);
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
            if (this.ptLayer.isSetStartEnabled()||this.editLayer.isSerialMode)
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
            if (this.ptLayer.isSetEndEnabled()||this.editLayer.isSerialMode)
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

		public function getSelectionInfo():String{
			if(this.editLayer.sectionIndex==-1)return null;
			return JSON.stringify(epgInfo[this.editLayer.sectionIndex]);
		}
		
        public function setEditDat(param1:String) : void
        {
            var block:Object;
            var i:int;
            var obj:Array=[];
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
            var arr:Array=[];
            var _loc_3:int = 0;
            var _loc_4:* = obj;
            for (_loc_3 in _loc_4){
                block = _loc_4[_loc_3];
                arr.push(block);
            }
            arr.sort(function (param1:Object, param2:Object) : int
            {
                return param1.start - param2.start;
            }// end function
            );
			epgInfo=arr;
			var _loc_19:*=this.undoMgr.allCmd.length;
			for(var _loc_1:*=0;_loc_1<_loc_19;_loc_1++){
				this.undo();
			}
            while (i < arr.length)
            {
                block = arr[i];
                if (this.editLayer.renderStart(this.udat.transSecToViewProg(block.start),true))
                {
                    this.ptLayerEndMode();
                }
                else
                {
                    this.ptLayerStartMode();
                }
                if (this.editLayer.renderEnd(this.udat.transSecToViewProg(block.end),true))
                {
                    this.ptLayerStartMode();
                }
                else
                {
                    this.ptLayerEndMode();
                }
                i=i+1;
            }
            return;
        }// end function

		/**
		 * @param1: totalTime
		 * @param2: tvName
		 * */
        public function setDat(param1:Number, param2:String="Test", param3:String=null) : void
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
			this.setEditDat(param3);
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

		private function onSetMoveTime(event:ProgressEvent):void{
			this.moveTimeField.text = Tools.formatTime(event.progressOver);
			return;
		}// end function
		
    }
}
