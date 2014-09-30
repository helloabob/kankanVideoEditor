package easy.hub.ent
{
    import easy.edit.ent.*;
    import easy.hub.evt.*;
    import easy.hub.pro.*;
    import flash.display.*;
    import flash.events.*;
    import flash.ui.*;

    public class KeyPressMgr extends Object
    {
        private var edit:EditContext;

        public function KeyPressMgr(param1:Stage)
        {
            this.edit = EasyFactory.to.getCompIns(EditContext);
            param1.addEventListener(KeyboardEvent.KEY_DOWN, this.keyPressed);
            return;
        }// end function

        private function keyPressed(event:KeyboardEvent) : void
        {
            switch(event.keyCode)
            {
                case Keyboard.F:
                {
                    this.edit.noti(new KeyPressedEvt(KeyPressedEvt.SET_END_PT));
                    break;
                }
				case Keyboard.O:
				{
					this.edit.noti(new KeyPressedEvt(KeyPressedEvt.SET_END_PT));
					break;
				}
                case Keyboard.S:
                {
                    this.edit.noti(new KeyPressedEvt(KeyPressedEvt.SET_START_PT));
                    break;
                }
				case Keyboard.I:
				{
					this.edit.noti(new KeyPressedEvt(KeyPressedEvt.SET_START_PT));
					break;
				}
                case Keyboard.LEFT:
                {
                    this.edit.noti(new KeyPressedEvt(KeyPressedEvt.TO_LEFT));
                    break;
                }
                case Keyboard.RIGHT:
                {
                    this.edit.noti(new KeyPressedEvt(KeyPressedEvt.TO_RIGHT));
                    break;
                }
                case Keyboard.Z:
                {
                    this.edit.noti(new KeyPressedEvt(KeyPressedEvt.UNDO));
                    break;
                }
                case Keyboard.SPACE:
                {
                    this.edit.noti(new KeyPressedEvt(KeyPressedEvt.TOGGLE_PLAY));
                    break;
                }
				case Keyboard.LEFTBRACKET:
				{
					this.edit.noti(new KeyPressedEvt(KeyPressedEvt.LEFT_BRACKET));
					break;
				}
				case Keyboard.RIGHTBRACKET:
				{
					this.edit.noti(new KeyPressedEvt(KeyPressedEvt.RIGHT_BRACKET));
					break;
				}
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
