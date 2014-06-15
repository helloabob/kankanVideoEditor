package easy.scr.sys.stg.viw
{
    import flash.display.*;
    import vsin.dcw.support.*;

    public class ScreenMgr extends Object
    {
        private var container:Sprite;
        private var scrA:Screen;
        private var scrB:Screen;
        private var curScr:Screen;
        private var backScr:Screen;

        public function ScreenMgr(param1:Sprite, param2:Screen, param3:Screen)
        {
            this.scrA = param2;
            this.scrB = param3;
            this.container = param1;
            return;
        }// end function

        public function getCurScr() : Screen
        {
            this.recogAB();
            return this.curScr;
        }// end function

        public function getBackScr() : Screen
        {
            this.recogAB();
            return this.backScr;
        }// end function

        public function swap() : void
        {
            Trace.err("Screen SWAPING...");
            this.container.swapChildren(this.scrA, this.scrB);
            return;
        }// end function

        private function recogAB() : void
        {
            if (this.container.getChildIndex(this.scrA) > this.container.getChildIndex(this.scrB))
            {
                Trace.log("[cur:A][back:B]");
                this.curScr = this.scrA;
                this.backScr = this.scrB;
            }
            else
            {
                Trace.log("[cur:B][back:A]");
                this.curScr = this.scrB;
                this.backScr = this.scrA;
            }
            return;
        }// end function

    }
}
