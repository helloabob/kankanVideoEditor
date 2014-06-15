package easy.edit.sys.com.cmd.mdtcmd
{
    import easy.edit.pro.*;
    import easy.edit.sys.com.cmd.*;
    import easy.edit.sys.com.dat.*;

    public class UpdateEditDatCmd extends Object
    {

        public function UpdateEditDatCmd(param1:EditMdtEvt)
        {
            var _loc_2:* = EditFactory.to.getCompIns(EditDat);
            _loc_2.editDat = param1.editDat;
            return;
        }// end function

    }
}
