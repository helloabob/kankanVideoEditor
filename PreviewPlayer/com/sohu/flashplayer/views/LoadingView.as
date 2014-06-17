package com.sohu.flashplayer.views
{
    import com.sohu.fwork.view.*;
	import com.sohu.flashplayer.inter_pack.loading.ILoading;
	
    public class LoadingView extends View implements IView, ILoading
    {
        private var load:loading;
        public static const NAME:String = "loading";

        public function LoadingView()
        {
            return;
        }// end function

        public function high() : void
        {
            if (this.load)
            {
                this.removeChild(this.load);
            }
            this.load = null;
            return;
        }// end function

        public function show() : void
        {
            if (this.load == null)
            {
                this.load = new loading();
                this.addChild(this.load);
            }
            this.resize(this.stage.stageWidth, this.stage.stageHeight);
            return;
        }// end function

        override public function resize(param1:int, param2:int) : void
        {
            if (this.load)
            {
                this.load.x = param1 / 2 - this.load.width / 2;
                this.load.y = param2 / 2 - this.load.height;
            }
            return;
        }// end function

    }
}
