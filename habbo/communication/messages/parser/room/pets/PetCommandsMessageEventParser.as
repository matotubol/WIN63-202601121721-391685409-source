package com.sulake.habbo.communication.messages.parser.room.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetCommandsMessageEventParser implements IMessageParser
   {
      
      private var var_2751:int;
      
      private var var_2517:Array;
      
      private var var_2317:Array;
      
      public function PetCommandsMessageEventParser()
      {
         super();
      }
      
      public function get petId() : int
      {
         return var_2751;
      }
      
      public function get allCommands() : Array
      {
         return var_2517;
      }
      
      public function get enabledCommands() : Array
      {
         return var_2317;
      }
      
      public function flush() : Boolean
      {
         var_2751 = -1;
         var_2517 = null;
         var_2317 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_2751 = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         var_2517 = [];
         while(_loc3_-- > 0)
         {
            var_2517.push(param1.readInteger());
         }
         var _loc2_:int = param1.readInteger();
         var_2317 = [];
         while(_loc2_-- > 0)
         {
            var_2317.push(param1.readInteger());
         }
         return true;
      }
   }
}

