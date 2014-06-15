package com.sohu.fwork.controller
{
    import com.sohu.fwork.command.*;
    import com.sohu.fwork.proxy.*;
    import com.sohu.fwork.view.*;
    import flash.display.*;

    public interface IController
    {

        public function IController();

        function regestCommand(param1:String, param2:ICommand) : void;

        function removeCommand(param1:String, param2:ICommand) : void;

        function hasCommand(param1:String) : Boolean;

        function regestProxy(param1:String, param2:IProxy) : void;

        function removeProxy(param1:String, param2:IProxy) : void;

        function hasProxy(param1:String) : Boolean;

        function getProxy(param1:String) : IProxy;

        function regestView(param1:String, param2:IView) : void;

        function removeView(param1:String, param2:IView) : void;

        function hasView(param1:String) : Boolean;

        function getView(param1:String) : View;

        function setRoot(param1:Sprite) : void;

        function resize(param1:int, param2:int) : void;

    }
}
