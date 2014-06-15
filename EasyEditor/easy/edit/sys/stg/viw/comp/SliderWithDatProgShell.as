package easy.edit.sys.stg.viw.comp
{
    import flash.display.*;
    import flash.geom.*;
    import vsin.dcw.support.comp.slide.*;

    public class SliderWithDatProgShell extends SliderShell
    {
        public var datProg:MovieClip;

        public function SliderWithDatProgShell(param1:MovieClip, param2:MovieClip, param3:MovieClip, param4:MovieClip)
        {
            this.datProg = param4;
            super(param1, param2, param3);
            return;
        }// end function

        public function setDatProg(param1:Number) : void
        {
            param1 = param1 > 1 ? (1) : (param1);
            param1 = param1 < 0 ? (0) : (param1);
            this.datProg.scrollRect = new Rectangle(0, 0, skinTrack.width * param1 / skinTrack.scaleX, skinTrack.height);
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            this.datProg.width = param1;
            super.width = param1;
            return;
        }// end function

    }
}
