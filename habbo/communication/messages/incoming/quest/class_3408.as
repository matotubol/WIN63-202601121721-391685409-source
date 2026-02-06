package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.quest.class_3690;
   
   [SecureSWF(rename="true")]
   public class class_3408 extends MessageEvent implements IMessageEvent
   {
      
      public function class_3408(param1:Function)
      {
         super(param1,class_3690);
      }
      
      public function getParser() : class_3690
      {
         return this.var_15 as class_3690;
      }
   }
}

