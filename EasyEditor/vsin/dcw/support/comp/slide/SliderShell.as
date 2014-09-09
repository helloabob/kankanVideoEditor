package vsin.dcw.support.comp.slide
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    
    import easy.edit.sys.stg.EditViewFactory;
    import easy.edit.sys.stg.dat.EditUIData;
    
    import vsin.dcw.support.Trace;
    import vsin.dcw.support.comp.btn.ButtonShell;
    import vsin.dcw.support.comp.evt.ProgressEvent;
    import vsin.dcw.support.comp.evt.SliderEvent;

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
                this.updateFill(true);
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

        protected function updateFill(isUp:Boolean=false) : void
        {
            var _loc_1:* = this.skinThumb.x - skinTrack.x;
			_loc_1 += this.skinThumb.width/2;
			if(isUp){
				var udat:EditUIData = EditViewFactory.to.getCompIns(EditUIData);
				var rate:Number = _loc_1 / this.skinTrack.width;
				var _loc_5:* = udat.transTotProgToClipIdAndClipFlyTime(rate);
				var _loc_2:* = udat.findClosestSp(_loc_5[0], _loc_5[1]);
				var res:Number = udat.transSecToViewProg(_loc_2);
//				_loc_1 = res * this.skinTrack.width;
				Trace.log("updateFill:"+rate+"   res:"+res+"  l5:"+_loc_5[0]+","+_loc_5[1]+"  l2:"+_loc_2);
				this.setPercent(res);
			}else{
	            if (this.silenceDrag && this.isDraging)
	            {
	                super.setPercentByPx(_loc_1, true);
	            }
	            else
	            {
	                super.setPercentByPx(_loc_1);
	            }
				var evt:ProgressEvent = new ProgressEvent(ProgressEvent.MOUSE_MOVE);
				var _loc_6:EditUIData = EditViewFactory.to.getCompIns(EditUIData);
				var _loc_7:Number = _loc_1 / this.skinTrack.width;
				var _loc_10:* = _loc_6.transTotProgToClipIdAndClipFlyTime(_loc_7);
				evt.progressOver = _loc_10[2];
				this.dispatchEvent(evt);
			}
            return;
        }// end function

    }
}
