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
        private var selectedDat:Array;
        private var startSeekPt:Number;
        private var endSeekPt:Number;
        private var undoMgr:SetPtCmdMgr;
		
		private var editorHeight:int=10;
		public var isSerialMode:Boolean=true;
		private var line:Sprite;
		private var sectionIndex:int=-1;
		private var btnCommit:CommitBtnSkin;

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
				if(btnCommit==null)btnCommit = new CommitBtnSkin();
				btnCommit.width=60;
				btnCommit.height=25;
				btnCommit.y=this.h+this.editorHeight+5;
				btnCommit.x=50;
				btnCommit.mouseEnabled=true;
				btnCommit.addEventListener(MouseEvent.CLICK,onCompleteSerialMode);
				addChild(btnCommit);
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
			if(line)line.parent.removeChild(line);
			for each(var sp:Sprite in this.selectedArr){
				sp.height=this.h;
				if(sp.hasEventListener(MouseEvent.CLICK))sp.removeEventListener(MouseEvent.CLICK,onSliceTapped);
			}
			btnCommit.removeEventListener(MouseEvent.CLICK,onCompleteSerialMode);
			removeChild(btnCommit);
		}
		
		private function onSliceTapped(evt:MouseEvent):void{
			var sp:Sprite=evt.target as Sprite;
			if(line==null){
				line=new Sprite();
				line.graphics.beginFill(0xff0000,1);
				line.graphics.drawRect(0,sp.height-2,2,2);
				line.graphics.endFill();
			}
			sp.addChild(line);
			sectionIndex=this.selectedArr.indexOf(sp);
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
				if(_loc_2<sp.x){
					sp.width=sp.width+(sp.x-_loc_2);
					sp.x=_loc_2;
				}else if(_loc_2>sp.x){
					sp.width=sp.width-(_loc_2-sp.x);
					sp.x=_loc_2;
				}
				this.selectedDat[sectionIndex].start=(param1*dur).toFixed(2);
				this.selectedDat[sectionIndex].total=(this.selectedDat[sectionIndex].end-this.selectedDat[sectionIndex].start).toFixed(2);
				return true;
			}else{
				if (this.inProcess){
					return false;
				}
				this.startSeekPt = param1 * this.dur;
				this.curOperateSprite = new SpriteForSelection();
				this.curOperateSprite.graphics.beginFill(15592682, 1);
				this.curOperateSprite.graphics.drawRect(0, 0, 2, this.h+(isSerialMode?editorHeight:0));
				Trace.log("render_start");
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
				if(sectionIndex<this.selectedArr.length-1&&_loc_2>=this.selectedArr[sectionIndex+1].x){
					this.showAlert("包含了之前的选择区域");
					return false;
				}
				var sp:Sprite=this.selectedArr[sectionIndex];
//				var _loc_3:*=sp.x+sp.width;
				sp.width=_loc_2-sp.x;
				this.selectedDat[sectionIndex].end=(param1*dur).toFixed(2);
				this.selectedDat[sectionIndex].total=(this.selectedDat[sectionIndex].end-this.selectedDat[sectionIndex].start).toFixed(2);
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

