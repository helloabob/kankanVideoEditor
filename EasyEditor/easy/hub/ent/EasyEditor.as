package easy.hub.ent
{
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.ui.*;
    import vsin.dcw.support.*;

    public class EasyEditor extends Sprite
    {
        private var inited:Boolean = false;
        private const VER:String = "1.0.40";
        private const TRACE_KEY:String = "easyeditor";
        private var initSrc:String;

        public function EasyEditor()
        {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.frameRate = 30;
            Security.allowDomain("*");
            Security.allowInsecureDomain("*");
            addEventListener(Event.ADDED_TO_STAGE, this.stageOn);
            return;
        }// end function

        private function stageOn(event:Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.stageOn);
            if (stage.stageWidth > 10)
            {
                this.initSrc = "ON STAGE READY";
                this.ready();
            }
            else
            {
                stage.addEventListener(Event.RESIZE, this.onResize);
            }
            return;
        }// end function

        private function onResize(event:Event) : void
        {
            if (stage.stageWidth > 10)
            {
                removeEventListener(Event.RESIZE, this.onResize);
                this.initSrc = "ON RESIZE READY";
                this.ready();
            }
            return;
        }// end function

        private function ready() : void
        {
//            var _loc_1:* = new ContextMenu();
//            _loc_1.hideBuiltInItems();
//            _loc_1.customItems.push(new ContextMenuItem(this.TRACE_KEY + "::" + this.VER));
//            contextMenu = _loc_1;
            Trace.initHelper(this.fire, root as Sprite, this.TRACE_KEY, Keyboard.NUMBER_1, true, true);
            return;
        }// end function

        private function fire() : void
        {
            var _loc_1:Object = null;
            if (!this.inited)
            {
                Trace.log(this.TRACE_KEY, this.VER);
                Trace.log("trace loaded!");
                Trace.log(this.initSrc, stage.stageWidth);
                _loc_1 = stage.loaderInfo.parameters;
				/*test*/
				_loc_1["vid"]="1670864";
				_loc_1["api_key"]="";
				_loc_1["uuid"]="e051eae7-ab0c-d4b2-1eb4-a9b256ae4bb3";
				_loc_1["topBarFull"]="1";
                /*end*/
				new EasyBoot(_loc_1, stage, root);
                this.inited = true;
            }
            return;
        }// end function

    }
}
