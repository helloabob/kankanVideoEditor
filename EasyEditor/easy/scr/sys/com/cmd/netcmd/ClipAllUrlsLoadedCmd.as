package easy.scr.sys.com.cmd.netcmd
{
    import easy.scr.pro.*;
    import easy.scr.sys.com.cmd.*;
    import easy.scr.sys.com.dat.PlayDat;
    import easy.scr.sys.com.net.*;

    public class ClipAllUrlsLoadedCmd extends Object
    {

        public function ClipAllUrlsLoadedCmd(param1:ScreenNetEvt)
        {
			var dat:PlayDat = ScrFactory.to.getCompIns(PlayDat);
			if(dat.ishls)ScrDispatcher.to.dispatch(new ScreenNetEvt(ScreenNetEvt.CONNECTED));
			else{
            	var _loc_2:ConnectStm = ScrFactory.to.getCompIns(ConnectStm);
            	_loc_2.connectServer();
			}
            return;
        }// end function

    }
}
