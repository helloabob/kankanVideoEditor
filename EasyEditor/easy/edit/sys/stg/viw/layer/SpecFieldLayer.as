package easy.edit.sys.stg.viw.layer
{
    import flash.display.*;
    import vsin.dcw.support.*;

    public class SpecFieldLayer extends Sprite
    {
        private var dur:Number;
        private var skin:SpecLayerSkin;
        private var bg:Sprite;
        private var pt:KeyPointSkin;
        private var fieldSprites:Array;

        public function SpecFieldLayer()
        {
            this.fieldSprites = [];
            this.skin = new SpecLayerSkin();
            this.bg = this.skin.bg;
            addChild(this.skin);
            return;
        }// end function

        public function init(param1:Number, param2:Number) : void
        {
            this.dur = param2;
            width = param1;
            return;
        }// end function

        public function render(param1:Object) : void
        {
            var _loc_4:int = 0;
            var _loc_8:Sprite = null;
            var _loc_2:* = param1.time;
            var _loc_3:* = param1.hotflag;
            Trace.log("spots", _loc_3.length);
            var _loc_5:Number = -1;
            var _loc_6:Number = -1;
            var _loc_7:int = 0;
            while (_loc_7 < _loc_3.length)
            {
                
                _loc_4 = _loc_3[_loc_7];
                if (_loc_4 == 1)
                {
                    if (_loc_5 == -1)
                    {
                        _loc_5 = _loc_2[_loc_7];
                    }
                }
                else if (_loc_4 == -1)
                {
                    if (_loc_5 != -1 && _loc_6 == -1)
                    {
                        _loc_6 = _loc_2[(_loc_7 - 1)];
                        if (_loc_5 != _loc_6)
                        {
                            this.fieldSprites.push(this.buildFieldSprite(_loc_5, _loc_6));
                            _loc_5 = -1;
                            _loc_6 = -1;
                        }
                    }
                }
                _loc_7++;
            }
            if (_loc_5 != -1)
            {
                _loc_6 = _loc_2[(_loc_2.length - 1)];
                this.fieldSprites.push(this.buildFieldSprite(_loc_5, _loc_6));
                _loc_5 = -1;
                _loc_6 = -1;
            }
            for each (_loc_8 in this.fieldSprites)
            {
                
                this.skin.addChild(_loc_8);
            }
            return;
        }// end function

        private function buildFieldSprite(param1:Number, param2:Number) : Sprite
        {
            var _loc_3:* = param2 - param1;
            var _loc_4:* = param1 / this.dur * width / scaleX;
            var _loc_5:* = _loc_3 / this.dur * width;
            var _loc_6:* = new Sprite();
            new Sprite().graphics.beginFill(16345195, 1);
            _loc_6.graphics.drawRect(0, 0, _loc_5 / scaleX, 7);
            _loc_6.graphics.endFill();
            _loc_6.x = _loc_4;
            Trace.log("hot field", _loc_6.x + " / " + _loc_6.width);
            return _loc_6;
        }// end function

    }
}
