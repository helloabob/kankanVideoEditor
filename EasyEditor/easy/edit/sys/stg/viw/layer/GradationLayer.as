package easy.edit.sys.stg.viw.layer
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.text.*;
    import vsin.dcw.support.*;

    public class GradationLayer extends Sprite
    {
        private var dur:Number;
        private var w:Number;
        private var h:Number = 27;

        public function GradationLayer()
        {
            return;
        }// end function

        public function init(param1:Number, param2:Number) : void
        {
            this.w = param1;
            this.dur = param2;
            return;
        }// end function

        public function render() : void
        {
            var _loc_9:Number = NaN;
            var _loc_1:Number = 3;
            var _loc_2:Number = 15;
            var _loc_3:int = 5;
            var _loc_4:* = _loc_2;
            this.clear();
            var _loc_5:* = width / _loc_4;
            var _loc_6:* = this.dur / _loc_5;
            var _loc_7:* = Math.ceil(this.dur / (_loc_6 * _loc_3));
            var _loc_8:* = width / this.dur;
            graphics.lineStyle(1, 0, 1);
            var _loc_10:int = 0;
            while (_loc_10 <= _loc_7)
            {
                
                _loc_9 = _loc_6 * _loc_3 * _loc_10;
                this.drawGrad(_loc_9, _loc_9 * _loc_8, _loc_4, _loc_10 === 0);
                _loc_10++;
            }
            return;
        }// end function

        private function drawGrad(param1:Number, param2:Number, param3:Number, param4:Boolean = false) : void
        {
            var _loc_5:Number = 5;
            var _loc_6:Number = 10;
            var _loc_7:* = height - 1;
            var _loc_8:* = new Vector.<int>().push(GraphicsPathCommand.MOVE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.MOVE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.MOVE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.MOVE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.MOVE_TO, GraphicsPathCommand.LINE_TO);
            var _loc_9:* = new Vector.<Number>().push(param2 + 0 * param3, _loc_7, param2 + 0 * param3, _loc_7 - _loc_6, param2 + 1 * param3, _loc_7, param2 + 1 * param3, _loc_7 - _loc_5, param2 + 2 * param3, _loc_7, param2 + 2 * param3, _loc_7 - _loc_5, param2 + 3 * param3, _loc_7, param2 + 3 * param3, _loc_7 - _loc_5, param2 + 4 * param3, _loc_7, param2 + 4 * param3, _loc_7 - _loc_5);
            graphics.drawPath(_loc_8, _loc_9);
            var _loc_10:* = new TextField();
            var _loc_11:* = new TextFormat();
            new TextFormat().font = "Tahoma";
            _loc_11.size = 10;
            _loc_10.defaultTextFormat = _loc_11;
            _loc_10.setTextFormat(_loc_11);
            _loc_10.height = 15;
            _loc_10.selectable = false;
            _loc_10.multiline = false;
            _loc_10.text = param1 === 0 ? ("0") : (Tools.formatTime(param1));
            if (param4)
            {
                _loc_10.x = param2;
            }
            else
            {
                _loc_10.x = param2 - _loc_10.textWidth / 2;
            }
            addChild(_loc_10);
            return;
        }// end function

        private function clear() : void
        {
            graphics.clear();
            while (numChildren)
            {
                
                removeChildAt(0);
            }
            var _loc_1:* = new Sprite();
            _loc_1.graphics.lineStyle(1, 0, 0);
            _loc_1.graphics.moveTo(0, 0);
            _loc_1.graphics.lineTo((this.w - 1), (this.h - 1));
            addChild(_loc_1);
            return;
        }// end function

    }
}
