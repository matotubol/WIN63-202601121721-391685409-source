package com.sulake.habbo.avatar.common
{
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   
   public class TabUtils
   {
      
      public function TabUtils()
      {
         super();
      }
      
      public static function setElementImage(param1:IStaticBitmapWrapperWindow, param2:Boolean) : void
      {
         var _loc3_:String = param1.assetUri.replace("_on","");
         param1.assetUri = param2 ? _loc3_ : _loc3_ + "_on";
      }
   }
}

