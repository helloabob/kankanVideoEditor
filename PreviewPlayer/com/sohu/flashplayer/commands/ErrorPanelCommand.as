package com.sohu.flashplayer.commands
{
    import com.sohu.flashplayer.inter_pack.errorpanel.*;
    import com.sohu.flashplayer.views.*;
    import com.sohu.fwork.*;
    import com.sohu.fwork.baseagent.*;
    import com.sohu.fwork.notify.*;
	import com.sohu.fwork.command.ICommand;

    public class ErrorPanelCommand extends Notify implements ICommand
    {
        private var iToolTip:IErrorPanel;
        public static const TOTIP:String = "pup_tip";

        public function ErrorPanelCommand()
        {
            this.iToolTip = FWork.controller.getView(ErrorPanel.NAME) as IErrorPanel;
            return;
        }// end function

        public function trafficHandling(param1:NotifyData) : void
        {
            this.iToolTip.init();
            this.iToolTip.upToolTip(param1.data as String);
            return;
        }// end function

    }
}
