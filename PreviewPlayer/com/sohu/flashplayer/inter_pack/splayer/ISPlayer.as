package com.sohu.flashplayer.inter_pack.splayer
{

    public interface ISPlayer
    {

        function play(param1:*, param2:Number, param3:int, param4:Boolean = false) : void;

        function seek(param1:*, param2:Number, param3:int, param4:Boolean = false) : void;

        function pause() : void;

        function resume() : void;

        function init() : void;

        function getPlayIndex() : int;

    }
}
