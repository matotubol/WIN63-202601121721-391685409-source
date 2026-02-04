package com.sulake.habbo.roomevents.wired_setup.uibuilder.params
{
   public class TextInputParam
   {
      
      public static var DEFAULT:TextInputParam = new TextInputParam();
      
      private var var_3907:String;
      
      private var _maxCharacters:int;
      
      private var var_563:String;
      
      private var _width:int;
      
      private var var_4525:String;
      
      private var var_2648:Boolean;
      
      public function TextInputParam(param1:String = "", param2:int = 1000, param3:String = null, param4:int = -1, param5:String = null, param6:Boolean = true)
      {
         super();
         var_3907 = param1;
         _maxCharacters = param2;
         var_563 = param3;
         _width = param4;
         var_4525 = param5;
         var_2648 = param6;
      }
      
      public function get initialText() : String
      {
         return var_3907;
      }
      
      public function get maxCharacters() : int
      {
         return _maxCharacters;
      }
      
      public function get placeholder() : String
      {
         return var_563;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get restrict() : String
      {
         return var_4525;
      }
      
      public function get editable() : Boolean
      {
         return var_2648;
      }
   }
}

