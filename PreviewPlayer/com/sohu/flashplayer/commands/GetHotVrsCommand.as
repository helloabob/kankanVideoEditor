package com.sohu.flashplayer.commands
{
    import com.sohu.flashplayer.inter_pack.hotvrs.*;
    import com.sohu.flashplayer.inter_pack.loading.*;
    import com.sohu.flashplayer.proxys.*;
    import com.sohu.flashplayer.views.*;
    import com.sohu.fwork.*;
    import com.sohu.fwork.baseagent.*;
    import com.sohu.fwork.notify.*;

    public class GetHotVrsCommand extends Notify implements ICommand
    {
        private var hotVrsResp:HotVrsResp;
        public static const NOTIFY:String = "GetPlayUrlCommand";
        public static const GET_VRS_RESULT:String = "GetPlayUrlCommand_RESULT";

        public function GetHotVrsCommand()
        {
            return;
        }// end function

        public function trafficHandling(param1:NotifyData) : void
        {
            var _loc_2:* = param1.data.vid;
            if (!_loc_2)
            {
                return;
            }
            var _loc_3:* = new HotVrsReq();
            _loc_3.vid = _loc_2;
            (FWork.controller.getProxy(GetHotVRSProxy.NAME) as GetHotVRSProxy).getData(_loc_3, this.getHostVrsCallBack);
            return;
        }// end function

        private function getHostVrsCallBack(param1:NotifyData) : void
        {
            (FWork.controller.getView(LoadingView.NAME) as ILoading).high();
            this.hotVrsResp = param1 as HotVrsResp;
            var _loc_2:* = new NotifyData();
            _loc_2.data = this.hotVrsResp;
            this.sendNotify(GET_VRS_RESULT, _loc_2);
            this.sendNotify(SeekCommand.SEEK_COMMAND, _loc_2);
            return;
        }// end function

    }
}
