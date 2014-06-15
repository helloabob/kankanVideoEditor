package com.sohu.flashplayer.util
{
    import flash.display.*;

    public class GlobelResUtil extends Object
    {
        private static var resMC:MovieClip;
        public static const START_PLAY_BTN:String = "startPlay_btn";
        public static const PLAY_BTN:String = "play_btn";
        public static const PAUSE_BTN:String = "pause_btn";
        public static const FULL_SCREEN_BTN:String = "fullScreen_btn";
        public static const NORMAL_SCREEN_BTN:String = "normalScreen_btn";
        public static const PRO_TOP_MC:String = "proTop_mc";
        public static const PRO_MIDDLE_MC:String = "proMiddle_mc";
        public static const PRO_BOTTOM_MC:String = "proBottom_mc";
        public static const MINI_PRO_TOP_MC:String = "miniProTop_mc";
        public static const MINI_PRO_MIDDLE_MC:String = "miniProMiddle_mc";
        public static const MINI_PRO_BOTTOM_MC:String = "miniProBottom_mc";
        public static const DRAG_BTN:String = "pro_btn";
        public static const CTRLBG_MC:String = "ctrlBg_mc";
        public static const TIP_PANEL:String = "tiPanel";
        public static const TIME_MC:String = "time";

        public function GlobelResUtil()
        {
            return;
        }// end function

        public static function setData(param1:MovieClip) : void
        {
            resMC = param1;
            return;
        }// end function

        public static function getResByName(param1:String) : MovieClip
        {
            return resMC[param1];
        }// end function

    }
}
