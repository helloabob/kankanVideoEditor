package easy.edit.sys.stg.viw
{
    import easy.edit.sys.stg.*;
    import easy.edit.sys.stg.dat.*;
    import easy.edit.sys.stg.evt.*;
    import easy.edit.sys.stg.viw.comp.*;
    import flash.display.*;
    import flash.text.*;
    import vsin.dcw.support.*;
    import vsin.dcw.support.comp.evt.*;

    public class ProgTest extends Sprite
    {
        private var udat:EditUIData;
        private var skin:ProgSkinTest;
        private var slider:SliderWithDatProgShell;
        private var time:TextField;
        private var totTime:TextField;
        private var dur:Number;
        private var totBytes:Number;

        public function ProgTest()
        {
            return;
        }// end function

        public function init() : void
        {
            this.udat = EditViewFactory.to.getCompIns(EditUIData);
            this.skin = new ProgSkinTest();
            this.slider = new SliderWithDatProgShell(this.skin.top, this.skin.bot, this.skin.thumb, this.skin.dltop);
            this.slider.width = this.udat.stgWidth;
            this.slider.setPercent(0, true);
            this.slider.addEventListener(ProgressEvent.PROGRESS_CHANGE, this.onProgChange);
            this.time = this.skin.time;
            this.totTime = this.skin.totTime;
            addChild(this.skin);
            return;
        }// end function

        public function setDat(param1:Number, param2:Number) : void
        {
            this.dur = param1;
            this.totBytes = param2;
            this.totTime.text = Tools.formatTime(param1);
            return;
        }// end function

        public function setFlyTime(param1:Number) : void
        {
            if (!this.dur)
            {
                Trace.err("workfield not ready, can\'t set time progress");
                return;
            }
            var _loc_2:* = param1 / this.dur;
            this.slider.setPercent(_loc_2, true);
            this.time.text = Tools.formatTime(param1);
            return;
        }// end function

        public function setDatProg(param1:Number) : void
        {
            if (!this.totBytes)
            {
                Trace.err("workfield not ready, can\'t set dat progress");
                return;
            }
            this.slider.setDatProg(param1 / this.totBytes);
            return;
        }// end function

        private function onProgChange(event:ProgressEvent) : void
        {
            var _loc_2:* = new WorkFieldUIEvt(WorkFieldUIEvt.SEEK);
            _loc_2.progress = event.progress;
            dispatchEvent(_loc_2);
            return;
        }// end function

    }
}
