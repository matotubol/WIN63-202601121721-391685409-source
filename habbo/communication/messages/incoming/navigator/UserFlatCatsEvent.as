package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.UserFlatCatsEventParser;
   
   [SecureSWF(rename="true")]
   public class UserFlatCatsEvent extends MessageEvent implements IMessageEvent
   {
      
      public function UserFlatCatsEvent(param1:Function)
      {
         super(param1,UserFlatCatsEventParser);
      }
      
      public function getParser() : UserFlatCatsEventParser
      {
         return this.var_15 as UserFlatCatsEventParser;
      }
   }
}

