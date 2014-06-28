package easy.edit.sys.mdt
{
    import easy.edit.pro.*;
    import easy.edit.sys.com.cmd.*;
    import easy.edit.sys.com.cmd.mdtcmd.*;
    import easy.edit.sys.com.dat.*;
    import easy.edit.sys.stg.viw.*;
    import easy.hub.evt.*;
    import flash.display.*;

    public class EditBoot extends Object
    {
        private var stg:Stage;
        private var root:DisplayObject;

        public function EditBoot(param1:Object, param2:Stage, param3:DisplayObject)
        {
            this.stg = param2;
            this.root = param3;
            EditDispatcher.to.tracingEvt = true;
            EditFactory.to.tracingCreating = true;
            EditFactory.to.registComp(EditTeller);
            EditFactory.to.registComp(EditDat);
            EditDispatcher.to.addCmd(EditMdtEvt, EditMdtEvt.UPDATE_EDIT_DAT, UpdateEditDatCmd);
            EditDispatcher.to.addCmd(KeyFrEvt, KeyFrEvt.KEY_FRAME_LOADED, KeyFrLoadedCmd);
            var _loc_4:* = EditFactory.to.getCompIns(EditDat);
            EditFactory.to.getCompIns(EditDat).vid = param1.vid;
            var _loc_5:* = new ProgTest();
            var _loc_6:EditField = new EditField();
            (param3 as Sprite).addChild(_loc_5);
            (param3 as Sprite).addChild(_loc_6);
            _loc_5.x = -7;
            _loc_5.y = 170;
            var _loc_7:* = new WorkFieldMediator(param3 as Sprite, _loc_5, _loc_6);
            _loc_5.init();
            _loc_6.init();
			trace("EditField_did_loaded");
            _loc_5.visible = false;
            new EditFieldJsApi(_loc_6);
            return;
        }// end function

    }
}
