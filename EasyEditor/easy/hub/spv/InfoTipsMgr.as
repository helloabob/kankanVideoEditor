package easy.hub.spv
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import vsin.dcw.support.comp.btn.*;
    import vsin.dcw.support.proj.*;

    public class InfoTipsMgr extends Sprite
    {
        private var skin:TipsSkin;
        private var cls:ButtonShell;
        private var content:TextField;
        private var omg:Sprite;
        private const OMG_PADDING_RIGHT:int = 10;

        public function InfoTipsMgr()
        {
            this.skin = new TipsSkin();
            this.cls = new ButtonShell(this.skin.clsBtn);
            this.omg = this.skin.omg;
            this.content = this.skin.content;
            this.cls.addEventListener(MouseEvent.CLICK, this.onCls);
            this.cls.visible = false;
            visible = false;
            addChild(this.skin);
            return;
        }// end function

        public function show(param1:String) : void
        {
            LayerMgr.tipLayer.addChild(this);
            this.content.text = param1;
            this.setLayout();
            PopupMgr.addToShow(this._show);
            return;
        }// end function

        public function hide() : void
        {
            visible = false;
            this.remove();
            PopupMgr.popup();
            return;
        }// end function

        protected function setLayout() : void
        {
            var _loc_1:* = this.omg.width + this.content.textWidth + this.OMG_PADDING_RIGHT;
            this.omg.x = (width - _loc_1) / 2;
            this.content.x = this.omg.x + this.omg.width + this.OMG_PADDING_RIGHT;
            return;
        }// end function

        protected function _show() : void
        {
            x = (stage.stageWidth - width) / 2;
            y = (stage.stageHeight - height) / 2;
            visible = true;
            setTimeout(this.hide, 2000);
            return;
        }// end function

        protected function onCls(event:MouseEvent) : void
        {
            this.hide();
            return;
        }// end function

        protected function remove() : void
        {
            this.cls.removeEventListener(MouseEvent.CLICK, this.onCls);
            if (parent && parent.contains(this))
            {
                parent.removeChild(this);
            }
            return;
        }// end function

    }
}
