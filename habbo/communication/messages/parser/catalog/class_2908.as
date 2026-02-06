package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2908
   {
      
      private var var_230:int;
      
      private var var_3980:int;
      
      private var var_3349:int;
      
      private var var_3034:Boolean;
      
      private var var_4247:Boolean;
      
      public function class_2908(param1:IMessageDataWrapper)
      {
         super();
         var_230 = param1.readInteger();
         var_3980 = param1.readInteger();
         var_3349 = param1.readInteger();
         var_3034 = param1.readBoolean();
         var_4247 = param1.readBoolean();
      }
      
      public function get type() : int
      {
         return var_230;
      }
      
      public function get breedId() : int
      {
         return var_3980;
      }
      
      public function get paletteId() : int
      {
         return var_3349;
      }
      
      public function get sellable() : Boolean
      {
         return var_3034;
      }
      
      public function get rare() : Boolean
      {
         return var_4247;
      }
   }
}

