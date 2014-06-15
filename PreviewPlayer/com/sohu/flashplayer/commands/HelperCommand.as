package com.sohu.flashplayer.commands
{
    import com.sohu.flashplayer.*;
    import com.sohu.flashplayer.inter_pack.splayer.*;
    import com.sohu.flashplayer.util.*;
    import com.sohu.flashplayer.views.*;
    import com.sohu.fwork.*;
    import com.sohu.fwork.baseagent.*;
    import com.sohu.fwork.notify.*;
    import flash.external.*;

    public class HelperCommand extends Notify implements ICommand
    {
        public static const HELPER_RUN:String = "HELPER_RUN";

        public function HelperCommand()
        {
            return;
        }// end function

        public function trafficHandling(param1:NotifyData) : void
        {
            var agent:* = param1;
            try
            {
                ExternalInterface.addCallback("getEditOverData", this.getEditOverData);
                ExternalInterface.addCallback("pausePreview", this.pausePreview);
            }
            catch (e:Error)
            {
                JSUtil.trace(e.message);
            }
            return;
        }// end function

        private function getEditOverData() : String
        {
            var _loc_1:* = this.getCutTimes();
            return _loc_1;
        }// end function

        private function getCutTimes() : String
        {
            var _loc_1:String = null;
            var _loc_3:int = 0;
            var _loc_2:* = new Object();
            if (Configer.AUTO_SEEK)
            {
                _loc_3 = 0;
                while (_loc_3 < Memory.autoSeek.length)
                {
                    
                    _loc_2[_loc_3] = {start:Memory.autoSeek[_loc_3].start, end:Memory.autoSeek[_loc_3].end};
                    _loc_3++;
                }
            }
            _loc_1 = JSON.stringify(_loc_2);
            return _loc_1;
        }// end function

        private function pausePreview() : void
        {
            (FWork.controller.getView(SPlayer.NAME) as ISPlayer).pause();
            return;
        }// end function

    }
}
