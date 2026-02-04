package com.sulake.habbo.friendbar.view.tabs.tokens
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.motion.DropBounce;
   import com.sulake.core.window.motion.class_2939;
   import com.sulake.habbo.friendbar.data.class_2307;
   import com.sulake.habbo.game.class_45;
   import com.sulake.habbo.window.class_38;
   import flash.geom.Rectangle;
   
   public class Token implements class_13
   {
      
      protected static var _WINDOW_MANAGER:class_38;
      
      protected static var var_3895:class_40;
      
      protected static var _GAMES:class_45;
      
      protected static const TITLE:String = "title";
      
      protected static const MESSAGE:String = "message";
      
      protected static const ICON_RECTANGLE:Rectangle = new Rectangle(0,0,25,25);
      
      protected var _icon:IRegionWindow;
      
      protected var _window:class_1812;
      
      protected var _disposed:Boolean;
      
      protected var var_2193:class_2307;
      
      public function Token(param1:class_2307)
      {
         super();
         var_2193 = param1;
      }
      
      public static function set WINDOWING(param1:class_38) : void
      {
         _WINDOW_MANAGER = param1;
      }
      
      public static function set ASSETS(param1:class_40) : void
      {
         var_3895 = param1;
      }
      
      public static function set GAMES(param1:class_45) : void
      {
         _GAMES = param1;
      }
      
      public function get typeCode() : int
      {
         return var_2193.typeCode;
      }
      
      public function get viewOnce() : Boolean
      {
         return var_2193.viewOnce;
      }
      
      public function get notification() : class_2307
      {
         return var_2193;
      }
      
      public function get iconElement() : class_1741
      {
         return _icon;
      }
      
      public function get windowElement() : class_1741
      {
         return _window;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(_icon)
         {
            _icon.dispose();
            _icon = null;
         }
         var_2193 = null;
         _disposed = true;
      }
      
      protected function prepare(param1:String, param2:String, param3:String, param4:String) : void
      {
         _window = _WINDOW_MANAGER.buildFromXML(var_3895.getAssetByName(param3).content as XML) as class_1812;
         _window.findChildByName("title").caption = param1;
         _window.findChildByName("message").caption = param2 ? param2 : "";
         _icon = _WINDOW_MANAGER.create("ICON_" + typeCode,5,0,1,Token.ICON_RECTANGLE) as IRegionWindow;
         _icon.mouseThreshold = 0;
         var _loc5_:IStaticBitmapWrapperWindow = _WINDOW_MANAGER.create("BITMAP_" + typeCode,23,0,0,Token.ICON_RECTANGLE) as IStaticBitmapWrapperWindow;
         _loc5_.assetUri = param4;
         _icon.addChild(_loc5_);
         if(class_2939.getMotionByTarget(_icon) == null)
         {
            class_2939.runMotion(new DropBounce(_icon,600,32));
         }
      }
   }
}

