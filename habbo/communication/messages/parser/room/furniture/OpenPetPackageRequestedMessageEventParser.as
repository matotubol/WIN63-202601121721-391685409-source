package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.class_2486;
   
   [SecureSWF(rename="true")]
   public class OpenPetPackageRequestedMessageEventParser implements IMessageParser
   {
      
      private var var_315:int = -1;
      
      private var var_656:class_2486;
      
      public function OpenPetPackageRequestedMessageEventParser()
      {
         super();
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
      
      public function get figureData() : class_2486
      {
         return var_656;
      }
      
      public function flush() : Boolean
      {
         var_315 = -1;
         var_656 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_315 = param1.readInteger();
         if(!param1.bytesAvailable)
         {
            return true;
         }
         var_656 = new class_2486(param1);
         return true;
      }
   }
}

