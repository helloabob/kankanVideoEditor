package easy.edit.sys.stg.viw.comp
{
    import easy.edit.sys.stg.evt.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import vsin.dcw.support.comp.slide.*;

    public class PointerSliderShell extends SliderShell
    {
        private var setStartBtn:TextButtonShell;
        private var setEndBtn:TextButtonShell;
        private var setStartSkin:MovieClip;
        private var setEndSkin:MovieClip;
        private var menuSkin:PointerMenuSkin;
        private var outTimer:int = 0;
        private var permit:Boolean;

        public function PointerSliderShell(param1:MovieClip, param2:MovieClip, param3:MovieClip, param4:MovieClip)
        {
            this.menuSkin = param4 as PointerMenuSkin;
            this.setStartBtn = new TextButtonShell(this.menuSkin.setStart);
            this.setEndBtn = new TextButtonShell(this.menuSkin.setEnd);
            this.setStartSkin = this.menuSkin.setStart;
            this.setEndSkin = this.menuSkin.setEnd;
            super(param1, param2, param3);
            silenceDrag = true;
			
			this.menuSkin.visible=false;
			this.setStartBtn.visible=false;
			this.setStartBtn.visible=false;
			this.setStartSkin.visible=false;
			this.setEndSkin.visible=false;
            return;
        }// end function

        public function enableSetStart(param1:Boolean) : void
        {
            this.setStartBtn.enable(param1);
            this.setStartBtn.setTitle("设为起点");
            return;
        }// end function

        public function enableSetEnd(param1:Boolean) : void
        {
            this.setEndBtn.enable(param1);
            this.setEndBtn.setTitle("设为终点");
            return;
        }// end function

        public function isSetEndEnabled() : Boolean
        {
            return this.setEndBtn.isEnabled();
        }// end function

        public function isSetStartEnabled() : Boolean
        {
            return this.setStartBtn.isEnabled();
        }// end function

        override protected function init() : void
        {
            super.init();
            this.setStartBtn.setTitle("设为起点");
            this.setEndBtn.setTitle("设为终点");
            this.setStartSkin.addEventListener(MouseEvent.MOUSE_UP, this.onSetStart);
            this.setEndSkin.addEventListener(MouseEvent.MOUSE_UP, this.onSetEnd);
            skinThumb.addEventListener(MouseEvent.ROLL_OVER, this.onThumbOver);
            this.menuSkin.addEventListener(MouseEvent.ROLL_OVER, this.onThumbOver);
            skinThumb.addEventListener(MouseEvent.ROLL_OUT, this.onThumbOut);
            this.menuSkin.addEventListener(MouseEvent.ROLL_OUT, this.onThumbOut);
            this.menuSkin.visible = false;
            this.permit = true;
            this.enableSetEnd(false);
            return;
        }// end function

        override protected function updateThumb() : void
        {
            super.updateThumb();
            this.calcBtnPos();
            return;
        }// end function

        protected function calcBtnPos() : void
        {
            var _loc_1:* = skinThumb.x + skinThumb.width + this.menuSkin.width;
            if (_loc_1 > skinTrack.width)
            {
                this.menuSkin.x = skinThumb.x - this.menuSkin.width;
            }
            else
            {
                this.menuSkin.x = skinThumb.x + skinThumb.width;
            }
            return;
        }// end function

        override protected function onDownInThumb(event:MouseEvent) : void
        {
            super.onDownInThumb(event);
            this.permit = false;
            this.menuSkin.visible = false;
            return;
        }// end function

        override protected function onUpInStage(event:MouseEvent) : void
        {
            super.onUpInStage(event);
            this.permit = true;
            if (skinThumb.hitTestPoint(event.stageX, event.stageY))
            {
                this.menuSkin.visible = true;
            }
            this.calcBtnPos();
            return;
        }// end function

        protected function onThumbOver(event:MouseEvent) : void
        {
            clearTimeout(this.outTimer);
            this.menuSkin.visible = this.permit && true;
            return;
        }// end function

        protected function onThumbOut(event:MouseEvent) : void
        {
            clearTimeout(this.outTimer);
            this.outTimer = setTimeout(this.onThumbOutTimeout, 500, event);
            return;
        }// end function

        protected function onSetStart(event:MouseEvent) : void
        {
            this.enableSetStart(false);
            var _loc_2:* = new WorkFieldUIEvt(WorkFieldUIEvt.SET_START_PT);
            _loc_2.viewProgress = per;
            skinThumb.dispatchEvent(_loc_2);
            return;
        }// end function

        protected function onSetEnd(event:MouseEvent) : void
        {
            this.enableSetEnd(false);
            var _loc_2:* = new WorkFieldUIEvt(WorkFieldUIEvt.SET_END_PT);
            _loc_2.viewProgress = per;
            skinThumb.dispatchEvent(_loc_2);
            return;
        }// end function

        private function onThumbOutTimeout(event:MouseEvent) : void
        {
            this.menuSkin.visible = false;
            return;
        }// end function

    }
}
