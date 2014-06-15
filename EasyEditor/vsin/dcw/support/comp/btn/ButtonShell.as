package vsin.dcw.support.comp.btn
{
    import flash.display.*;
    import flash.events.*;
    import vsin.dcw.support.comp.def.*;

    public class ButtonShell extends EventDispatcher
    {
        protected var _curStat:int = 1;
        protected var _lastStat:int = 1;
        protected var _isEnabled:Boolean = true;
        protected var skin:MovieClip;

        public function ButtonShell(param1:MovieClip)
        {
            this.skin = param1;
            this.init();
            return;
        }// end function

        public function isEnabled() : Boolean
        {
            return this._isEnabled;
        }// end function

        public function enable(param1:Boolean) : void
        {
            this._isEnabled = param1;
            this._curStat = this._isEnabled ? (ButtonStat.OUT) : (ButtonStat.DISABLED);
            this.updateStat();
            this.skin.buttonMode = param1;
            this.skin.mouseEnabled = param1;
            return;
        }// end function

        public function getStat() : int
        {
            return this._curStat;
        }// end function

        public function setStat(param1:int) : void
        {
            this._curStat = param1;
            this.updateStat();
            return;
        }// end function

        public function get width() : Number
        {
            return this.skin.width;
        }// end function

        public function get height() : Number
        {
            return this.skin.height;
        }// end function

        public function set width(param1:Number) : void
        {
            this.skin.width = param1;
            return;
        }// end function

        public function set height(param1:Number) : void
        {
            this.skin.height = param1;
            return;
        }// end function

        public function get x() : Number
        {
            return this.skin.x;
        }// end function

        public function get y() : Number
        {
            return this.skin.y;
        }// end function

        public function set x(param1:Number) : void
        {
            this.skin.x = param1;
            return;
        }// end function

        public function set y(param1:Number) : void
        {
            this.skin.y = param1;
            return;
        }// end function

        public function set visible(param1:Boolean) : void
        {
            this.skin.visible = param1;
            return;
        }// end function

        public function delMe() : void
        {
            var _loc_1:* = this.skin.parent;
            if (_loc_1 && _loc_1.contains(this.skin))
            {
                _loc_1.removeChild(this.skin);
            }
            return;
        }// end function

        public function addMeTo(param1:DisplayObjectContainer) : void
        {
            param1.addChild(this.skin);
            return;
        }// end function

        public function fireEvent(event:MouseEvent) : void
        {
            this.skin.dispatchEvent(event);
            return;
        }// end function

        protected function init() : void
        {
            this.skin.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
            this.skin.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
            this.skin.addEventListener(MouseEvent.MOUSE_DOWN, this.onDown);
            this.skin.addEventListener(MouseEvent.MOUSE_UP, this.onUp);
            this.skin.buttonMode = true;
            this.skin.gotoAndStop(ButtonStat.OUT);
            return;
        }// end function

        protected function onUp(event:MouseEvent) : void
        {
            if (this._isEnabled)
            {
                this._curStat = ButtonStat.OVER;
                this.updateStat();
                dispatchEvent(event);
            }
            else
            {
                event.stopImmediatePropagation();
            }
            return;
        }// end function

        protected function onOver(event:MouseEvent) : void
        {
            if (this._isEnabled)
            {
                this._curStat = ButtonStat.OVER;
                this.updateStat();
                dispatchEvent(event);
            }
            else
            {
                event.stopImmediatePropagation();
            }
            return;
        }// end function

        protected function onDown(event:MouseEvent) : void
        {
            if (this._isEnabled)
            {
                this._curStat = ButtonStat.DOWN;
                this.updateStat();
                dispatchEvent(event);
            }
            else
            {
                event.stopImmediatePropagation();
            }
            return;
        }// end function

        protected function onOut(event:MouseEvent) : void
        {
            if (this._isEnabled)
            {
                this._curStat = ButtonStat.OUT;
                this.updateStat();
                dispatchEvent(event);
            }
            else
            {
                event.stopImmediatePropagation();
            }
            return;
        }// end function

        protected function updateStat() : void
        {
            if (this._curStat === this._lastStat)
            {
                return;
            }
            this.skin.gotoAndStop(this._curStat);
            this._lastStat = this._curStat;
            return;
        }// end function

    }
}
