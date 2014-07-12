package easy.edit.sys.stg.viw.layer
{
    import flash.display.Sprite;
    
    import easy.edit.sys.stg.EditViewFactory;
    import easy.edit.sys.stg.dat.SetPtCmdItem;
    import easy.edit.sys.stg.dat.SetPtCmdMgr;
    import easy.edit.sys.stg.dat.def.SetPtCmdType;
    import easy.edit.sys.stg.evt.WorkFieldUIEvt;
    
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

        public function renderStart(param1:Number) : Boolean
        {
			trace("renderStart");
            if (this.inProcess)
            {
				trace("renderStart_in_process");
                return false;
            }
            this.startSeekPt = param1 * this.dur;
            this.curOperateSprite = new SpriteForSelection();
            this.curOperateSprite.graphics.beginFill(15592682, 1);
            this.curOperateSprite.graphics.drawRect(0, 0, 2, this.h);
            this.curOperateSprite.graphics.endFill();
            this.curOperateSprite.x = width * param1;
            addChild(this.curOperateSprite);
            this.undoMgr.recordCmd(new SetPtCmdItem(this.curOperateSprite, SetPtCmdType.SET_START));
            this.inProcess = true;
            this.selectedArr.push(this.curOperateSprite);
            return true;
        }// end function

        public function renderEnd(param1:Number) : Boolean
        {
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            if (this.inProcess)
            {
                _loc_2 = width * param1;
                _loc_3 = this.curOperateSprite.x;
                this.curOperateSprite.width = _loc_2 - _loc_3;
                this.undoMgr.recordCmd(new SetPtCmdItem(this.curOperateSprite, SetPtCmdType.SET_END));
                this.endSeekPt = param1 * this.dur;
                this.selectedDat.push({start:this.startSeekPt, end:this.endSeekPt, total:Number(this.endSeekPt - this.startSeekPt).toFixed(2)});
                this.syncEditDat();
                this.curOperateSprite.isDone = true;
                this.inProcess = false;
                this.notiTotSelectDur();
                return true;
            }
            return false;
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

