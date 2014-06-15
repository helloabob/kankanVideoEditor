package easy.edit.sys.stg.viw.comp
{
    import flash.display.*;
    import vsin.dcw.support.comp.btn.*;

    public class TextButtonShell extends ButtonShell
    {

        public function TextButtonShell(param1:MovieClip)
        {
            super(param1);
            return;
        }// end function

        public function setTitle(param1:String) : void
        {
            skin.title.text = param1;
            return;
        }// end function

    }
}
