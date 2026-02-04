package com.sulake.habbo.notifications
{
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.utils.class_55;
   import flash.display.BitmapData;
   
   public interface class_536 extends IUnknown
   {
      
      function addItem(param1:String, param2:String, param3:String = null, param4:String = null, param5:Array = null) : void;
      
      function addItemWithBitmap(param1:String, param2:String, param3:BitmapData = null, param4:String = null, param5:Array = null) : void;
      
      function showNotification(param1:String, param2:class_55 = null) : void;
      
      function addSongPlayingNotification(param1:String, param2:String) : void;
   }
}

