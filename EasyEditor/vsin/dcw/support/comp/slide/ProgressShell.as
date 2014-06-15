package vsin.dcw.support.comp.slide
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import vsin.dcw.support.comp.btn.*;
    import vsin.dcw.support.comp.def.*;
    import vsin.dcw.support.comp.evt.*;

    public class ProgressShell extends EventDispatcher
    {
        protected var per:Number = 0;
        protected var track:ButtonShell;
        protected var fill:ButtonShell;
        protected var skinFill:MovieClip;
        protected var skinTrack:MovieClip;

        public function ProgressShell(param1:MovieClip, param2:MovieClip)
        {
            this.skinFill = param1;
            this.skinTrack = param2;
            this.track = new ButtonShell(param2);
            this.fill = new ButtonShell(param1);
            this.init();
            return;
        }// end function

        public function getPercent() : Number
        {
            return this.per;
        }// end function

        public function getPercentByPx() : Number
        {
            return this.skinTrack.width * this.getPercent();
        }// end function

        public function setPercent(param1:Number, param2:Boolean = false) : void
        {
            param1 = param1 > 1 ? (1) : (param1);
            param1 = param1 < 0 ? (0) : (param1);
            this.per = param1;
            this.skinFill.scrollRect = new Rectangle(0, 0, this.getPercentByPx() / this.skinTrack.scaleX, this.skinFill.height);
            return;
        }// end function

        public function setPercentByPx(param1:Number, param2:Boolean = false) : void
        {
            param1 = param1 > this.skinTrack.width ? (this.skinTrack.width) : (param1);
            param1 = param1 < 0 ? (0) : (param1);
            this.skinFill.scrollRect = new Rectangle(0, 0, param1 / this.skinTrack.scaleX, this.skinFill.height);
            this.per = param1 / this.skinTrack.width;
            return;
        }// end function

        public function enableTrackMouse(param1:Boolean) : void
        {
            this.skinTrack.mouseChildren = param1;
            this.skinTrack.mouseEnabled = param1;
            this.skinFill.mouseChildren = param1;
            this.skinFill.mouseEnabled = param1;
            return;
        }// end function

        public function enable(param1:Boolean) : void
        {
            this.track.enable(param1);
            this.fill.setStat(param1 ? (ButtonStat.OUT) : (ButtonStat.DISABLED));
            return;
        }// end function

        public function get width() : Number
        {
            return this.skinTrack.width;
        }// end function

        public function set width(param1:Number) : void
        {
            this.skinTrack.width = param1;
            this.skinFill.width = param1;
            return;
        }// end function

        public function get height() : Number
        {
            return this.skinTrack.height;
        }// end function

        public function set height(param1:Number) : void
        {
            this.skinTrack.height = param1;
            this.skinFill.height = param1;
            return;
        }// end function

        protected function notifyProgChange() : void
        {
            var _loc_1:* = new ProgressEvent(ProgressEvent.PROGRESS_CHANGE);
            _loc_1.progress = this.per;
            dispatchEvent(_loc_1);
            return;
        }// end function

        protected function init() : void
        {
            this.track.addEventListener(MouseEvent.MOUSE_DOWN, this.toFill);
            this.track.addEventListener(MouseEvent.MOUSE_DOWN, this.onTrackDown);
            this.skinFill.mouseEnabled = false;
            this.skinFill.hitArea = this.skinTrack;
            return;
        }// end function

        protected function onTrackDown(event:MouseEvent) : void
        {
            this.setPercent(event.localX * this.skinTrack.scaleX / this.skinTrack.width);
            return;
        }// end function

        protected function toFill(event:MouseEvent) : void
        {
            if (this.fill.getStat() === this.track.getStat())
            {
                return;
            }
            this.track.setStat(this.fill.getStat());
            dispatchEvent(new ProgressEvent(ProgressEvent.TRACK_DOWN));
            return;
        }// end function

    }
}
