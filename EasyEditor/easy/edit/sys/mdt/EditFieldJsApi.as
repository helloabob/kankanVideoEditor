package easy.edit.sys.mdt
{
    import flash.external.ExternalInterface;
    
    import easy.edit.pro.EditFactory;
    import easy.edit.sys.com.dat.EditDat;
    import easy.edit.sys.stg.evt.WorkFieldUIEvt;
    import easy.edit.sys.stg.viw.EditField;
    
    import vsin.dcw.support.Trace;

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
			ExternalInterface.addCallback("getSelectionInfo", this.getSelectionInfo);
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
            var i:int=0;
            Trace.log("FROM JS getEditDat");
            this.edit.dispatchEvent(new WorkFieldUIEvt(WorkFieldUIEvt.PAUSE));
            var editDat:Array=[];
            if (this.dat.editDat){
				Trace.log("concat_sort");
                cloneDat = this.dat.editDat.concat();
				Trace.log("aaa");
                cloneDat.sort(function (param1:Object, param2:Object):int{
                	return param1.start - param2.start;
            	});
				Trace.log("bbb");
				while (i < cloneDat.length){
					editDat[i] = cloneDat[i];
					i=i+1;
				}
				Trace.log(editDat.toString());
				result = JSON.stringify(editDat);
				Trace.log(result);
				return result;
            }
            else{
                return null;
            }
        }// end function

		private function getSelectionInfo():String{
			return this.edit.getSelectionInfo();
		}
		
    }
}
