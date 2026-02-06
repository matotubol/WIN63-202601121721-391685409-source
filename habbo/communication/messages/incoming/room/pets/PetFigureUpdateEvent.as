package com.sulake.habbo.communication.messages.incoming.room.pets
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.pets.PetFigureUpdateEventParser;
   
   [SecureSWF(rename="true")]
   public class PetFigureUpdateEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PetFigureUpdateEvent(param1:Function)
      {
         super(param1,PetFigureUpdateEventParser);
      }
      
      public function getParser() : PetFigureUpdateEventParser
      {
         return var_15 as PetFigureUpdateEventParser;
      }
   }
}

