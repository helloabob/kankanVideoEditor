package vsin.dcw.support.comp.slide
{
    import flash.display.MovieClip;
    import flash.events.EventDispatcher;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    
    import easy.edit.sys.stg.EditViewFactory;
    import easy.edit.sys.stg.dat.EditUIData;
    
    import vsin.dcw.support.Trace;
    import vsin.dcw.support.comp.btn.ButtonShell;
    import vsin.dcw.support.comp.def.ButtonStat;
    import vsin.dcw.support.comp.evt.ProgressEvent;

    public class ProgressShell extends EventDispatcher
    {
        protected var per:Number = 0;
        protected var track:ButtonShell;
        protected var fill:ButtonShell;
//		PointerSliderSkin_top
        protected var skinFill:MovieClip;
//		PointerSliderSkin_bot
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
			trace("ProgressShell_enableTrackMouse");
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
			Trace.log("notifyProgChange:"+this.per);
            var _loc_1:* = new vsin.dcw.support.comp.evt.ProgressEvent(vsin.dcw.support.comp.evt.ProgressEvent.PROGRESS_CHANGE);
            _loc_1.progress = this.per;
            dispatchEvent(_loc_1);
            return;
        }// end function

        protected function init() : void
        {
            this.track.addEventListener(MouseEvent.MOUSE_DOWN, this.toFill);
            this.track.addEventListener(MouseEvent.MOUSE_DOWN, this.onTrackDown);
			this.track.addEventListener(MouseEvent.MOUSE_MOVE, this.MouseMove);
            this.skinFill.mouseEnabled = false;
            this.skinFill.hitArea = this.skinTrack;
            return;
        }// end function

		protected function MouseMove(event:MouseEvent):void{
			trace("ProgressShell_MOUSE_MOVE");
			var evt:ProgressEvent = new ProgressEvent(ProgressEvent.MOUSE_MOVE);
			var udat:EditUIData = EditViewFactory.to.getCompIns(EditUIData);
			var rate:Number = event.localX * this.skinTrack.scaleX / this.skinTrack.width;
			var _loc_1:* = udat.transTotProgToClipIdAndClipFlyTime(rate);
			evt.progressOver = _loc_1[2];
			this.dispatchEvent(evt);
		}
		
        protected function onTrackDown(event:MouseEvent) : void
        {
//			this.setPercent(event.localX * this.skinTrack.scaleX / this.skinTrack.width);
			
			/*add for find next key frame point*/
			var udat:EditUIData = EditViewFactory.to.getCompIns(EditUIData);
			var rate:Number = event.localX * this.skinTrack.scaleX / this.skinTrack.width;
			var _loc_1:* = udat.transTotProgToClipIdAndClipFlyTime(rate);
			var _loc_2:* = udat.findClosestSp(_loc_1[0], _loc_1[1]);
//			var _loc_3:* = _loc_2 - _loc_1[1];
			var res:Number = udat.transSecToViewProg(_loc_2);
			this.setPercent(res);
			Trace.log("onTrackDown_rate:"+rate+"   res:"+res+"  l1:"+_loc_1[0]+","+_loc_1[1]+"  l2:"+_loc_2);
			/*add*/
			this.dispatchProgress();
//			this.dispatchProgress(event.localX * this.skinTrack.scaleX / this.skinTrack.width);
            return;
        }// end function

		public function dispatchProgress():void{
			var evt:vsin.dcw.support.comp.evt.ProgressEvent=new vsin.dcw.support.comp.evt.ProgressEvent(vsin.dcw.support.comp.evt.ProgressEvent.PROGRESS_CHANGE);
			evt.progress=this.per;
//			evt.progress = rate;
			this.dispatchEvent(evt);
		}
		
        protected function toFill(event:MouseEvent) : void
        {
            if (this.fill.getStat() === this.track.getStat())
            {
                return;
            }
            this.track.setStat(this.fill.getStat());
            dispatchEvent(new vsin.dcw.support.comp.evt.ProgressEvent(vsin.dcw.support.comp.evt.ProgressEvent.TRACK_DOWN));
            return;
        }// end function

    }
}
