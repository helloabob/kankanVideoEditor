package com.sohu.flashplayer.util
{
    import flash.display.*;
    import flash.events.*;

    public class ButtonUtil extends Object
    {

        public function ButtonUtil()
        {
            return;
        }// end function

        public static function regestButtonBaseHandler(param1:MovieClip) : void
        {
            param1.buttonMode = true;
            param1.stop();
            param1.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
            param1.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
            param1.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
            param1.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
            return;
        }// end function

        private static function mouseDownHandler(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as MovieClip;
            _loc_2.gotoAndStop(3);
            return;
        }// end function

        private static function mouseOutHandler(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as MovieClip;
            _loc_2.gotoAndStop(1);
            return;
        }// end function

        private static function mouseOverHandler(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as MovieClip;
            _loc_2.gotoAndStop(2);
            return;
        }// end function

        private static function mouseUpHandler(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as MovieClip;
            _loc_2.gotoAndStop(1);
            return;
        }// end function

    }
}
