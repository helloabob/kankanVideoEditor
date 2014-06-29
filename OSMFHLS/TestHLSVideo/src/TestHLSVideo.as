package
{
//	import at.matthew.httpstreaming.HLSPluginInfo;
//	import at.matthew.httpstreaming.HTTPStreamingM3U8NetLoader;
	
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import org.osmf.containers.MediaContainer;
	import org.osmf.elements.VideoElement;
	import org.osmf.events.MediaFactoryEvent;
	import org.osmf.media.MediaElement;
	import org.osmf.media.MediaFactory;
	import org.osmf.media.MediaFactoryItem;
	import org.osmf.media.MediaPlayer;
	import org.osmf.media.PluginInfoResource;
	import org.osmf.media.URLResource;
	import org.osmf.net.NetLoader;
	import org.osmf.net.httpstreaming.hls.HLSPluginInfo;
	
	public class TestHLSVideo extends Sprite
	{
		
		private var offset:int = 0;
		private var element:MediaElement;
		
		public var player:MediaPlayer;
		public var container:MediaContainer;
		private var factory:MediaFactory;
		
		public static const STREAMING_MP4_PATH:String = "rtmp://cp67126.edgefcs.net/ondemand/mp4:mediapm/ovp/content/demo/video/elephants_dream/elephants_dream_768x428_24.0fps_408kbps.mp4";
		public static const MP4_TEST:String = "http://domhttp.kksmg.com/2013/01/31/h264_800k_mp4_d67b2cb5025e42c6abb2a3983af2ba94_2441692.mp4";
		public static const HLS_TEST_PATH:String = "http://www.codecomposer.net/hls/bipbop/gear4/prog_index.m3u8?start={0}";
		public static const APPLE_TEST:String = "http://developer.apple.com/resources/http-streaming/examples/basic-stream.html";
		//public static const HLS_TEST:String = "http://www.codecomposer.net/hls/playlist.m3u8";
		//public static const HLS_TEST:String = "http://v.youku.com/player/getRealM3U8/vid/XNDUwNjc4MzA4/type/mp4/v.m3u8";
		//public static const HLS_TEST:String = "http://hls.kksmg.com/iphone/downloads/ch1/index.m3u8";
		//public static const HLS_TEST:String = "http://64k.kankanews.com/hls-smgvod/2013/01/31/h264_450k_mp4_ea7641ae0677449e980fa452f65b5e96_2441606.mp4.m3u8";
		//public static const HLS_TEST:String = "http://114.80.151.66/hls/dfws/index.m3u8";
//		public static const HLS_TEST:String = "http://114.80.151.66/hls/shss/index.m3u8";
		public static const HLS_TEST:String = "http://segment.livehls.kksmg.com/m3u8/216_1403746090.m3u8?start={0}";
		
		public function TestHLSVideo()
		{
			initPlayer();
		}
		
		private function initPlayer():void {
			factory = new MediaFactory();
			factory.addEventListener(MediaFactoryEvent.PLUGIN_LOAD, handlePluginLoad);
			factory.addEventListener(MediaFactoryEvent.PLUGIN_LOAD_ERROR, handlePluginLoadError);
			factory.loadPlugin(new PluginInfoResource(new HLSPluginInfo()));
			
			//the pointer to the media
			var resource:URLResource = new URLResource( HLS_TEST_PATH.replace("{0}",0) );
			
			// Only need to specify content-type if the m3u8 playlist does not
			// have a .m3u8 extension.
//			resource.addMetadataValue("content-type", "application/x-mpegURL");
			
			element = factory.createMediaElement(resource);
			if (element === null) {
				throw new Error("Unsupported media type!");
			}
			
			//the simplified api controller for media
			player = new MediaPlayer( element );
			player.autoRewind = false;
//			player.bufferTime = 4;
			
//			flash.utils.setTimeout(onSeek,20000);
			
			//the container (sprite) for managing display and layout
			container = new MediaContainer();
			container.addMediaElement( element );
//			container.scaleX = 0.5;
//			container.scaleY = 0.5;
			
			//Adds the container to the stage
			this.addChild( container );
			
//			flash.utils.setInterval(tt,500);
			
			var sp:Sprite=new Sprite();
			sp.graphics.beginFill(0x00ff00,1);
			sp.graphics.drawRect(10,10,100,30);
			sp.graphics.endFill();
			sp.addEventListener(MouseEvent.CLICK,onClick);
			this.addChild(sp);
			
		}
		
		private function onClick(evt:MouseEvent):void{
			offset+=120;
//			player.seek(offset);
			container.removeMediaElement(element);
			var resource:URLResource = new URLResource( HLS_TEST_PATH.replace("{0}",offset) );
			element = factory.createMediaElement(resource);
			player.media=element;
			container.addMediaElement(element);
		}
		
		private function tt():void{
			trace("time:"+player.currentTime);
		}
		
		private function onSeek():void{
			trace("----------------------------------start to seek--------------------------------");
			player.seek(300);
		}
		
		private function handlePluginLoad(event:MediaFactoryEvent):void {
			var pluginType:String = "Unknown Plugin";
			if (event.resource is PluginInfoResource) {
				var item:MediaFactoryItem = (event.resource as PluginInfoResource).pluginInfo.getMediaFactoryItemAt(0);
				if (item) {
					pluginType = item.id;
				}
			}
			trace("Plugin \"" + pluginType + "\" loaded.");
		}
		
		private function handlePluginLoadError(event:MediaFactoryEvent):void {
			var pluginType:String = "Unknown Plugin";
			if (event.resource is PluginInfoResource) {
				var item:MediaFactoryItem = (event.resource as PluginInfoResource).pluginInfo.getMediaFactoryItemAt(0);
				if (item) {
					pluginType = item.id;
				}
			}
			trace("Plugin \"" + pluginType + "\" load error.");
		}
	}
}