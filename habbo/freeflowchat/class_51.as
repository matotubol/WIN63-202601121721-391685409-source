package com.sulake.habbo.freeflowchat
{
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.habbo.freeflowchat.style.class_2244;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   
   public interface class_51 extends IUnknown
   {
      
      function get displayObject() : DisplayObject;
      
      function get chatStyleLibrary() : class_2244;
      
      function get isDisabledInPreferences() : Boolean;
      
      function set isDisabledInPreferences(param1:Boolean) : void;
      
      function get preferedChatStyle() : int;
      
      function set preferedChatStyle(param1:int) : void;
      
      function createPreviewBitmap(param1:String, param2:int) : BitmapData;
      
      function clear() : void;
      
      function toggleVisibility() : void;
      
      function set visible(param1:Boolean) : void;
   }
}

