package com.sulake.habbo.navigator
{
   import com.sulake.core.window.components.ITextWindow;
   
   public class class_4017 implements class_3858
   {
      
      private var _value:String;
      
      private var _text:ITextWindow;
      
      private var var_531:int;
      
      public function class_4017()
      {
         super();
      }
      
      public function test(param1:int) : Boolean
      {
         _text.text = _value.substring(0,param1) + "...";
         return _text.textHeight > var_531;
      }
      
      public function beforeSearch(param1:String, param2:ITextWindow, param3:int) : void
      {
         _value = param1;
         _text = param2;
         var_531 = param3;
      }
   }
}

