package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.class_1901;
   
   public interface IIlluminaInputWidget extends class_1901
   {
      
      function get message() : String;
      
      function set message(param1:String) : void;
      
      function get submitHandler() : IIlluminaInputHandler;
      
      function set submitHandler(param1:IIlluminaInputHandler) : void;
      
      function get buttonCaption() : String;
      
      function set buttonCaption(param1:String) : void;
      
      function get emptyMessage() : String;
      
      function set emptyMessage(param1:String) : void;
      
      function get multiline() : Boolean;
      
      function set multiline(param1:Boolean) : void;
      
      function get maxChars() : int;
      
      function set maxChars(param1:int) : void;
   }
}

