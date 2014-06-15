package easy.scr.sys.com.dat.def
{

    final public class NetStats extends Object
    {
        public static const NetStream_Play_Start:String = "NetStream.Play.Start";
        public static const NetStream_Play_Stop:String = "NetStream.Play.Stop";
        public static const NetStream_SeekStart_Notify:String = "NetStream.SeekStart.Notify";
        public static const NetStream_Seek_Notify:String = "NetStream.Seek.Notify";
        public static const NetStream_Seek_Complete:String = "NetStream.Seek.Complete";
        public static const NetStream_Buffer_Full:String = "NetStream.Buffer.Full";
        public static const NetStream_Buffer_Empty:String = "NetStream.Buffer.Empty";
        public static const NetStream_Publish_Start:String = "NetStream.Publish.Start";
        public static const NetStream_Pause_Notify:String = "NetStream.Pause.Notify";
        public static const NetStream_Unpause_Notify:String = "NetStream.Unpause.Notify";
        public static const NetStream_Publish_BadName:String = "NetStream.Publish.BadName";
        public static const NetStream_Buffer_Flush:String = "NetStream.Buffer.Flush";
        public static const NetStream_Play_StreamNotFound:String = "NetStream.Play.StreamNotFound";
        public static const NetConnection_Connect_Success:String = "NetConnection.Connect.Success";
        public static const NetConnection_Connect_Closed:String = "NetConnection.Connect.Closed";
        public static const NetConnection_Connect_Failed:String = "NetConnection.Connect.Failed";
        public static const NetConnection_Connect_Rejected:String = "NetConnection.Connect.Rejected";

        public function NetStats()
        {
            return;
        }// end function

    }
}
