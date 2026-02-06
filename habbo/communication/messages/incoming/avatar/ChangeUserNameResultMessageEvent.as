package com.sulake.habbo.communication.messages.incoming.avatar
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.avatar.ChangeUserNameResultMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ChangeUserNameResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public static var var_1851:int = 0;
      
      public static var var_4470:int = 1;
      
      public static var var_2697:int = 2;
      
      public static var var_2917:int = 3;
      
      public static var var_3157:int = 4;
      
      public static var var_3330:int = 5;
      
      public static var var_2518:int = 6;
      
      public static var var_3721:int = 7;
      
      public function ChangeUserNameResultMessageEvent(param1:Function)
      {
         super(param1,ChangeUserNameResultMessageEventParser);
      }
      
      public function getParser() : ChangeUserNameResultMessageEventParser
      {
         return var_15 as ChangeUserNameResultMessageEventParser;
      }
   }
}

