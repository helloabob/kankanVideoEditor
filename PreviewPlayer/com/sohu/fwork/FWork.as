package com.sohu.fwork
{
    import com.sohu.fwork.controller.*;
    import com.sohu.fwork.notify.*;
    import flash.display.*;

    public class FWork extends Object
    {
        public static var controller:IController;
        public static var notify:INotify;

        public function FWork()
        {
            return;
        }// end function

        public static function init(param1:Sprite) : void
        {
            var _loc_2:Controller = null;
            if (!controller && !notify)
            {
                _loc_2 = new Controller();
                controller = _loc_2;
                notify = _loc_2;
                controller.setRoot(param1);
            }
            return;
        }// end function

    }
}
