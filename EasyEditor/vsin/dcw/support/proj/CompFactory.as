package vsin.dcw.support.proj
{
    import flash.utils.*;
    
    import vsin.dcw.support.*;

    public class CompFactory extends Object
    {
        public var tracingCreating:Boolean = false;
        private var _allComp:Dictionary;
        private var _aliasDic:Dictionary;
        private const COMP_BIRTH:int = -1;

        public function CompFactory()
        {
            this._allComp = new Dictionary();
            this._aliasDic = new Dictionary();
            return;
        }// end function

        public function getCompIns(param1:Class):*
        {
            var _loc_2:* = this._allComp[param1];
            if (_loc_2 === undefined)
            {
                throw new Error("class should be registed");
            }
            if (_loc_2 === this.COMP_BIRTH)
            {
                var _loc_3:* = new param1();
                _loc_2 = _loc_3;
                this._allComp[param1] = _loc_3;
            }
            return _loc_2;
        }// end function

        public function getCompInsByAlias(param1:Class, param2:String = ""):*
        {
            var _loc_3:Class = null;
            var _loc_4:Array = null;
            var _loc_5:Object = null;
            var _loc_6:Class = null;
            for (_loc_5 in this._aliasDic)
            {
                
                _loc_4 = this._aliasDic[_loc_5];
                for each (_loc_6 in _loc_4)
                {
                    
                    var _loc_11:* = _loc_6;
                    if (_loc_6 === param1 && (!param2 || _loc_11._loc_6["toString"]().indexOf(param2) > -1))
                    {
                        _loc_3 = _loc_5 as Class;
                        break;
                    }
                }
                if (_loc_3)
                {
                    break;
                }
            }
            if (!_loc_3)
            {
                throw new Error("alias not defined");
            }
            return this.getCompIns(_loc_3);
        }// end function

        public function registComp(param1:Class, param2:Array = null) : void
        {
            this._allComp[param1] = new param1();
            this._aliasDic[param1] = param2;
            return;
        }// end function

        public function unregistComp(param1:Class) : void
        {
            this._allComp[param1] = null;
            delete this._allComp[param1];
            this._aliasDic[param1] = null;
            delete this._aliasDic[param1];
            return;
        }// end function

        public function dispose() : void
        {
            this._allComp = null;
            this._aliasDic = null;
            return;
        }// end function

    }
}
