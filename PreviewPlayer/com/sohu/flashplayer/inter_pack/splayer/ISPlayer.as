package com.sohu.flashplayer.inter_pack.splayer
{
    import flash.net.*;

    public interface ISPlayer
    {

        public function ISPlayer();

        function play(param1:NetStream, param2:Number, param3:int, param4:Boolean = false) : void;

        function seek(param1:NetStream, param2:Number, param3:int, param4:Boolean = false) : void;

        function pause() : void;

        function resume() : void;

        function init() : void;

        function getPlayIndex() : int;

    }
}
