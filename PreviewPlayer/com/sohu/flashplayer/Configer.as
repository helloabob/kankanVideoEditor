package com.sohu.flashplayer
{

    public class Configer extends Object
    {
        public static const HOST_PATH:String = "http://hot.vrs.sohu.com/vrs_flash.action?vid=";
        public static const SAVE_PATH:String = "http://my.tv.sohu.com/user/a/wvideo/cloudEditor/save.do";
        public static const UPDATE_PATH:String = "http://my.tv.sohu.com/user/a/wvideo/cloudEditor/update.do";
		public static const VIDEO_PATH:String = "http://localhost/video.php";
        public static var AUTO_SEEK:Boolean = false;
        public static var vid:String;
        public static var DEBUG:Boolean = false;
        public static var RES_PATH:String;

        public function Configer()
        {
            return;
        }// end function

    }
}
