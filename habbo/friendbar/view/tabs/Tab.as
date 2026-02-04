package com.sulake.habbo.friendbar.view.tabs
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.friendbar.data.class_1813;
   import com.sulake.habbo.friendbar.view.class_1962;
   import com.sulake.habbo.friendbar.view.utils.TextCropper;
   import com.sulake.habbo.friendlist.class_258;
   import com.sulake.habbo.game.class_45;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.tracking.class_53;
   import com.sulake.habbo.window.class_38;
   import flash.geom.Point;
   
   public class Tab implements ITab
   {
      
      public static var WIDTH:int = 127;
      
      public static var HEIGHT:int = 36;
      
      public static var DATA:class_1813;
      
      public static var FRIENDS:class_258;
      
      public static var GAMES:class_45;
      
      public static var VIEW:class_1962;
      
      public static var ASSETS:class_40;
      
      public static var WINDOWING:class_38;
      
      public static var var_439:class_27;
      
      public static var TRACKING:class_53;
      
      public static var CROPPER:TextCropper;
      
      public static var AVATAR_RENDER_MANAGER:class_48;
      
      protected static const const_793:Boolean = false;
      
      protected static const _MOTION_TIME:int = 80;
      
      protected static const const_324:int = 3;
      
      protected var _window:class_1812;
      
      protected var var_123:Boolean;
      
      private var var_3064:Boolean;
      
      private var _selected:Boolean;
      
      private var _disposed:Boolean;
      
      public function Tab()
      {
         super();
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function get recycled() : Boolean
      {
         return var_123;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      protected function get exposed() : Boolean
      {
         return var_3064;
      }
      
      public function select(param1:Boolean) : void
      {
         conceal();
         _selected = true;
      }
      
      public function deselect(param1:Boolean) : void
      {
         _selected = false;
      }
      
      public function recycle() : void
      {
         conceal();
         var_123 = true;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_window)
            {
               _window.dispose();
               _window = null;
            }
            _disposed = true;
         }
      }
      
      protected function expose() : void
      {
         var_3064 = true;
      }
      
      protected function conceal() : void
      {
         var_3064 = false;
      }
      
      protected function onMouseClick(param1:WindowMouseEvent) : void
      {
         if(disposed || recycled)
         {
            return;
         }
         if(selected)
         {
            VIEW.deSelect(true);
         }
         else
         {
            VIEW.selectTab(this,true);
         }
      }
      
      protected function onMouseOver(param1:WindowMouseEvent) : void
      {
         if(disposed || recycled)
         {
            return;
         }
         if(!selected)
         {
            expose();
         }
      }
      
      protected function onMouseOut(param1:WindowMouseEvent) : void
      {
         if(disposed || recycled || _window == null)
         {
            return;
         }
         if(!selected)
         {
            if(!_window.hitTestGlobalPoint(new Point(param1.stageX,param1.stageY)))
            {
               conceal();
            }
         }
      }
   }
}

