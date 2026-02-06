package com.sulake.habbo.communication.messages.parser.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2838
   {
      
      private var var_197:int;
      
      private var _name:String;
      
      private var var_656:class_2486;
      
      private var var_2493:int;
      
      public function class_2838(param1:IMessageDataWrapper)
      {
         super();
         var_197 = param1.readInteger();
         _name = param1.readString();
         var_656 = new class_2486(param1);
         var_2493 = param1.readInteger();
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get typeId() : int
      {
         return var_656.typeId;
      }
      
      public function get paletteId() : int
      {
         return var_656.paletteId;
      }
      
      public function get color() : String
      {
         return var_656.color;
      }
      
      public function get breedId() : int
      {
         return var_656.breedId;
      }
      
      public function get customPartCount() : int
      {
         return var_656.customPartCount;
      }
      
      public function get figureString() : String
      {
         return var_656.figureString;
      }
      
      public function get figureData() : class_2486
      {
         return var_656;
      }
      
      public function get level() : int
      {
         return var_2493;
      }
   }
}

