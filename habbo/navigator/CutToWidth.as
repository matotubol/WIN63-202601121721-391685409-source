package com.sulake.habbo.navigator
{
   import com.sulake.core.window.components.ITextWindow;
   
   public class CutToWidth implements class_3858
   {
      
      private var _value:String;
      
      private var _text:ITextWindow;
      
      private var _maxWidth:int;
      
      public function CutToWidth()
      {
         super();
      }
      
      public function test(param1:int) : Boolean
      {
         _text.text = _value.substring(0,param1) + "...";
         return _text.textWidth > _maxWidth;
      }
      
      public function beforeSearch(param1:String, param2:ITextWindow, param3:int) : void
      {
         _value = param1;
         _text = param2;
         _maxWidth = param3;
      }
   }
}

