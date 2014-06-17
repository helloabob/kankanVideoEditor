package com.sohu.flashplayer.views
{
    import com.sohu.flashplayer.util.*;
    import com.sohu.fwork.view.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
	import com.sohu.flashplayer.inter_pack.errorpanel.IErrorPanel;

    public class ErrorPanel extends View implements IView, IErrorPanel
    {
        private var panel:MovieClip;
        public static const NAME:String = "ToolTip";

        public function ErrorPanel()
        {
            return;
        }// end function

        public function init() : void
        {
            if (this.panel)
            {
                return;
            }
            this.panel = GlobelResUtil.getResByName(GlobelResUtil.TIP_PANEL);
            ButtonUtil.regestButtonBaseHandler(this.panel.btn);
            this.addChild(this.panel);
            this.panel.btn.addEventListener(MouseEvent.CLICK, this.clickCloseHandler);
            this.resize(this.stage.stageWidth, this.stage.stageHeight);
            return;
        }// end function

        private function clickCloseHandler(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        public function close() : void
        {
            this.removeChild(this.panel);
            this.panel.btn.removeEventListener(MouseEvent.CLICK, this.clickCloseHandler);
            this.panel = null;
            return;
        }// end function

        public function upToolTip(param1:String) : void
        {
            (this.panel.text as TextField).text = param1;
            this.resize(stage.stageWidth, stage.stageHeight);
            return;
        }// end function

        override public function resize(param1:int, param2:int) : void
        {
            if (this.panel)
            {
                this.panel.x = param1 / 2 - this.panel.width / 2;
                this.panel.y = param2 / 2 - this.panel.height / 2;
            }
            return;
        }// end function

    }
}
