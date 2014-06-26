package 
{
    import com.sohu.flashplayer.*;
    import com.sohu.flashplayer.commands.*;
    import com.sohu.flashplayer.inter_pack.loading.*;
    import com.sohu.flashplayer.views.*;
    import com.sohu.fwork.*;
    import com.sohu.fwork.baseagent.*;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.ui.*;

    public class PreviewPlayer extends Sprite
    {

        public function PreviewPlayer()
        {
            var _loc_1:* = new ContextMenu();
            _loc_1.customItems = [new ContextMenuItem("preview:1.0.1")];
            _loc_1.hideBuiltInItems();
            _loc_1.clipboardMenu = false;
            this.contextMenu = _loc_1;
            Security.allowDomain("*");
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            this.graphicsBackGround();
            stage.addEventListener(Event.RESIZE, this.resizeHandler);
            FWork.init(this);
            FWork.controller.regestCommand(StartCommand.NOTIFY, new StartCommand());
            var _loc_2:* = this.loaderInfo;
            if (_loc_2.parameters.hasOwnProperty("vid"))
            {
                Configer.vid = _loc_2.parameters.vid;
            }
            else
            {
                Configer.vid = "980887";
            }
//            var _loc_3:* = _loc_2.loaderURL.substring(0, (_loc_2.loaderURL.lastIndexOf("/") + 1)) + "res.swf";
			var _loc_3:* = "res.swf";
            Configer.RES_PATH = _loc_3;
            FWork.notify.sendNotify(StartCommand.NOTIFY, null);
            FWork.controller.regestView(LoadingView.NAME, new LoadingView());
            (FWork.controller.getView(LoadingView.NAME) as ILoading).show();
            FWork.controller.getView(SProgressBar.NAME).addListener(SProgressBar.SCREEN_CTRL_EVENT, this.secHandler);
			JSUtil.log("width:" + stage.stageWidth + " height:" + stage.stageHeight);
            return;
        }// end function

        private function secHandler(param1:NotifyData) : void
        {
            switch(param1.code)
            {
                case 1:
                {
                    if (this.stage.allowsFullScreen)
                    {
                        this.stage.displayState = StageDisplayState.FULL_SCREEN;
                    }
                    break;
                }
                case 0:
                {
                    this.stage.displayState = StageDisplayState.NORMAL;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function resizeHandler(event:Event) : void
        {
            JSUtil.log("width:" + stage.stageWidth + " height:" + stage.stageHeight);
            this.graphicsBackGround();
            FWork.controller.resize(stage.stageWidth, stage.stageHeight);
            return;
        }// end function

        private function graphicsBackGround() : void
        {
            this.graphics.clear();
            this.graphics.beginFill(16777215, 1);
            this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
            this.graphics.endFill();
            return;
        }// end function

    }
}
