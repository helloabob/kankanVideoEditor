package easy.scr.sys.stg.viw
{
    import easy.scr.pro.ScrFactory;
    import easy.scr.sys.com.dat.PlayDat;
    
    import flash.display.*;
    import flash.media.*;
    import flash.net.*;
    
    import vsin.dcw.support.*;

    public class Screen extends Sprite
    {
        private var vd:Video;
        private var fuckRightClick:Sprite;
		
		private var dat:PlayDat;

        public function Screen()
        {
            return;
        }// end function

        public function init(param1:String) : void
        {
			dat = ScrFactory.to.getCompIns(PlayDat);
            this.name = param1;
            this.vd = new Video();
            this.vd.smoothing = true;
            this.fuckRightClick = new Sprite();
            addChild(this.vd);
            addChild(this.fuckRightClick);
            return;
        }// end function

        public function resize(param1:Number, param2:Number) : void
        {
			if(dat.ishls){
				dat.mps.width=param1;
				dat.mps.height=param2;
			}else{
            	this.vd.width = param1;
            	this.vd.height = param2;
			}
            this.fuckRightClick.graphics.clear();
            this.fuckRightClick.graphics.beginFill(0, 0);
            this.fuckRightClick.graphics.drawRect(0, 0, param1, param2);
            this.fuckRightClick.graphics.endFill();
            return;
        }// end function

        public function attachStm(param1:NetStream) : void
        {
			if(dat.ishls)this.addChild(dat.mps);
			else{
            	this.vd.attachNetStream(param1);
            	this.vd.clear();
			}
            Trace.log(name + " vd attached");
            return;
        }// end function

        public function detachStm() : void
        {
			if(dat.ishls){
				if(this.contains(dat.mps)){
					this.removeChild(dat.mps);
				}
			}
			else this.vd.attachNetStream(null);
            return;
        }// end function

    }
}
