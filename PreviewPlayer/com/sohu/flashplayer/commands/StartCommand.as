package com.sohu.flashplayer.commands
{
    import com.sohu.flashplayer.*;
    import com.sohu.flashplayer.proxys.*;
    import com.sohu.flashplayer.views.*;
    import com.sohu.fwork.*;
    import com.sohu.fwork.baseagent.*;
    import com.sohu.fwork.notify.*;
	import com.sohu.fwork.command.ICommand;

    public class StartCommand extends Notify implements ICommand
    {
        public static const NOTIFY:String = "PlayerStartCommand";

        public function StartCommand()
        {
            return;
        }// end function

        public function trafficHandling(param1:NotifyData) : void
        {
            FWork.controller.regestProxy(GetURLProxy.NAME, new GetURLProxy());
            FWork.controller.regestProxy(GetHotVRSProxy.NAME, new GetHotVRSProxy());
            FWork.controller.regestProxy(GetEntryProxy.NAME, new GetEntryProxy());
			//2
            FWork.controller.regestProxy(GetResProxy.NAME, new GetResProxy());
            FWork.controller.regestView(SPlayer.NAME, new SPlayer());
            FWork.controller.regestView(SProgressBar.NAME, new SProgressBar());
            FWork.controller.regestView(ErrorPanel.NAME, new ErrorPanel());
			//5  try to skip
            FWork.controller.regestCommand(GetHotVrsCommand.NOTIFY, new GetHotVrsCommand());
			//1.1
            FWork.controller.regestCommand(GetResCommand.GET_RES_REQ, new GetResCommand());
			//6.1
            FWork.controller.regestCommand(GetHotVrsCommand.GET_VRS_RESULT, new VideoCommand());
			//3
            FWork.controller.regestCommand(GetResCommand.GET_RES_RESULT, new ProgressCommand());
            FWork.controller.regestCommand(ErrorPanelCommand.TOTIP, new ErrorPanelCommand());
            //6.2
			FWork.controller.regestCommand(SeekCommand.SEEK_COMMAND, new SeekCommand());
			//4
            FWork.controller.regestCommand(AutoSeekCommand.AUTO_START, new AutoSeekCommand());
            //1.2
			FWork.controller.regestCommand(HelperCommand.HELPER_RUN, new HelperCommand());
            var _loc_2:* = new NotifyData();
            _loc_2.data = {url:Configer.RES_PATH};
			JSUtil.log("url:"+Configer.RES_PATH);
            FWork.notify.sendNotify(GetResCommand.GET_RES_REQ, _loc_2);
            FWork.notify.sendNotify(HelperCommand.HELPER_RUN, null);
            return;
        }// end function

    }
}
