package com.sohu.flashplayer.inter_pack.hotvrs
{
    import com.sohu.fwork.proxy.ProxyResp;

    public class HotVrsResp extends ProxyResp
    {
        public var ip:String;
        public var prot:int = 2;
        public var files:Array;
        public var news:Array;
        public var keys:Array;
        public var times:Array;
		public var keyframes:Array;
        public var byteLens:Array;
        public var totalBytes:int;
        public var totalDuration:Number;
        public var starts:Array;

        public function HotVrsResp()
        {
            return;
        }// end function

    }
}
