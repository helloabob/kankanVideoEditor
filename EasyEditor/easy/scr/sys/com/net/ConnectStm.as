package easy.scr.sys.com.net
{
    import easy.scr.pro.*;
    import easy.scr.sys.com.cmd.*;
    import easy.scr.sys.com.dat.*;
    import easy.scr.sys.com.dat.def.*;
    
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    
    import vsin.dcw.support.*;

    public class ConnectStm extends Object
    {
        protected var dat:PlayDat;
        protected var conn:NetConnection;
        protected var retry:RetryValidator;
        protected var tmOver:Timer;

        public function ConnectStm()
        {
            this.tmOver = new Timer(10000);
            this.dat = ScrFactory.to.getCompIns(PlayDat);
            this.retry = new RetryValidator(3, 1);
            this.tmOver.addEventListener(TimerEvent.TIMER, this.onTmOver);
            Trace.log("AMF0");
            NetConnection.defaultObjectEncoding = ObjectEncoding.AMF0;
            this.conn = new NetConnection();
            this.conn.objectEncoding = ObjectEncoding.AMF0;
            this.conn.addEventListener(NetStatusEvent.NET_STATUS, this.netStatusHandler);
            this.conn.addEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
            this.conn.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
            this.conn.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.asyncErrorHandler);
            this.conn.client = {onMetaData:this.onMetaData, onBWDone:this.onBWDone};
            this.dat.curConn = this.conn;
            return;
        }// end function

        public function connectServer() : void
        {
            if (!this.conn.connected)
            {
                this.tmOver.start();
                this.conn.connect(null);
            }
            else
            {
                Trace.err("already connected");
                ScrDispatcher.to.dispatch(new ScreenNetEvt(ScreenNetEvt.CONNECTED));
            }
            return;
        }// end function

        public function closeConnect() : void
        {
            try
            {
                this.conn.close();
            }
            catch (e:Error)
            {
                Trace.err("close conn", e.message);
            }
            return;
        }// end function

        protected function onTmOver(event:TimerEvent) : void
        {
            this.tmOver.stop();
            this.retry.canRetry(this.connectServer, this.onConnFail);
            return;
        }// end function

        protected function netStatusHandler(event:NetStatusEvent) : void
        {
            this.tmOver.stop();
            Trace.err(event.info.code);
            switch(event.info.code)
            {
                case NetStats.NetConnection_Connect_Success:
                {
                    ScrDispatcher.to.dispatch(new ScreenNetEvt(ScreenNetEvt.CONNECTED));
                    break;
                }
                case NetStats.NetConnection_Connect_Rejected:
                case NetStats.NetConnection_Connect_Closed:
                {
                    break;
                }
                case NetStats.NetConnection_Connect_Failed:
                {
                    this.retry.canRetry(this.connectServer, this.onConnFail);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function onConnFail() : void
        {
            this.onFatalErr();
            return;
        }// end function

        protected function onFatalErr() : void
        {
            return;
        }// end function

        protected function ioErrorHandler(event:IOErrorEvent) : void
        {
            Trace.err("Conn IOErrorEvent");
            return;
        }// end function

        protected function securityErrorHandler(event:SecurityErrorEvent) : void
        {
            Trace.err("Conn SecurityErrorEvent");
            return;
        }// end function

        protected function asyncErrorHandler(event:AsyncErrorEvent) : void
        {
            Trace.err("Conn AsyncErrorEvent");
            return;
        }// end function

        protected function onMetaData() : void
        {
            return;
        }// end function

        protected function onBWDone(... args) : void
        {
            return;
        }// end function

    }
}
