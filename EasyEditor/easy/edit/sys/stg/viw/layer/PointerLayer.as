package easy.edit.sys.stg.viw.layer
{
    import flash.display.Sprite;
    
    import easy.edit.sys.stg.EditViewFactory;
    import easy.edit.sys.stg.dat.EditUIData;
    import easy.edit.sys.stg.evt.WorkFieldUIEvt;
    import easy.edit.sys.stg.viw.comp.PointerSliderShell;
    
    import vsin.dcw.support.Trace;
    import vsin.dcw.support.comp.evt.ProgressEvent;

    public class PointerLayer extends Sprite
    {
        private var udat:EditUIData;
        private var skin:PointerSliderSkin;
        private var slider:PointerSliderShell;
        private var dur:Number;
        private var permit:Boolean = true;
        private var isTuning:Boolean = false;
        private var isNext:Object;

        public function PointerLayer()
        {
            this.skin = new PointerSliderSkin();
            addChild(this.skin);
            return;
        }// end function

        public function init(param1:Number, param2:Number) : void
        {
            this.udat = EditViewFactory.to.getCompIns(EditUIData);
            this.slider = new PointerSliderShell(this.skin.top, this.skin.bot, this.skin.thumb, this.skin.menu);
            this.slider.width = param1;
            this.slider.setPercent(0, true);
            this.slider.addEventListener(ProgressEvent.PROGRESS_CHANGE, this.onProg);
			this.slider.addEventListener(ProgressEvent.MOUSE_MOVE,onShowMouseMoveTime);
            this.dur = param2;
            var _loc_3:* = param1 - 1;
            var _loc_4:* = height - 1;
            graphics.lineStyle(1, 14934481, 1);
            graphics.moveTo(0, 0);
            graphics.lineTo(0, _loc_4);
            graphics.lineTo(_loc_3, _loc_4);
            graphics.lineTo(_loc_3, 0);
            return;
        }// end function

        public function timeUpdate(param1:Number) : void
        {
            if (!this.dur)
            {
                return;
            }
            var _loc_2:* = param1 / this.dur;
            this.slider.setPercent(this.udat.getTotProgByViewProg(_loc_2), true);
            return;
        }// end function

        public function getTotPercent() : Number
        {
            return this.udat.getTotProgByViewProg(this.slider.getPercent());
        }// end function

        public function getViewPercent() : Number
        {
            return this.slider.getPercent();
        }// end function

        public function seekOffset(param1:Number) : void
        {
            this.isTuning = true;
            this.isNext = param1 >= 0;
            Trace.log("seekOffset_getPercent:"+this.slider.getPercent()+"param1:"+param1);
            this.slider.setPercent(this.slider.getPercent() + param1);
			this.slider.dispatchProgress();
            return;
        }// end function

        public function enableSetStart(param1:Boolean) : void
        {
            this.slider.enableSetStart(param1);
            return;
        }// end function

        public function enableSetEnd(param1:Boolean) : void
        {
            this.slider.enableSetEnd(param1);
            return;
        }// end function
		
		public function seekManuallyByTime(time:Number):void{
			this.slider.seekManuallyByTime(time);
		}// end function

        public function isSetEndEnabled() : Boolean
        {
            return this.slider.isSetEndEnabled();
        }// end function

        public function isSetStartEnabled() : Boolean
        {
            return this.slider.isSetStartEnabled();
        }// end function

        public function setPermit(param1:Boolean) : void
        {
            this.permit = param1;
            return;
        }// end function

		private function onShowMouseMoveTime(event:ProgressEvent):void{
			trace("mouseover:"+event.progressOver);
			dispatchEvent(event.clone());
		}
		
        private function onProg(event:ProgressEvent) : void
        {
			this.isTuning=true;
            var _loc_2:* = new WorkFieldUIEvt(WorkFieldUIEvt.SEEK);
            _loc_2.progress = this.udat.getTotProgByViewProg(event.progress);
            _loc_2.pause = this.isTuning;
            _loc_2.isNext = this.isNext;
            Trace.log("workfield seek:", event.progress + " / " + _loc_2.progress);
            this.isTuning = false;
            this.isNext = null;
            dispatchEvent(_loc_2);
            return;
        }// end function

    }
}
