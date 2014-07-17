package vsin.dcw.support.comp.slide
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import vsin.dcw.support.comp.btn.*;
    import vsin.dcw.support.comp.evt.*;

    public class SliderShell extends ProgressShell
    {
        protected var skinThumb:MovieClip;
        protected var thumb:ButtonShell;
        protected var dragBound:Rectangle;
        protected var isDraging:Boolean = false;
        public var silenceDrag:Boolean = false;

        public function SliderShell(param1:MovieClip, param2:MovieClip, param3:MovieClip)
        {
            this.skinThumb = param3;
            this.thumb = new ButtonShell(param3);
            super(param1, param2);
            return;
        }// end function

        override public function enable(param1:Boolean) : void
        {
            super.enable(param1);
            this.thumb.enable(param1);
            return;
        }// end function

        override protected function init() : void
        {
            super.init();
            this.thumb.addEventListener(MouseEvent.MOUSE_DOWN, this.onDownInThumb);
            this.dragBound = new Rectangle(this.skinThumb.x, this.skinThumb.y, skinTrack.width, 0);
            return;
        }// end function

        override public function setPercent(param1:Number, param2:Boolean = false) : void
        {
            if (!this.isDraging)
            {
                super.setPercent(param1, param2);
                this.updateThumb();
            }
            return;
        }// end function

        override public function setPercentByPx(param1:Number, param2:Boolean = false) : void
        {
            if (!this.isDraging)
            {
                super.setPercentByPx(param1, param2);
                this.updateThumb();
            }
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            super.width = param1;
            this.dragBound.width = skinTrack.width;
            return;
        }// end function

        override protected function onTrackDown(event:MouseEvent) : void
        {
            super.onTrackDown(event);
            this.updateThumb();
            return;
        }// end function

        protected function onMoveInStage(event:MouseEvent) : void
        {
            this.updateFill();
            return;
        }// end function

        protected function onDownInThumb(event:MouseEvent) : void
        {
            this.skinThumb.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onMoveInStage);
            this.skinThumb.stage.addEventListener(MouseEvent.MOUSE_UP, this.onUpInStage);
            this.skinThumb.startDrag(false, this.dragBound);
            this.isDraging = true;
            dispatchEvent(new SliderEvent(SliderEvent.THUMB_DOWN));
            return;
        }// end function

        protected function onUpInStage(event:MouseEvent) : void
        {
            this.skinThumb.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMoveInStage);
            this.skinThumb.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onUpInStage);
            this.skinThumb.stopDrag();
            this.isDraging = false;
            if (this.silenceDrag)
            {
                this.updateFill();
				this.dispatchProgress();
            }
            return;
        }// end function

        protected function updateThumb() : void
        {
            var _loc_1:* = skinFill.scrollRect.width * skinTrack.scaleX + skinTrack.x;
            this.skinThumb.x = _loc_1 - this.skinThumb.width / 2;
            return;
        }// end function

        protected function updateFill() : void
        {
            var _loc_1:* = this.skinThumb.x - skinTrack.x;
            if (this.silenceDrag && this.isDraging)
            {
                super.setPercentByPx(_loc_1 + this.skinThumb.width / 2, true);
            }
            else
            {
                super.setPercentByPx(_loc_1 + this.skinThumb.width / 2);
            }
            return;
        }// end function

    }
}
