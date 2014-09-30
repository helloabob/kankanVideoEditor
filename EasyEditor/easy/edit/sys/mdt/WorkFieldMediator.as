package easy.edit.sys.mdt
{
    import easy.edit.pro.*;
    import easy.edit.sys.com.cmd.*;
    import easy.edit.sys.com.dat.*;
    import easy.edit.sys.stg.*;
    import easy.edit.sys.stg.dat.*;
    import easy.edit.sys.stg.evt.*;
    import easy.edit.sys.stg.viw.*;
    import easy.hub.evt.*;
    import flash.display.*;
    import vsin.dcw.support.*;

    public class WorkFieldMediator extends Object
    {
        private var dat:EditDat;
        private var udat:EditUIData;
        private var prog:ProgTest;
        private var edit:EditField;
        private var teller:EditTeller;
        private var name:String = "[WorkFieldMediator]";

		/**
		 * @param1:sprite
		 * @param2:ProgTest
		 * @param3:EditField
		 * */
        public function WorkFieldMediator(param1:Sprite, param2:ProgTest, param3:EditField)
        {
            EditViewFactory.to.registComp(SetPtCmdMgr);
            EditViewFactory.to.registComp(EditUIData);
            this.prog = param2;
            this.edit = param3;
            this.udat = EditViewFactory.to.getCompIns(EditUIData);
            this.udat.stgWidth = param1.stage.stageWidth;
            this.udat.stgHeight = 400;
            this.dat = EditFactory.to.getCompIns(EditDat);
            this.teller = EditFactory.to.getCompIns(EditTeller);
            param2.addEventListener(WorkFieldUIEvt.SEEK, this.dispatchOut);
            param3.addEventListener(WorkFieldUIEvt.SEEK, this.dispatchOut);
            param3.addEventListener(WorkFieldUIEvt.PAUSE, this.dispatchOut);
            param3.addEventListener(WorkFieldUIEvt.RESUME, this.dispatchOut);
            param3.addEventListener(WorkFieldUIEvt.UPDATE_EDIT_DAT, this.dispatchTo);
            EditDispatcher.to.addEvent(TimerEvt, TimerEvt.TIME, this.onTimeCall);
            EditDispatcher.to.addEvent(KeyFrEvt, KeyFrEvt.KEY_FRAME_LOADED, this.onKeyFr);
            EditDispatcher.to.addEvent(EditNetEvt, EditNetEvt.HOT_SPOT_LOADED, this.onHotspotLoaded);
            EditDispatcher.to.addEvent(KeyPressedEvt, KeyPressedEvt.SET_END_PT, this.onKeyPressed);
            EditDispatcher.to.addEvent(KeyPressedEvt, KeyPressedEvt.SET_START_PT, this.onKeyPressed);
            EditDispatcher.to.addEvent(KeyPressedEvt, KeyPressedEvt.TO_LEFT, this.onKeyPressed);
            EditDispatcher.to.addEvent(KeyPressedEvt, KeyPressedEvt.TO_RIGHT, this.onKeyPressed);
            EditDispatcher.to.addEvent(KeyPressedEvt, KeyPressedEvt.UNDO, this.onKeyPressed);
            EditDispatcher.to.addEvent(KeyPressedEvt, KeyPressedEvt.TOGGLE_PLAY, this.onKeyPressed);
			EditDispatcher.to.addEvent(KeyPressedEvt, KeyPressedEvt.LEFT_BRACKET, this.onKeyPressed);
			EditDispatcher.to.addEvent(KeyPressedEvt, KeyPressedEvt.RIGHT_BRACKET, this.onKeyPressed);
            EditDispatcher.to.addEvent(StmStatEvt, StmStatEvt.START, this.onStmStat);
            EditDispatcher.to.addEvent(StmStatEvt, StmStatEvt.RESUME, this.onStmStat);
            EditDispatcher.to.addEvent(StmStatEvt, StmStatEvt.PAUSE, this.onStmStat);
            return;
        }// end function

        private function dispatchOut(param1:WorkFieldUIEvt) : void
        {
            Trace.log(this.name, "dispatchOut " + (param1 && param1.type));
            param1.stopImmediatePropagation();
            var _loc_2:* = new WorkEvt(WorkEvt.PREFIX + param1.type);
            _loc_2.progress = param1.progress;
            _loc_2.pause = param1.pause;
            _loc_2.isNext = param1.isNext;
            this.teller.dispatchEvent(_loc_2);
            return;
        }// end function

        private function dispatchTo(param1:WorkFieldUIEvt) : void
        {
            Trace.log(this.name, "dispatchTo " + (param1 && param1.type));
            var _loc_2:* = new EditMdtEvt(param1.type);
            _loc_2.editDat = param1.editDat;
            EditDispatcher.to.dispatch(_loc_2);
            return;
        }// end function

        private function onTimeCall(param1:TimerEvt) : void
        {
            this.prog.setFlyTime(param1.flyTime);
            this.prog.setDatProg(param1.datLoaded);
            this.edit.updateFlyTime(param1.flyTime);
            return;
        }// end function

        private function onKeyFr(param1:KeyFrEvt) : void
        {
            var _loc_3:Array = null;
            var _loc_4:String = null;
            Trace.log(this.name, "onKeyFr");
            Trace.log("keyframe loaded", param1.keyFrDat.length);
            this.udat.clipDurArr = param1.clipDurArr;
			this.udat.KEYFR_OFFSET_AVOID = param1.threshold;
            var _loc_2:Array = [];
            for each (_loc_4 in param1.keyFrDat)
            {
                
                if (_loc_4.slice(-1) === ";")
                {
                    _loc_4 = _loc_4.slice(0, -1);
                }
                _loc_3 = _loc_4.split(";");
                _loc_2.push(_loc_3);
            }
            this.udat.keyFrDat = _loc_2;
            this.prog.setDat(param1.totTime, param1.totBytes);
            this.edit.setDat(param1.totTime, param1.tvName, param1.epg);
            return;
        }// end function

        private function onHotspotLoaded(param1:EditNetEvt) : void
        {
            Trace.log(this.name, "onHotspotLoaded");
            this.edit.updateHotField(this.dat.hotspot);
            return;
        }// end function

        private function onKeyPressed(param1:KeyPressedEvt) : void
        {
            Trace.log(this.name, "onKeyPressed");
            switch(param1.type)
            {
                case KeyPressedEvt.SET_END_PT:
                {
                    Trace.log("FLASH KEY setEndPoint");
                    this.edit.setEndPoint();
                    break;
                }
                case KeyPressedEvt.SET_START_PT:
                {
                    Trace.log("FLASH KEY setStartPoint");
                    this.edit.setStartPoint();
                    break;
                }
                case KeyPressedEvt.TO_LEFT:
                {
                    Trace.log("FLASH KEY moveToLeftKeyFr");
                    this.edit.moveToLeftKeyFr();
                    break;
                }
                case KeyPressedEvt.TO_RIGHT:
                {
                    Trace.log("FLASH KEY moveToRightKeyFr");
                    this.edit.moveToRightKeyFr();
                    break;
                }
                case KeyPressedEvt.UNDO:
                {
                    Trace.log("FLASH KEY undo");
                    this.edit.undo();
                    break;
                }
                case KeyPressedEvt.TOGGLE_PLAY:
                {
                    Trace.log("JS KEY togglePlay");
                    this.edit.togglePlay();
                    break;
                }
				case KeyPressedEvt.LEFT_BRACKET:
				{
					Trace.log("JS KEY leftBracket");
					this.edit.seekSelectionByType(0);
					break;
				}
				case KeyPressedEvt.RIGHT_BRACKET:
				{
					Trace.log("JS KEY rightBracket");
					this.edit.seekSelectionByType(1);
					break;
				}
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onStmStat(param1:StmStatEvt) : void
        {
            Trace.log(this.name, "onStmStat");
            switch(param1.type)
            {
                case StmStatEvt.PAUSE:
                {
                    this.edit.updatePlayBtn(false);
                    break;
                }
                case StmStatEvt.RESUME:
                {
                    this.edit.updatePlayBtn(true);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
