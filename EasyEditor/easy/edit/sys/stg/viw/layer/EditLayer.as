package easy.edit.sys.stg.viw.layer
{
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    
    import easy.edit.sys.stg.EditViewFactory;
    import easy.edit.sys.stg.dat.SetPtCmdItem;
    import easy.edit.sys.stg.dat.SetPtCmdMgr;
    import easy.edit.sys.stg.dat.def.SetPtCmdType;
    import easy.edit.sys.stg.evt.WorkFieldUIEvt;
    import easy.hub.spv.InfoTipsMgr;
    import easy.scr.pro.ScrFactory;
    import easy.scr.sys.com.dat.PlayDat;
    
    import vsin.dcw.support.Trace;

    public class EditLayer extends Sprite
    {
        private var dur:Number;
        private var h:Number = 42;
        private var curOperateSprite:SpriteForSelection;
        private var inProcess:Boolean = false;
        private var selectedArr:Array;
        public var selectedDat:Array;
        private var startSeekPt:Number;
        private var endSeekPt:Number;
        private var undoMgr:SetPtCmdMgr;
		
		private var editorHeight:int=10;
		public var isSerialMode:Boolean=true;
		private var line:Sprite;
		public var sectionIndex:int=-1;
		private var btnCommit:CommitBtnSkin;
		
		private var colorState:Boolean=true;

        public function EditLayer()
        {
            return;
        }// end function

        public function init(param1:Number, param2:Number) : void
        {
            this.undoMgr = EditViewFactory.to.getCompIns(SetPtCmdMgr);
            this.dur = param2;
            this.selectedArr = [];
            this.selectedDat = [];
            var _loc_3:* = new Sprite();
            _loc_3.graphics.lineStyle(1, 0, 0);
            _loc_3.graphics.moveTo(0, 0);
            _loc_3.graphics.lineTo((param1 - 1), (this.h - 1));
            addChild(_loc_3);
            return;
        }// end function

		public function showSerialMode():void{
			if((ScrFactory.to.getCompIns(PlayDat)as PlayDat).epg!=null&&(ScrFactory.to.getCompIns(PlayDat)as PlayDat).epg.length>0){
				Trace.log("epg:"+(ScrFactory.to.getCompIns(PlayDat)as PlayDat).epg);
				//20140924 hide commit button.
//				if(btnCommit==null)btnCommit = new CommitBtnSkin();
//				btnCommit.width=60;
//				btnCommit.height=25;
//				btnCommit.y=this.h+this.editorHeight+5;
//				btnCommit.x=50;
//				btnCommit.mouseEnabled=true;
//				btnCommit.addEventListener(MouseEvent.CLICK,onCompleteSerialMode);
//				addChild(btnCommit);
				isSerialMode=true;
			}else{
				isSerialMode=false;
				for each(var sp:Sprite in this.selectedArr){
					sp.height=this.h;
					if(sp.hasEventListener(MouseEvent.CLICK))sp.removeEventListener(MouseEvent.CLICK,onSliceTapped);
				}
			}
		}
		
		private function onCompleteSerialMode(evt:MouseEvent):void{
			this.isSerialMode=false;
			sectionIndex = -1;
			if(line)line.parent.removeChild(line);
			for each(var sp:Sprite in this.selectedArr){
				sp.height=this.h;
				if(sp.hasEventListener(MouseEvent.CLICK))sp.removeEventListener(MouseEvent.CLICK,onSliceTapped);
			}
			btnCommit.removeEventListener(MouseEvent.CLICK,onCompleteSerialMode);
			removeChild(btnCommit);
		}
		
		private function onSliceTapped(evt:*):void{
			var sp:Sprite=evt.target as Sprite;
			if(sectionIndex==-1||sectionIndex!=selectedArr.indexOf(sp)){
				if(line==null){
					line=new Sprite();
					line.graphics.beginFill(0xff0000,1);
					line.graphics.drawRect(0,sp.height-2,2,2);
					line.graphics.endFill();
				}
				sp.addChild(line);
				sectionIndex=selectedArr.indexOf(sp);
				
				var _loc_1:WorkFieldUIEvt = new WorkFieldUIEvt(WorkFieldUIEvt.SELECTION_CLICK);
				_loc_1.progress=this.selectedDat[sectionIndex].start;
				dispatchEvent(_loc_1);
			}
		}
		public function selectNextSelection():void{
			if(sectionIndex>=selectedArr.length-1)return;
			var obj:Object = new Object();
			obj.target = selectedArr[sectionIndex+1] as Sprite;
			onSliceTapped(obj);
		}
		
        public function renderStart(param1:Number,forced:Boolean=false) : Boolean
        {
			if(this.isSerialMode&&forced==false){
				if(sectionIndex==-1){
					this.showAlert("请选择视频片段");
					return false;
				}
				var _loc_2:*=param1*width;
				if(sectionIndex>0){
					if(_loc_2<this.selectedArr[sectionIndex-1].x+this.selectedArr[sectionIndex-1].width){
						this.showAlert("包含了之前的选择区域");
						return false;
					}
				}
				if(_loc_2>this.selectedArr[sectionIndex].x+this.selectedArr[sectionIndex].width){
					this.showAlert("请在终点前设置起点");
					return false;
				}
				var sp:Sprite=this.selectedArr[sectionIndex];
				/*batch update time and coordinate*/
				var offsetCoordinate:Number = _loc_2 - sp.x;
				var offsetTime:Number = param1*dur - this.selectedDat[sectionIndex].start;
				sp.x = _loc_2;
				
				/*end*/
//				if(_loc_2<sp.x){
//					sp.width=sp.width+(sp.x-_loc_2);
//					sp.x=_loc_2;
//				}else if(_loc_2>sp.x){
//					sp.width=sp.width-(_loc_2-sp.x);
//					sp.x=_loc_2;
//				}
				Trace.log("sectionArea_change");
				var newEnd:Number = Number(this.selectedDat[sectionIndex].end) + offsetTime;
				this.selectedDat[sectionIndex].start=(param1*dur).toFixed(2);
				this.selectedDat[sectionIndex].end=newEnd.toFixed(2);
//				this.selectedDat[sectionIndex].total=(this.selectedDat[sectionIndex].end-this.selectedDat[sectionIndex].start).toFixed(2);
				Trace.log("start batch in start"+sectionIndex+":"+offsetCoordinate+":"+offsetTime);
				this.batchUpdateSectionInfoByOffset(sectionIndex,offsetCoordinate,offsetTime);
				Trace.log("end batch in start");
				this.syncEditDat();
				this.notiTotSelectDur();
				return true;
			}else{
				if (this.inProcess){
					return false;
				}
				this.startSeekPt = param1 * this.dur;
				this.curOperateSprite = new SpriteForSelection();
				this.curOperateSprite.graphics.beginFill(getCurrentColor(), 1);
				this.curOperateSprite.graphics.drawRect(0, 0, 2, this.h+(isSerialMode?editorHeight:0));
				this.curOperateSprite.graphics.endFill();
				this.curOperateSprite.x = width * param1;
				addChild(this.curOperateSprite);
				this.undoMgr.recordCmd(new SetPtCmdItem(this.curOperateSprite, SetPtCmdType.SET_START));
				this.inProcess = true;
				this.selectedArr.push(this.curOperateSprite);
				return true;
			}
        }// end function

        public function renderEnd(param1:Number,forced:Boolean=false) : Boolean
        {
			Trace.log("renderEnd:"+param1);
			if(this.isSerialMode&&forced==false){
				if(sectionIndex==-1){
					this.showAlert("请选择视频片段");
					return false;
				}
				var _loc_2:Number = width*param1;
				if(_loc_2<=this.selectedArr[sectionIndex].x){
					this.showAlert("请在起点后设置终点");
					return false;
				}
//				remove the limit of end time beyond next section's start point.
//				if(sectionIndex<this.selectedArr.length-1&&_loc_2>=this.selectedArr[sectionIndex+1].x){
//					this.showAlert("包含了之前的选择区域");
//					return false;
//				}
				var sp:Sprite=this.selectedArr[sectionIndex];
				var _loc_3:Number = sp.width;
				var _loc_4:Number=selectedDat[sectionIndex].end;
				sp.width=_loc_2-sp.x;
				this.selectedDat[sectionIndex].end=(param1*dur).toFixed(2);
				this.selectedDat[sectionIndex].total=(Number(this.selectedDat[sectionIndex].end)-Number(this.selectedDat[sectionIndex].start)).toFixed(2);
				this.batchUpdateSectionInfoByOffset(sectionIndex,sp.width-_loc_3,Number(selectedDat[sectionIndex].end)-_loc_4);
				this.syncEditDat();
				this.notiTotSelectDur();
				return true;
			}else{
	            var _loc_2:Number = NaN;
	            var _loc_3:Number = NaN;
	            if (this.inProcess)
	            {
	                _loc_2 = width * param1;
	                _loc_3 = this.curOperateSprite.x;
	                this.curOperateSprite.width = _loc_2 - _loc_3;
					if(this.isSerialMode)this.curOperateSprite.addEventListener(MouseEvent.CLICK,onSliceTapped);
	                this.undoMgr.recordCmd(new SetPtCmdItem(this.curOperateSprite, SetPtCmdType.SET_END));
	                this.endSeekPt = param1 * this.dur;
	                this.selectedDat.push({start:this.startSeekPt.toFixed(2), end:this.endSeekPt.toFixed(2), total:Number(this.endSeekPt - this.startSeekPt).toFixed(2)});
	                this.syncEditDat();
	                this.curOperateSprite.isDone = true;
	                this.inProcess = false;
	                this.notiTotSelectDur();
	                return true;
	            }
	            return false;
			}
        }// end function
		
		private function batchUpdateSectionInfoByOffset(param1:int, param2:Number, param3:Number):void{
			Trace.log("batchUpdateSectionInfoByOffset:"+param1+"&"+param2+"&"+param3);
			if(param1<0||selectedDat.length<=0||param1>=selectedDat.length-1)return;
			for(var i:int=param1+1;i<selectedDat.length;i++){
				var sp:Sprite=selectedArr[i];
				sp.x+=param2;
				selectedDat[i].start=(Number(selectedDat[i].start) + param3).toFixed(2);
				selectedDat[i].end=(Number(selectedDat[i].end)+param3).toFixed(2);
			}
//			trace("--------------------");
//			trace("selectedDat[2].start="+selectedDat[2].start);
//			trace("selectedDat[2].end="+selectedDat[2].end);
//			trace("--------------------");
		}

		private function getCurrentColor():uint {
			//0xB0B0B0  0xF7AC03
			//0xFFF8DC  15592682
			var colorCode:uint = 0xB0B0B0;
			if(colorState)colorCode=0xF7AC03;
			colorState=!colorState;
			return colorCode;
		}
		
		public function removeSelection():void{
			removeChild(this.selectedArr[this.sectionIndex]);
			var _loc_1:* = this.selectedDat[sectionIndex].total;
			this.selectedArr.splice(this.sectionIndex,1);
			this.selectedDat.splice(this.sectionIndex,1);
			/*batch reset offset for sections after*/
			var offsetTime:Number = Number(_loc_1);
			var offsetCoordinate:Number = offsetTime/dur*width;
			this.batchUpdateSectionInfoByOffset(sectionIndex-1,-offsetCoordinate,-offsetTime);
			/*end*/
			this.sectionIndex=-1;
			this.syncEditDat();
			this.notiTotSelectDur();
		}
		
        public function undo(param1:SetPtCmdItem) : void
        {
            var _loc_2:* = param1.action;
            this.curOperateSprite = param1.targ as SpriteForSelection;
            if (_loc_2 === SetPtCmdType.SET_START)
            {
                this.inProcess = false;
                removeChild(this.curOperateSprite);
                this.selectedArr.pop();
            }
            else if (_loc_2 === SetPtCmdType.SET_END)
            {
                this.inProcess = true;
                this.curOperateSprite.isDone = false;
                this.curOperateSprite.width = 2;
                this.selectedDat.pop();
                this.syncEditDat();
                this.notiTotSelectDur();
            }
            return;
        }// end function

		private function showAlert(title:String):void{
			var _loc_3:* = new InfoTipsMgr();
			_loc_3.show(title);
		}
		
//		update textfield@EditField for total duration of selection
        private function notiTotSelectDur() : void
        {
            var _loc_2:Object = null;
            var _loc_3:WorkFieldUIEvt = null;
            var _loc_1:Number = 0;
            for each (_loc_2 in this.selectedDat)
            {
				Trace.log("total:"+_loc_2.total+":"+_loc_1);
                _loc_1 = _loc_1 + Number(_loc_2.total);
            }
            Trace.log("selection len", this.selectedDat.length+":::"+this.selectedDat.join("_"));
            _loc_3 = new WorkFieldUIEvt(WorkFieldUIEvt.SELECTION_CHANGE);
            _loc_3.totSelectionDuration = Number(_loc_1.toFixed(2));
            dispatchEvent(_loc_3);
            return;
        }// end function

//		update edit data@EditData for JS call
        private function syncEditDat() : void
        {
            var _loc_1:* = new WorkFieldUIEvt(WorkFieldUIEvt.UPDATE_EDIT_DAT);
            _loc_1.editDat = this.selectedDat;
            dispatchEvent(_loc_1);
            return;
        }// end function

        public function isInSelected(param1:Number) : Boolean
        {
            var _loc_3:SpriteForSelection = null;
            var _loc_2:* = param1 * width;
            for each (_loc_3 in this.selectedArr)
            {
                
                if (_loc_2 >= _loc_3.x && _loc_2 <= _loc_3.x + _loc_3.width)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function isBeforeStart(param1:Number) : Boolean
        {
            var _loc_2:* = param1 * width;
            if (_loc_2 <= this.curOperateSprite.x)
            {
                return true;
            }
            return false;
        }// end function

        public function isContainSelected(param1:Number) : Boolean
        {
            var _loc_4:SpriteForSelection = null;
            var _loc_2:* = this.curOperateSprite.x;
            var _loc_3:* = param1 * width;
            for each (_loc_4 in this.selectedArr)
            {
                
                if (_loc_4.isDone && _loc_2 <= _loc_4.x && _loc_3 >= _loc_4.x + _loc_4.width)
                {
                    return true;
                }
            }
            return false;
        }// end function

    }
}

//final class SpriteForSelection extends Sprite
//{
//    public var isDone:Boolean = false;
//
//    function SpriteForSelection()
//    {
//        return;
//    }// end function
//
//}

