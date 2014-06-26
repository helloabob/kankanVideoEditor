package com.sohu.flashplayer.util
{
    import flash.utils.*;
    
    import mx.core.Singleton;

    public class Memory extends Object
    {
        public static var streams:Dictionary = new Dictionary(true);
        public static var autoSeek:Array=[];
		private static var ins:Memory;
		public var commands:Dictionary=new Dictionary();
		public var proxys:Dictionary=new Dictionary();
		public var views:Dictionary=new Dictionary();
		
        public function Memory(param1:Singleton)
        {
            return;
        }// end function
		public static function getInstents():Memory
		{
			if(!ins){
				ins=new Memory(new Singleton());
			}
			return ins;
			//            var _loc_1:* = ins || new LoadingMgr(new Singleton());
			//            ins = ins || new LoadingMgr(new Singleton());
			//            return _loc_1;
		}// end function

    }
}

final class Singleton extends Object
{
	
	function Singleton()
	{
		return;
	}// end function
	
}
