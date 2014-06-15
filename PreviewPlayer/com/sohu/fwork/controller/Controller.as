package com.sohu.fwork.controller
{
    import com.sohu.fwork.command.*;
    import com.sohu.fwork.notify.*;
    import com.sohu.fwork.proxy.*;
    import com.sohu.fwork.view.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class Controller extends Notify implements IController
    {
        private var rootMC:Sprite;
        private var timer:Timer;

        public function Controller()
        {
            this.timer = new Timer(50);
            return;
        }// end function

        public function setRoot(param1:Sprite) : void
        {
            this.rootMC = param1;
            this.timer.addEventListener(TimerEvent.TIMER, this.enterFrameHandler);
            this.timer.start();
            return;
        }// end function

        public function regestCommand(param1:String, param2:ICommand) : void
        {
            if (commands[param1] == null)
            {
                commands[param1] = param2;
            }
            return;
        }// end function

        public function removeCommand(param1:String, param2:ICommand) : void
        {
            if (commands[param1] != null)
            {
                param2 = null;
                delete commands[param1];
            }
            return;
        }// end function

        public function hasCommand(param1:String) : Boolean
        {
            return commands[param1];
        }// end function

        public function regestProxy(param1:String, param2:IProxy) : void
        {
            if (proxys[param1] == null)
            {
                proxys[param1] = param2;
            }
            return;
        }// end function

        public function removeProxy(param1:String, param2:IProxy) : void
        {
            if (proxys[param1] != null)
            {
                param2 = null;
                delete proxys[param1];
            }
            return;
        }// end function

        public function hasProxy(param1:String) : Boolean
        {
            return proxys[param1];
        }// end function

        public function getProxy(param1:String) : IProxy
        {
            return proxys[param1];
        }// end function

        public function getView(param1:String) : View
        {
            return views[param1];
        }// end function

        public function hasView(param1:String) : Boolean
        {
            return views[param1];
        }// end function

        public function regestView(param1:String, param2:IView) : void
        {
            if (views[param1] == null)
            {
                views[param1] = param2;
                this.rootMC.addChild(param2 as DisplayObject);
            }
            return;
        }// end function

        public function removeView(param1:String, param2:IView) : void
        {
            if (views[param1] != null)
            {
                views[param1] = null;
                delete views[param1];
            }
            return;
        }// end function

        private function enterFrameHandler(event:Event) : void
        {
            var _loc_2:IView = null;
            for each (_loc_2 in this.views)
            {
                
                if (_loc_2)
                {
                    _loc_2.enterFrame();
                }
            }
            return;
        }// end function

        public function resize(param1:int, param2:int) : void
        {
            var _loc_3:IView = null;
            for each (_loc_3 in this.views)
            {
                
                if (_loc_3)
                {
                    _loc_3.resize(param1, param2);
                }
            }
            return;
        }// end function

    }
}
