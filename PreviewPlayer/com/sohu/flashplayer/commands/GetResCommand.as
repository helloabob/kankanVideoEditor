package com.sohu.flashplayer.commands
{
    import com.sohu.flashplayer.inter_pack.getres.*;
    import com.sohu.flashplayer.proxys.*;
    import com.sohu.flashplayer.util.*;
    import com.sohu.fwork.*;
    import com.sohu.fwork.baseagent.*;
    import com.sohu.fwork.notify.*;
    import com.sohu.fwork.proxy.*;
    import flash.display.*;
	import com.sohu.fwork.command.ICommand;

    public class GetResCommand extends Notify implements ICommand
    {
        public static const GET_RES_REQ:String = "get_res_req";
        public static const GET_RES_RESULT:String = "get_res_result";

        public function GetResCommand()
        {
            return;
        }// end function

        public function trafficHandling(param1:NotifyData) : void
        {
			JSUtil.log("GetResCommand_trafficHandling");
            var _loc_2:* = param1.data["url"];
            var _loc_3:* = new GetResReq();
            _loc_3.url = _loc_2;
            (FWork.controller.getProxy(GetResProxy.NAME) as GetResProxy).getData(_loc_3, this.completeHandler);
            return;
        }// end function

        private function completeHandler(param1:ProxyResp) : void
        {
			JSUtil.log("GetResCommand_completeHandler");
            var _loc_2:* = new NotifyData();
            GlobelResUtil.setData(param1.data as MovieClip);
            this.sendNotify(GET_RES_RESULT, _loc_2);
            return;
        }// end function

    }
}
