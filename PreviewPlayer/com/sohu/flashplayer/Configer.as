package com.sohu.flashplayer
{

    public class Configer extends Object
    {
        public static const HOST_PATH:String = "http://hot.vrs.sohu.com/vrs_flash.action?vid=";
        public static const SAVE_PATH:String = "http://my.tv.sohu.com/user/a/wvideo/cloudEditor/save.do";
        public static const UPDATE_PATH:String = "http://my.tv.sohu.com/user/a/wvideo/cloudEditor/update.do";
        public static var AUTO_SEEK:Boolean = false;
        public static var vid:String="";
        public static var DEBUG:Boolean = true;
        public static var RES_PATH:String;
		public static var ishls:Boolean = false;

        public function Configer()
        {
            return;
        }// end function

    }
}
