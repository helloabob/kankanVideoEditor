package com.sohu.flashplayer.inter_pack.splayer
{

    public interface IProgress
    {

        function init() : void;

        function updatePlayProgress(param1:Number) : void;

        function updateDownLoadProgress(param1:Number) : void;

        function updateSeekStatus(param1:Boolean = false) : void;

        function updateTime(param1:int, param2:int) : void;

        function updatePlayBtnStatus() : void;

        function resize_ex(param1:Number, param2:Number) : void;

        function updatePlayBtnComplete() : void;

        function updatePlayBtnStart() : void;

    }
}
