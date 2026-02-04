package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   
   public class RoomThumbnailWidget implements IRoomThumbnailWidget
   {
      
      public static const TYPE:String = "room_thumbnail";
      
      private var var_210:class_2010;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_134:class_1812;
      
      public function RoomThumbnailWidget(param1:class_2010, param2:HabboWindowManagerComponent)
      {
         super();
         var_210 = param1;
         _windowManager = param2;
         var_134 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("room_thumbnail_xml").content as XML) as class_1812;
         var_210.rootWindow = var_134;
         var_134.width = var_210.width;
         var_134.height = var_210.height;
      }
      
      public function reset() : void
      {
      }
      
      public function set flatId(param1:int) : void
      {
      }
      
      public function get properties() : Array
      {
         return null;
      }
      
      public function set properties(param1:Array) : void
      {
      }
      
      public function dispose() : void
      {
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function get iterator() : IIterator
      {
         return null;
      }
   }
}

