package com.sulake.habbo.communication.messages.incoming.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetReceivedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class PetReceivedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PetReceivedMessageEvent(param1:Function)
      {
         super(param1,PetReceivedMessageEventParser);
      }
      
      public function getParser() : PetReceivedMessageEventParser
      {
         return var_15 as PetReceivedMessageEventParser;
      }
   }
}

