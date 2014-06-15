package com.sohu.fwork.notify
{
    import com.sohu.fwork.*;
    import com.sohu.fwork.baseagent.*;
    import com.sohu.fwork.command.*;
    import com.sohu.fwork.view.*;
    import flash.utils.*;

    public class Notify extends Object implements INotify
    {
        protected var commands:Dictionary;
        protected var proxys:Dictionary;
        protected var views:Dictionary;

        public function Notify()
        {
            this.commands = Memroy.getInstents().commands;
            this.proxys = Memroy.getInstents().proxys;
            this.views = Memroy.getInstents().views;
            return;
        }// end function

        public function sendNotify(param1:String, param2:NotifyData) : void
        {
            var _loc_3:IView = null;
            if (this.commands[param1])
            {
                (this.commands[param1] as ICommand).trafficHandling(param2 ? (param2.clone()) : (null));
            }
            for each (_loc_3 in this.views)
            {
                
                if (_loc_3.com.sohu.fwork.view:IView::commands.indexOf(param1) != -1)
                {
                    _loc_3.update(param2 ? (param2.clone()) : (null));
                }
            }
            JSUtil.trace(param1, param2);
            trace(param1, param2);
            return;
        }// end function

    }
}
