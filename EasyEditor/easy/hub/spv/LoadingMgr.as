package easy.hub.spv
{
    import com.greensock.*;
    import flash.display.*;
    import vsin.dcw.support.*;
    import vsin.dcw.support.proj.*;

    public class LoadingMgr extends Sprite
    {
        private var skin:FoxLoading;
        private var openRec:Array;
        public static const OPEN:String = "OPEN";
        public static const BUF:String = "BUF";
        public static const SHORT_LOAD_SEEK:String = "SHORT_LOAD_SEEK";
        public static const FULL_LOAD_SEEK:String = "FULL_LOAD_SEEK";
        private static var ins:LoadingMgr;

        public function LoadingMgr(param1:Singleton)
        {
            this.openRec = [];
            alpha = 0;
            this.skin = new FoxLoading();
            addChild(this.skin);
            LayerMgr.topLayer.addChild(this);
            return;
        }// end function

        public function resize(param1:Number, param2:Number) : void
        {
            graphics.clear();
            graphics.beginFill(0, 0.4);
            graphics.drawRect(0, 0, param1, param2);
            graphics.endFill();
            this.skin.x = (param1 - this.skin.width) / 2;
            this.skin.y = (param2 - this.skin.height) / 2;
            return;
        }// end function

        public function show(param1:String) : void
        {
            Trace.log("LoadingShow", param1);
            if (this.openRec.indexOf(param1) === -1)
            {
                this.openRec.push(param1);
            }
            visible = true;
            TweenLite.to(this, 0.3, {alpha:1});
            return;
        }// end function

        public function hide(param1:String) : void
        {
            Trace.log("LoadingHide", param1);
            var _loc_2:* = this.openRec.indexOf(param1);
            if (_loc_2 > -1)
            {
                this.openRec.splice(_loc_2, 1);
            }
            if (!this.openRec.length)
            {
                TweenLite.to(this, 0.3, {alpha:0, onComplete:this.onDone});
            }
            return;
        }// end function

        public function forceHide() : void
        {
            this.openRec.length = 0;
            this.hide("^o^");
            return;
        }// end function

        private function onDone() : void
        {
            visible = false;
            return;
        }// end function

        public static function getIns() : LoadingMgr
        {
            var _loc_1:* = ins || new LoadingMgr(new Singleton());
            ins = ins || new LoadingMgr(new Singleton());
            return _loc_1;
        }// end function

    }
}

final class Singleton extends Object
{

    function Singleton()
    {
        return;
    }// end function

}

