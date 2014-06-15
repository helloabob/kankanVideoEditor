package easy.edit.sys.mdt
{
    import easy.edit.pro.*;
    import easy.edit.sys.com.dat.*;
    import easy.edit.sys.stg.evt.*;
    import easy.edit.sys.stg.viw.*;
    import flash.external.*;
    import vsin.dcw.support.*;

    public class EditFieldJsApi extends Object
    {
        private var edit:EditField;
        private var dat:EditDat;
        private var callJsReadyPath:String = "window.flashEditor.onLoad";

        public function EditFieldJsApi(param1:EditField)
        {
            this.edit = param1;
            this.dat = EditFactory.to.getCompIns(EditDat);
            ExternalInterface.addCallback("undo", this.undo);
            ExternalInterface.addCallback("moveToLeftKeyFr", this.moveToLeftKeyFr);
            ExternalInterface.addCallback("moveToRightKeyFr", this.moveToRightKeyFr);
            ExternalInterface.addCallback("setStartPoint", this.setStartPoint);
            ExternalInterface.addCallback("setEndPoint", this.setEndPoint);
            ExternalInterface.addCallback("togglePlay", this.togglePlay);
            ExternalInterface.addCallback("getEditDat", this.getEditDat);
            ExternalInterface.addCallback("setEditDat", this.setEditDat);
            ExternalInterface.call(this.callJsReadyPath);
            return;
        }// end function

        public function undo() : void
        {
            Trace.log("JS KEY undo");
            this.edit.undo();
            return;
        }// end function

        public function moveToLeftKeyFr() : void
        {
            Trace.log("JS KEY moveToLeftKeyFr");
            this.edit.moveToLeftKeyFr();
            return;
        }// end function

        public function moveToRightKeyFr() : void
        {
            Trace.log("JS KEY moveToRightKeyFr");
            this.edit.moveToRightKeyFr();
            return;
        }// end function

        public function setStartPoint() : void
        {
            Trace.log("JS KEY setStartPoint");
            this.edit.setStartPoint();
            return;
        }// end function

        public function setEndPoint() : void
        {
            Trace.log("JS KEY setEndPoint");
            this.edit.setEndPoint();
            return;
        }// end function

        public function togglePlay() : void
        {
            Trace.log("FROM JS togglePlay");
            this.edit.togglePlay();
            return;
        }// end function

        public function setEditDat(param1:String) : void
        {
            Trace.log("FROM JS setEditDat");
            this.edit.setEditDat(param1);
            return;
        }// end function

        public function getEditDat() : String
        {
            var result:String;
            var cloneDat:Array;
            var i:int;
            Trace.log("FROM JS getEditDat");
            this.edit.dispatchEvent(new WorkFieldUIEvt(WorkFieldUIEvt.PAUSE));
            var editDat:Object;
            if (this.dat.editDat)
            {
                cloneDat = this.dat.editDat.concat();
                cloneDat.sort(function (param1:Object, param2:Object) : int
            {
                return param1.start - param2.start;
            }// end function
            );
                i;
                while (i < cloneDat.length)
                {
                    
                    editDat[i] = cloneDat[i];
                    i = (i + 1);
                }
                result = JSON.stringify(editDat);
                return result;
            }
            else
            {
                return null;
            }
        }// end function

    }
}
