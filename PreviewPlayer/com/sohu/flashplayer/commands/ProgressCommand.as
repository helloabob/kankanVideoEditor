package com.sohu.flashplayer.commands
{
    import com.sohu.flashplayer.inter_pack.splayer.*;
    import com.sohu.flashplayer.views.*;
    import com.sohu.fwork.*;
    import com.sohu.fwork.baseagent.*;
    import com.sohu.fwork.notify.*;
    import com.sohu.fwork.view.*;
	import com.sohu.fwork.command.ICommand;

    public class ProgressCommand extends Notify implements ICommand
    {
        private var iProgress:IProgress;
        private var iView:IView;

        public function ProgressCommand()
        {
            this.iProgress = FWork.controller.getView(SProgressBar.NAME) as IProgress;
            this.iView = FWork.controller.getView(SProgressBar.NAME) as IView;
            return;
        }// end function

        public function trafficHandling(param1:NotifyData) : void
        {
			JSUtil.log("ProgressCommand_trafficHandling");
            this.iProgress.init();
            FWork.notify.sendNotify(AutoSeekCommand.AUTO_START, null);
            return;
        }// end function

    }
}
