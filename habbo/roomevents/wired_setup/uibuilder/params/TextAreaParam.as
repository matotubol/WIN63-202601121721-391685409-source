package com.sulake.habbo.roomevents.wired_setup.uibuilder.params
{
   public class TextAreaParam
   {
      
      private var var_385:int;
      
      private var _width:int;
      
      private var var_4058:int;
      
      private var var_4736:int;
      
      private var _maxCharacters:int;
      
      private var var_3907:String;
      
      private var var_563:String;
      
      private var var_4525:String;
      
      private var var_2648:Boolean;
      
      public function TextAreaParam(param1:int, param2:int = -1, param3:int = -1, param4:int = -1, param5:int = 1000, param6:String = "", param7:String = null, param8:String = null, param9:Boolean = true)
      {
         super();
         var_385 = param1;
         _width = param2;
         var_4058 = param3;
         var_4736 = param4;
         _maxCharacters = param5;
         var_3907 = param6;
         var_563 = param7;
         var_4525 = param8;
         var_2648 = param9;
      }
      
      public function get height() : int
      {
         return var_385;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get maxLines() : int
      {
         return var_4058;
      }
      
      public function get maxCharactersPerLine() : int
      {
         return var_4736;
      }
      
      public function get maxCharacters() : int
      {
         return _maxCharacters;
      }
      
      public function get initialText() : String
      {
         return var_3907;
      }
      
      public function get placeholder() : String
      {
         return var_563;
      }
      
      public function get editable() : Boolean
      {
         return var_2648;
      }
      
      public function get restrict() : String
      {
         return var_4525;
      }
   }
}

