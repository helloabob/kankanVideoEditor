﻿package easy.edit.sys.stg.dat
{

    public class EditUIData extends Object
    {
        public var clipDurArr:Array;
        public var keyFrDat:Array;
        public var stgWidth:Number;
        public var stgHeight:Number;
        private var dur:Number;
        private var viewProgDur:Number;
        private var viewStartProg:Number;
        private var viewDuration:Number;
        private var viewWidth:Number;
        private var viewStartTime:Number;
        private const KEYFR_OFFSET_AVOID:int = 5;

        public function EditUIData()
        {
            return;
        }// end function

        public function updateView(param1:Number, param2:Number, param3:Number, param4:Number) : void
        {
            this.dur = param1;
            this.viewStartTime = param4;
            this.viewWidth = param3;
            this.viewDuration = param2;
            this.viewProgDur = param2 / this.dur;
            this.viewStartProg = param4 / this.dur;
            return;
        }// end function

        public function getTotTimeByViewProg(param1:Number) : Number
        {
            return this.viewStartTime + this.viewDuration * param1;
        }// end function

        public function getTotProgByViewProg(param1:Number) : Number
        {
            return this.viewStartProg + param1;
        }// end function

        public function getTotTimeByClipTime(param1:int, param2:Number) : Number
        {
            var _loc_3:Number = 0;
            var _loc_4:int = 0;
            while (_loc_4 < param1)
            {
                
                _loc_3 = _loc_3 + this.clipDurArr[_loc_4];
                _loc_4++;
            }
            return _loc_3 + param2;
        }// end function

        public function getTotProgByClipTime(param1:int, param2:Number) : Number
        {
            return this.getTotTimeByClipTime(param1, param2) / this.dur;
        }// end function

        public function transSecToViewProg(param1:Number) : Number
        {
            return param1 / this.viewDuration;
        }// end function

        public function transTotProgToClipIdAndClipFlyTime(param1:Number) : Array
        {
            var _loc_2:* = param1 * this.dur;
            var _loc_3:Number = 0;
            var _loc_4:int = 0;
            var _loc_5:Number = 0;
            var _loc_6:int = 0;
            while (_loc_6 < this.clipDurArr.length)
            {
                
                if (_loc_3 < _loc_2)
                {
                    _loc_4 = _loc_6;
                    _loc_5 = _loc_2 - _loc_3;
                }
                else
                {
                    break;
                }
                _loc_3 = _loc_3 + this.clipDurArr[_loc_6];
                _loc_6++;
            }
            return [_loc_4, _loc_5, _loc_2];
        }// end function

        public function findNextSp(param1:int, param2:Number) : Number
        {
            var _loc_3:* = this.keyFrDat[param1];
            if (!_loc_3)
            {
                return param2;
            }
            var _loc_4:Number = 0;
            var _loc_5:* = _loc_3.length;
            var _loc_6:int = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_4 = _loc_3[_loc_6];
                if (_loc_4 > param2 && Math.abs(_loc_4 - param2) > this.KEYFR_OFFSET_AVOID)
                {
                    break;
                }
                _loc_6++;
            }
            if (Math.abs(param2 - _loc_4) < 1)
            {
                return _loc_4 + this.findNextSp((param1 + 1), 0);
            }
            return _loc_4;
        }// end function

        public function findPrevSp(param1:int, param2:Number) : Number
        {
            var _loc_3:* = this.keyFrDat[param1];
            var _loc_4:Number = 0;
            var _loc_5:* = _loc_3.length;
            var _loc_6:* = _loc_3.length - 1;
            while (_loc_6 >= 0)
            {
                
                _loc_4 = _loc_3[_loc_6];
                if (_loc_4 < param2 && Math.abs(_loc_4 - param2) > this.KEYFR_OFFSET_AVOID)
                {
                    break;
                }
                _loc_6 = _loc_6 - 1;
            }
            return _loc_4;
        }// end function

        public function findClosestSp(param1:int, param2:Number) : Number
        {
            var _loc_7:int = 0;
            var _loc_8:Number = NaN;
            var _loc_9:Number = NaN;
            var _loc_10:Number = NaN;
            var _loc_3:* = this.keyFrDat[param1];
            var _loc_4:Number = 0;
            var _loc_5:* = _loc_3.length;
            var _loc_6:* = _loc_3.length - 1;
            while (_loc_6 >= 0)
            {
                
                _loc_4 = _loc_3[_loc_6];
                if (param2 >= _loc_4)
                {
                    _loc_7 = (_loc_6 + 1) === _loc_5 ? (_loc_6) : ((_loc_6 + 1));
                    _loc_8 = _loc_3[_loc_7];
                    _loc_9 = param2 - _loc_4;
                    _loc_10 = _loc_8 - param2;
                    if (_loc_10 < _loc_9)
                    {
                        _loc_4 = _loc_8;
                    }
                    break;
                }
                _loc_6 = _loc_6 - 1;
            }
            return _loc_4;
        }// end function

    }
}
