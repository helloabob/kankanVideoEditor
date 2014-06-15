package vsin.dcw.support.proj
{
    import flash.display.*;

    final public class LayerMgr extends Object
    {
        private static var reservedLayer:Sprite;
        private static var relativeLayer:Sprite;
        public static var tipLayer:Sprite;
        public static var topLayer:Sprite;
        public static var midLayer:Sprite;
        public static var botLayer:Sprite;

        public function LayerMgr()
        {
            return;
        }// end function

        public static function buildLayer(param1:DisplayObject) : void
        {
            var _loc_2:* = param1 as Sprite;
            var _loc_3:* = param1.stage;
            reservedLayer = new Sprite();
            relativeLayer = new Sprite();
            _loc_2.addChild(relativeLayer);
            _loc_2.addChild(reservedLayer);
            tipLayer = new Sprite();
            topLayer = new Sprite();
            midLayer = new Sprite();
            botLayer = new Sprite();
            reservedLayer.addChild(tipLayer);
            relativeLayer.addChild(botLayer);
            relativeLayer.addChild(midLayer);
            relativeLayer.addChild(topLayer);
            return;
        }// end function

    }
}
