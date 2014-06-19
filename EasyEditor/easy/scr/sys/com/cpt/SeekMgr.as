package easy.scr.sys.com.cpt
{
    import easy.scr.pro.*;
    import easy.scr.sys.com.dat.*;
    import vsin.dcw.support.*;

    public class SeekMgr extends Object
    {
        private var clipsLoadedProgress:Array;
        private var clipsLoadedCompletedMark:Array;
        private var dat:PlayDat;
        private var lastSeekToTime:Number;

        public function SeekMgr()
        {
            return;
        }// end function

        public function init() : void
        {
            var _loc_1:int = 0;
            if (!this.dat)
            {
                this.dat = ScrFactory.to.getCompIns(PlayDat);
                this.clipsLoadedProgress = [];
                this.clipsLoadedCompletedMark = [];
                _loc_1 = 0;
                while (_loc_1 < this.dat.clipUrls.length)
                {
                    
                    var _loc_2:int = 0;
                    this.clipsLoadedCompletedMark[_loc_1] = 0;
                    this.clipsLoadedProgress[_loc_1] = _loc_2;
                    this.dat.clipSeekMark[_loc_1] = _loc_2;
                    _loc_1++;
                }
            }
            return;
        }// end function

        public function clipDownloadReport(param1:int, param2:Number) : void
        {
            this.clipsLoadedProgress[param1] = param2 / this.dat.clipByteArr[param1];
            if (this.clipsLoadedProgress[param1] > 0.9)
            {
                this.clipsLoadedCompletedMark[param1] = 1;
            }
            return;
        }// end function

        public function checkClipIdLoadedComplete(param1:int) : Boolean
        {
            Trace.log("clipId completed " + param1, this.clipsLoadedCompletedMark.join(" | "));
            Trace.log("clipId seek mark " + param1, this.dat.clipSeekMark.join(" | "));
            return this.clipsLoadedCompletedMark[param1];
        }// end function

        public function checkSeekPtDataExist(param1:int, param2:Number, param3:Number) : Boolean
        {
            var _loc_4:* = this.checkClipIdLoadedComplete(param1);
            Trace.log("isClipTotallyLoaded", _loc_4);
            if (this.dat.clipSeekMark[param1])
            {
                Trace.log("isClipSeekMarded", param1);
                return false;
            }
            if (_loc_4)
            {
                return true;
            }
            var _loc_5:* = param3 >= this.lastSeekToTime && param3 < this.dat.calcEntireFlyTime();
            this.lastSeekToTime = param3;
            Trace.log("isBetweenLastSeekAndNow", _loc_5);
            if (_loc_5)
            {
                return true;
            }
            return false;
        }// end function

    }
}
