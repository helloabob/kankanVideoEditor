package com.sohu.fwork.view
{
    import com.sohu.fwork.*;
    import com.sohu.fwork.baseagent.*;
    import com.sohu.fwork.notify.*;
    import flash.display.*;
    import flash.utils.*;

    public class View extends Sprite implements IView
    {
        private var events:Dictionary;
        protected var notify:INotify;

        public function View()
        {
            this.events = new Dictionary(true);
            this.notify = FWork.notify;
            return;
        }// end function

        public function addListener(param1:String, param2:Function) : void
        {
            if (this.events[param1] == null)
            {
                this.events[param1] = new Vector.<Function>;
            }
            if ((this.events[param1] as Vector.<Function>).indexOf(param2) == -1)
            {
                (this.events[param1] as Vector.<Function>).push(param2);
            }
            return;
        }// end function

        public function removeListener(param1:String, param2:Function) : void
        {
            var _loc_3:int = 0;
            if (this.events[param1] != null)
            {
                _loc_3 = 0;
                while (_loc_3 < (this.events[param1] as Vector.<Function>).length)
                {
                    
                    if ((this.events[param1] as Vector.<Function>)[_loc_3] == param2)
                    {
                        (this.events[param1] as Vector.<Function>)[_loc_3] = null;
                        (this.events[param1] as Vector.<Function>).splice(_loc_3, 1);
                    }
                    _loc_3++;
                }
                if ((this.events[param1] as Vector.<Function>).length == 0)
                {
                    this.events[param1] = null;
                    delete this.events[param1];
                }
            }
            return;
        }// end function

        public function hasListener(param1:String) : Boolean
        {
            return this.events[param1];
        }// end function

        public function dispatch(param1:String, param2:NotifyData, param3:Boolean = false) : void
        {
            var _loc_4:Function = null;
            for each (_loc_4 in this.events[param1])
            {
                
                this._loc_4(param2);
            }
            trace("dispach:", param1, param2);
            return;
        }// end function

        public function get commands() : Array
        {
            return [];
        }// end function

        public function update(param1:NotifyData) : void
        {
            return;
        }// end function

        public function enterFrame() : void
        {
            return;
        }// end function

        public function resize(param1:int, param2:int) : void
        {
            return;
        }// end function

    }
}
