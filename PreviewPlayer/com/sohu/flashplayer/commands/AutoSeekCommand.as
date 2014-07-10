package com.sohu.flashplayer.commands
{
    import com.sohu.flashplayer.*;
    import com.sohu.flashplayer.util.*;
    import com.sohu.flashplayer.util.Memory;
    import com.sohu.fwork.*;
    import com.sohu.fwork.baseagent.*;
    import com.sohu.fwork.command.ICommand;
    import com.sohu.fwork.notify.*;
    
    import flash.external.*;

    public class AutoSeekCommand extends Notify implements ICommand
    {
        private var test:Object;
        public static const AUTO_START:String = "AUTO_START";

        public function AutoSeekCommand()
        {
//            this.test = {0:{start:0, end:1759, total:1759}, 1:{start:1874.8, end:2026.72, total:151.921}, 2:{start:3551.44, end:3567.8, total:16.36}, 3:{start:3997.2, end:4098.68, total:101.48}};
//            this.test = [{start:67.64,end:79.6,total:11.959999999999994},{start:96.72,end:107.76,total:11.040000000000006},{start:126.08000000000001,end:131.56,total:5.47999999999999},{start:149.2,end:155.2,total:6},{start:179.48,end:203.08,total:23.600000000000023},{start:220.2,end:237.6,total:17.400000000000006},{start:254.84,end:266.96,total:12.119999999999976},{start:278.92,end:284.88,total:5.9599999999999795}];
//			mp4
//			this.test = [{start:15,end:19,total:4},{start:33,end:41,total:8}];
//			hls
			this.test = [{start:31.63,end:53.40,total:21.77},{start:80.14,end:119.85,total:39.71}];
			return;
        }// end function

        public function trafficHandling(param1:NotifyData) : void
        {
			JSUtil.log("AutoSeekCommand_trafficHandling");
            if (Configer.DEBUG)
            {
                this.startPreview();
                return;
            }
            try
            {
                ExternalInterface.addCallback("startPreview", this.startPreview);
//				flash.utils.setTimeout(startPreview,1000);
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        private function startPreview() : void
        {
			JSUtil.log("startPreview");
            var _loc_3:Array = null;
            var _loc_4:* = undefined;
            var _loc_5:NotifyData = null;
            Configer.AUTO_SEEK = false;
            var _loc_1:* = this.getEditData();
//			var _loc_1:*={0:{start:124.08,end:301.6,total:177.52},1:{start:429.64,end:590.2,total:160.56}};
//			for each(var a:* in _loc_1){
//				for(var b:* in a){
//					JSUtil.log("key:"+b+"  value:"+a[b]);
//				}
//			}
			JSUtil.log("json from JS:"+_loc_1);
            
            if (Configer.DEBUG)
            {
                _loc_1 = this.test;
				JSUtil.log("json from TEST:"+_loc_1);
            }
            if (_loc_1 != null)
            {
                Configer.AUTO_SEEK = true;
                _loc_3 = [];
                for (_loc_4 in _loc_1)
                {
                    JSUtil.log("TEST_detail:"+_loc_4+":::"+_loc_1[_loc_4]);
                    _loc_3[_loc_4] = _loc_1[_loc_4];
                }
                Memory.autoSeek = _loc_3;
            }
            else
            {
				JSUtil.log("无Edit数据");
                _loc_5 = new NotifyData();
                _loc_5.data = "无Edit数据";
                this.sendNotify(ErrorPanelCommand.TOTIP, _loc_5);
            }
			var _loc_2:* = new NotifyData();
			_loc_2.data = {vid:Configer.vid};
            FWork.notify.sendNotify(GetHotVrsCommand.NOTIFY, _loc_2);
            return;
        }// end function

        private function getEditData() : Object
        {
            var edit:String;
            try
            {
                edit = ExternalInterface.call("getEditDat");
            }
            catch (e:Error)
            {
                return null;
            }
			JSUtil.log("AutoSeekCommand_getEditData:"+edit);
            var result:* = this.sealJsonData(edit);
            return result;
        }// end function

        private function sealJsonData(param1:String) : Object
        {
            var _loc_2:Object = null;
            try
            {
                _loc_2 = JSON.parse(param1);
            }
            catch (e:Error)
            {
            }
            return _loc_2;
        }// end function

    }
}
