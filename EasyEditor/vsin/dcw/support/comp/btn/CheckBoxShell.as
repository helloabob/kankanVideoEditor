package vsin.dcw.support.comp.btn
{
    import flash.display.*;
    import flash.events.*;
    import vsin.dcw.support.comp.def.*;
    import vsin.dcw.support.comp.evt.*;

    public class CheckBoxShell extends ButtonShell
    {
        protected var _isChecked:Boolean = false;

        public function CheckBoxShell(param1:MovieClip)
        {
            super(param1);
            return;
        }// end function

        public function isChecked() : Boolean
        {
            return this._isChecked;
        }// end function

        public function checked(param1:Boolean) : void
        {
            this._isChecked = param1;
            var _loc_2:* = this._isChecked ? (4) : (0);
            _curStat = _curStat % 4 + _loc_2;
            updateStat();
            return;
        }// end function

        override public function enable(param1:Boolean) : void
        {
            _isEnabled = param1;
            _curStat = _isEnabled ? (this._isChecked ? (ButtonStat.SELECTED_OUT) : (ButtonStat.OUT)) : (this._isChecked ? (ButtonStat.SELECTED_DISABLED) : (ButtonStat.DISABLED));
            updateStat();
            skin.buttonMode = param1;
            skin.mouseEnabled = param1;
            return;
        }// end function

        override protected function onOver(event:MouseEvent) : void
        {
            if (_isEnabled)
            {
                _curStat = this._isChecked ? (ButtonStat.SELECTED_OVER) : (ButtonStat.OVER);
                updateStat();
                dispatchEvent(event);
            }
            else
            {
                event.stopImmediatePropagation();
            }
            return;
        }// end function

        override protected function onDown(event:MouseEvent) : void
        {
            if (_isEnabled)
            {
                _curStat = this._isChecked ? (ButtonStat.SELECTED_DOWN) : (ButtonStat.DOWN);
                updateStat();
                dispatchEvent(event);
            }
            else
            {
                event.stopImmediatePropagation();
            }
            return;
        }// end function

        override protected function onUp(event:MouseEvent) : void
        {
            var _loc_2:ButtonEvent = null;
            if (_isEnabled)
            {
                this._isChecked = !this._isChecked;
                _curStat = this._isChecked ? (ButtonStat.SELECTED_OVER) : (ButtonStat.OVER);
                updateStat();
                dispatchEvent(event);
                _loc_2 = new ButtonEvent(ButtonEvent.BUTTON_CHECKED);
                _loc_2.isChecked = this._isChecked;
                dispatchEvent(_loc_2);
            }
            else
            {
                event.stopImmediatePropagation();
            }
            return;
        }// end function

        override protected function onOut(event:MouseEvent) : void
        {
            if (_isEnabled)
            {
                _curStat = this._isChecked ? (ButtonStat.SELECTED_OUT) : (ButtonStat.OUT);
                updateStat();
                dispatchEvent(event);
            }
            else
            {
                event.stopImmediatePropagation();
            }
            return;
        }// end function

    }
}
